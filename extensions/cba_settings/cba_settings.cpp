#include <iostream>
#include <fstream>
#include <string>
#include <algorithm>
#include "trim.h"

#define VERSION "1.0.0"

#define RET \
strncpy_s(output, outputSize, result.c_str(), _TRUNCATE);\
return

#define RETURN(val)\
strncpy_s(output, outputSize, result.c_str(), _TRUNCATE);\
return (val)

#define SYNTAX_ERROR_WRONG_PARAMS_SIZE 101
#define SYNTAX_ERROR_WRONG_PARAMS_TYPE 102
#define PARAMS_ERROR_TOO_MANY_ARGS 201
#define EXECUTION_WARNING_TAKES_TOO_LONG 301

#define TEMP_FILE "userconfig/temp"
#define SETTINGS_FILE "userconfig/cba_settings.sqf"
#define DELIM ":"
#define MAX_CALLBACK_LENGTH 10000

using namespace std;

string version() {
    return VERSION;
}

string clear() {
    ofstream file;
    file.open(SETTINGS_FILE, ios::out);
    file.close();
    return "true";
}

string load(int strlen) {
    string result = "";

    ifstream file;
    file.open(SETTINGS_FILE, ios::in);

    string line;
    while (file.good()) {
        getline(file, line);
        if (file.good() || line.length() != 0) // Don't explode file by appending duplicate additional newlines.
            result = result + trim(line) + "\n";
    }

    file.close();

    if (strlen * MAX_CALLBACK_LENGTH > result.length())
        return "";

    result = result.substr(strlen * MAX_CALLBACK_LENGTH, MAX_CALLBACK_LENGTH);
    return result;
}

string parse(int strlen) {
    string result = "[";

    ifstream file;
    file.open(SETTINGS_FILE, ios::in);

    string line;
    while (file.good()) {
        getline(file, line);
        line = trim_left(line);

        // Ignore commented out lines.
        if (line.substr(0, 2) == "//")
            continue;

        // Count force tags.
        int force = 0;
        while (line.substr(0, 6) == "force ") {
            force++;
            line = line.substr(6);
            line = trim_left(line);
        }

        // Get setting.
        size_t i = line.find("=");
        if (i == string::npos) // Ignore ill-formed line.
            continue;

        string item = line.substr(0, i);
        item = trim_right(item);

        // Get value.
        string value = line.substr(i + 1);
        value = trim(value);

        while (value.back() == ';')
            value.pop_back();

        value = trim_right(value);

        result = result + "[\"" + item + "\"," + value + "," + to_string(force) + "],";
    }

    file.close();

    result.pop_back();
    result.push_back(']');

    if (strlen * MAX_CALLBACK_LENGTH > result.length())
        return "";

    result = result.substr(strlen * MAX_CALLBACK_LENGTH, MAX_CALLBACK_LENGTH);
    return result;
}

string read(string setting) {
    string result = "[\"\",false,-1]";

    ifstream file;
    file.open(SETTINGS_FILE, ios::in);

    string line;
    while (file.good()) {
        getline(file, line);
        line = trim_left(line);

        // Ignore commented out lines.
        if (line.substr(0, 2) == "//")
            continue;

        // Count force tags.
        int force = 0;
        while (line.substr(0, 6) == "force ") {
            force++;
            line = line.substr(6);
            line = trim_left(line);
        }

        // Get setting.
        size_t i = line.find("=");
        if (i == string::npos) // Ignore ill-formed line.
            continue;

        string item = line.substr(0, i);
        item = trim_right(item);

        if (_stricmp(item.c_str(), setting.c_str()) == 0) {
            // Get value.
            string value = line.substr(i + 1);
            value = trim(value);

            while (value.back() == ';')
                value.pop_back();

            value = trim_right(value);

            result = "[\"" + item + "\"," + value + "," + to_string(force) + "]";
            break;
        }
    }

    file.close();
    return result;
}

string append(string setting, string value, int force) {
    ofstream file;
    file.open(SETTINGS_FILE, ios::app);

    string line = "";
    while (force-- > 0)
        line = line + "force ";

    line = line + setting + " = " + value + ";";

    file << line << endl;
    file.close();
    return "true";
}

string write(string setting, string value, int force) {
    string result = "false";

    ofstream temp;
    temp.open(string(TEMP_FILE).c_str(), ios::out);

    ifstream file;
    file.open(SETTINGS_FILE, ios::in);

    string line;
    while (file.good()) {
        getline(file, line);
        line = trim_left(line);
        string orig = trim_right(line);

        if (line.length() == 0 || result == "true") {
            if (file.good()) // Don't explode file by appending duplicate additional newlines.
                temp << orig << endl;

            continue;
        }

        // Keep commented out lines.
        if (line.substr(0, 2) == "//") {
            temp << orig << endl;
            continue;
        }

        // Strip force tags.
        while (line.substr(0, 6) == "force ") {
            line = line.substr(6);
            line = trim_left(line);
        }

        // Get setting.
        size_t i = line.find("=");
        if (i == string::npos) // Remove ill-formed line.
            continue;

        string item = line.substr(0, i);
        item = trim_right(item);

        if (_stricmp(item.c_str(), setting.c_str()) == 0) {
            // Updade matching lines.
            line = "";
            while (force-- > 0)
                line = line + "force ";

            line = line + setting + " = " + value + ";";

            temp << line << endl;
            result = "true";
        } else {
            // Keep non-matching lines.
            temp << orig << endl;
        }
    }

    temp.close();
    file.close();

    if (result == "true") {
        remove(SETTINGS_FILE);
        rename(TEMP_FILE, SETTINGS_FILE);
    } else {
        remove(TEMP_FILE);
        result = append(setting, value, force);
    };

    return result;
}

extern "C" {
    __declspec(dllexport) void __stdcall RVExtensionVersion(char* output, int outputSize);
    __declspec(dllexport) void __stdcall RVExtension(char* output, int outputSize, const char* function);
    __declspec(dllexport) int __stdcall RVExtensionArgs(char* output, int outputSize, const char* function, const char** args, int argsCnt);
}

void __stdcall RVExtensionVersion(char* output, int outputSize) {
    strncpy_s(output, outputSize, VERSION, _TRUNCATE);
}

void __stdcall RVExtension(char* output, int outputSize, const char* function) {
    string result = "false";

    if (_stricmp(function, "version") == 0) {
        result = version();
        RET;
    }

    RET;
}

int __stdcall RVExtensionArgs(char* output, int outputSize, const char* function, const char** args, int argsCnt) {
    string result = "false";

    if (argsCnt > 3) {
        RETURN(PARAMS_ERROR_TOO_MANY_ARGS);
    }

    string setting = "";
    if (argsCnt >= 1) {
        setting = args[0];
        if (setting.substr(0, 1) == "\"") // Strip extra quote marks.
            setting = setting.substr(1, setting.length() - 2);
    }

    string value = "";
    if (argsCnt >= 2)
        value = args[1];

    int force = 0;
    if (argsCnt >= 3)
        force = min(stoi(args[2]), 2);

    if (_stricmp(function, "version") == 0) {
        result = version();
        RETURN(0);
    }

    if (_stricmp(function, "clear") == 0) {
        result = clear();
        RETURN(0);
    }

    if (_stricmp(function, "load") == 0) {
        int strlen = stoi(setting);
        result = load(strlen);
        RETURN(0);
    }

    if (_stricmp(function, "parse") == 0) {
        int strlen = stoi(setting);
        result = parse(strlen);
        RETURN(0);
    }

    if (_stricmp(function, "read") == 0) {
        result = read(setting);
        RETURN(0);
    }

    if (_stricmp(function, "append") == 0) {
        result = append(setting, value, force);
        RETURN(0);
    }

    if (_stricmp(function, "write") == 0) {
        result = write(setting, value, force);
        RETURN(0);
    }

    RETURN(1);
}

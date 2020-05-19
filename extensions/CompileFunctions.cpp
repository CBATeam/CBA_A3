// PabstMirror

#include <iostream>
#include <sstream>
#include <fstream>
#include <filesystem>

constexpr auto VERSION_STR = "v0.0.1";

extern "C" {
    __declspec(dllexport) void __stdcall RVExtension(char* output, int outputSize, const char* function);
    __declspec(dllexport) void __stdcall RVExtensionVersion(char* output, int outputSize);
	__declspec(dllexport) int __stdcall RVExtensionArgs(char* output, int outputSize, const char* function, const char** argv, int argc);
}

bool cleanupFnc(std::string& s) {
    if (s.size() < 2) { return false; }
    s = s.substr(1, s.size() - 2); // strip {}

    std::size_t meatStart = -1;
    std::size_t index = 0;
    while (index < s.size() && meatStart == -1) {
        if (s[index] == '#') { index = s.find('\n', index); } // comment, skip to next newline
        else if (s[index] == '\n') { index++; } // newline
        else if (s[index] == ' ') { index++; } // space
        else if (s[index] == '\t') { index++; } // tab
        else if (s[index] == ';') { index++; } // rouge semi-colon from some macro
        else { meatStart = index; }
    }

    if (meatStart >= s.size()) {
        s = "";
    } else {
        s = s.substr(meatStart, s.size());
    }
    return true;
}


void __stdcall RVExtensionVersion(char* output, int outputSize) {
    strncpy(output, VERSION_STR, outputSize);
}
void __stdcall RVExtension(char* output, int outputSize, const char* function) {
    RVExtensionVersion(output, outputSize);
}
int __stdcall RVExtensionArgs(char* output, int outputSize, const char* function, const char** argv, int argc){
    std::string fncPath(function);

    std::string compiledFnc;
    for (int i = 0; i < argc; i++) { compiledFnc += argv[i]; }
    if (!cleanupFnc(compiledFnc)) { return -1; } // -1 = cleanup failed

    std::filesystem::path actualPath { "P:\\" };
    if (!std::filesystem::exists(actualPath)) { return -2; } // -2 = no p drive
    actualPath /= fncPath;
    if (!std::filesystem::exists(actualPath)) { return -3; } // -3 = doesn't exist

    std::error_code ec;
    std::filesystem::remove(actualPath, ec); // delete existing file
    if (ec) { return -4; }; // -4 = still locked by something (try tabbing out of arma)

    std::ofstream ofs(actualPath);
    ofs << compiledFnc;
    ofs.close();

    std::stringstream ss;
    ss << "Compiled to " << actualPath;
    strncpy(output, ss.str().c_str(), outputSize);

    return 1;
}

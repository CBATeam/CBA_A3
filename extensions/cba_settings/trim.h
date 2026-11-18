#include <string>

using namespace std;

const string WHITESPACE = " \n\r\f\t\v";

string trim_left(string str) {
    size_t first = str.find_first_not_of(WHITESPACE);

    if (first == string::npos)
        return "";
    else
        return str.substr(first);
}

string trim_right(string str) {
    size_t last = str.find_last_not_of(WHITESPACE);

    if (last == string::npos)
        return "";
    else
        return str.substr(0, last + 1);
}

string trim(string str) {
    size_t first = str.find_first_not_of(WHITESPACE);
    size_t last = str.find_last_not_of(WHITESPACE);

    if (first == last)
        return "";
    else
        return str.substr(first, last - first + 1);
}


#define F_FILEPATH(func) class func {\
    file = QUOTE(PATHTOF(DOUBLES(fnc,func).sqf));\
}

class CfgFunctions {
    class CBA {
        class Versioning {
            F_FILEPATH(formatVersionNumber);
            F_FILEPATH(logVersion);
            F_FILEPATH(errorMessage);
            F_FILEPATH(compareVersions);
            F_FILEPATH(checkDependencies);
        };
    };
};

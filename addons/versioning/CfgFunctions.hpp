
#define F_FILEPATH(func) class func {\
    file = QUOTE(PATHTOF(DOUBLES(fnc,func).sqf));\
}

class CfgFunctions {
    class CBA {
        class Versioning {
            F_FILEPATH(compareVersions);
            F_FILEPATH(errorMessage);
        };
    };
};

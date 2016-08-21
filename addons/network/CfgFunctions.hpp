
#define F_FILEPATH(func) class func {\
    file = QUOTE(PATHTOF(DOUBLES(fnc,func).sqf));\
}

class CfgFunctions {
    class CBA {
        class Network {
            F_FILEPATH(globalExecute);
            F_FILEPATH(globalSay);
            F_FILEPATH(globalSay3d);
            F_FILEPATH(publicVariable);
            F_FILEPATH(setVarNet);
        };
    };
};


#define F_FILEPATH(comp,func) class func {\
    file = __EVAL([QUOTE(PATHTOEF(comp,DOUBLES(fnc,func).sqf)), QUOTE(PATHTOEF(comp,TRIPLES(fnc,func,Linux).sqf))] select IS_LINUX);\
}

class CfgFunctions {
    class CBA {
        class Entities {
            F_FILEPATH(common,getAlive);
        };
    };
};

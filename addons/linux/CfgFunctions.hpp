
#define F_FILEPATH(comp,func) class func {\
    file = __EVAL([QUOTE(PATHTOEF(comp,DOUBLES(fnc,func).sqf)), QUOTE(PATHTOEF(comp,TRIPLES(fnc,func,Linux).sqf))] select IS_LINUX);\
}

class CfgFunctions {
    class CBA {
        class Entities {
            F_FILEPATH(common,getAlive);
            F_FILEPATH(common,getMagazineIndex);
        };

        class Vehicles {
            F_FILEPATH(common,vehicleRole);
            F_FILEPATH(common,turretPath);
            F_FILEPATH(common,turretPathWeapon);
        };

        class Inventory {
            F_FILEPATH(common,removeMagazine);
            F_FILEPATH(common,dropWeapon);
            F_FILEPATH(common,dropMagazine);
            F_FILEPATH(common,addBinocularMagazine);
        };

        class Events {
            F_FILEPATH(events,addPlayerEventHandler);
            F_FILEPATH(events,addKeyHandler);
            F_FILEPATH(events,targetEvent);
        };

        class Hashes {
            F_FILEPATH(hashes,hashCreate);
        };

        class JR {
            F_FILEPATH(jr,compatibleItems);
        };

        class XEH {
            F_FILEPATH(xeh,compileEventHandlers);
        };
    };
};

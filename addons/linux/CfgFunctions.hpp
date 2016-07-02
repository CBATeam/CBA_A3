
#define F_FILEPATH(comp,func) class func {\
    file = __EVAL([QUOTE(PATHTOEF(comp,DOUBLES(fnc,func).sqf)), QUOTE(PATHTOEF(comp,TRIPLES(fnc,func,Linux).sqf))] select IS_LINUX);\
}

class CfgFunctions {
    class A3_Bootcamp {
        class Inventory {
            F_FILEPATH(jr,compatibleItems);
        };
    };
    class CBA {

        class Anims {
            F_FILEPATH(common,headDir);
        };

        class Entities {
            F_FILEPATH(common,getAlive);
            F_FILEPATH(common,getMagazineIndex);
        };

        class Vehicles {
            F_FILEPATH(common,vehicleRole);
            F_FILEPATH(common,turretPath);
            F_FILEPATH(common,turretPathWeapon);
            F_FILEPATH(common,viewDir);
        };

        class Inventory {
            F_FILEPATH(common,removeMagazine);
            F_FILEPATH(common,dropWeapon);
            F_FILEPATH(common,dropMagazine);
            F_FILEPATH(common,addBinocularMagazine);
            F_FILEPATH(jr,compatibleItems);
        };

        class Arrays {
            F_FILEPATH(arrays,sortNestedArray);
        };

        class Events {
            F_FILEPATH(events,addPlayerEventHandler);
            F_FILEPATH(events,addKeyHandler);
            F_FILEPATH(events,targetEvent);
        };

        class Hashes {
            F_FILEPATH(hashes,hashCreate);
        };

        class XEH {
            F_FILEPATH(xeh,compileEventHandlers);
        };
    };
};


#define F_FILEPATH(func) class func {\
    file = QUOTE(PATHTOF(DOUBLES(fnc,func).sqf));\
}

class CfgFunctions {
    class CBA {
        class Network {
            F_FILEPATH(globalExecute);
            F_FILEPATH(globalSay);
            F_FILEPATH(globalSay3d);

            // CBA_fnc_getMarkerPersistent
            class getMarkerPersistent
            {
                description = "Checks if a global marker is persistent for JIP players.";
                file = "\x\cba\addons\network\fnc_getMarkerPersistent.sqf";
            };
            // CBA_fnc_publicVariable
            class publicVariable
            {
                description = "CBA_fnc_publicVariable does only broadcast the new value if it doesn't exist in missionNamespace or the new value is different to the one in missionNamespace. Checks also for different types. Nil as value gets always broadcasted.";
                file = "\x\cba\addons\network\fnc_publicVariable.sqf";
            };
            // CBA_fnc_setMarkerPersistent
            class setMarkerPersistent
            {
                description = "Sets or unsets JIP persistency on a global marker.";
                file = "\x\cba\addons\network\fnc_setMarkerPersistent.sqf";
            };
            // CBA_fnc_setVarNet
            class setVarNet
            {
                description = "Same as setVariable [""name"",var, true] but only broadcasts when the value of var is different to the one which is already saved in the variable space. Checks also for different types. Nil as value gets always broadcasted.";
                file = "\x\cba\addons\network\fnc_setVarNet.sqf";
            };
        };
    };
};

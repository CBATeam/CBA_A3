#include "script_component.hpp"

call {
    #include "\a3\functions_f\GUI\fn_initDisplay.sqf";
};

params [["_event", "", [""]], ["_args", []], ["_className", "", [""]]];

// translate BI event names to CBA event names
_event = ["", "DisplayLoad", "DisplayUnload"] param [["", "onload", "onunload"] find toLower _event, ""];

if !(_event isEqualTo "") then {
    {
        {
            private ["_event", "_className"];
            _args call compile getText _x;
        } forEach configProperties [_x >> XEH_FORMAT_CONFIG_NAME(_event) >> _className, "isText _x"];
    } forEach [configFile, campaignConfigFile, missionConfigFile];
};

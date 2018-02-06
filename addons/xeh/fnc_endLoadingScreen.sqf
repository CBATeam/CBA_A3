#include "script_component.hpp"

private _return = call {
    #include "\a3\functions_f\Misc\fn_endLoadingScreen.sqf";
};

isNil {
    [QGVAR(LoadingScreenEnded), _this] call CBA_fnc_localEvent;
};

RETNIL(_return) //scheduler safe

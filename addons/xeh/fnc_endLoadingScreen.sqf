#include "script_component.hpp"

private _return = call {
    #include "\a3\functions_f\Misc\fn_endLoadingScreen.sqf";
};

isNil {
    ["CBA_LoadingScreenEnded", _this] call CBA_fnc_localEvent;
};

_return

#include "script_component.hpp"

private _return = call {
    #include "\a3\functions_f\misc\fn_endLoadingScreen.sqf"
};

isNil {
    // BIS preload calls this before the events addon preInit has made the registry,
    // and no handler can be registered before that either, so the raise is a no-op
    if (!isNil QEGVAR(events,eventNamespace)) then {
        [QGVAR(LoadingScreenEnded), _this] call CBA_fnc_localEvent;
    };
};

RETNIL(_return) //scheduler safe

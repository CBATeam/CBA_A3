#include "script_component.hpp"

params ["_display"];

private _fnc_watchDog = {
    if (!ISPROCESSED(missionNamespace)) then {
        INFO_1("missionNamespace processed [%1]", ISPROCESSED(missionNamespace));
        [] call CBA_fnc_preInit;
    };
};

_display displayAddEventHandler ["MouseMoving", _fnc_watchDog];
_display displayAddEventHandler ["MouseHolding", _fnc_watchDog];

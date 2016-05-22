#include "script_component.hpp"

params ["_display"];

uiNamespace setVariable ["CBA_missionDisplay", _display];

// re apply missions display event handlers when display is loaded (save game)
if (!isNil QGVAR(handlerHash)) then {
    [GVAR(handlerHash), {
        {
            private _code = _x param [1];

            if (!isNil "_code") then {
                private _handler = _display displayAddEventHandler [_key, _code];
                _x set [0, _handler];
            };
        } forEach _value;
    }] call CBA_fnc_hashEachPair;

    // copy hash reference to display namespace again, because it's not serialized in save games
    uiNamespace setVariable [QGVAR(handlerHash), GVAR(handlerHash)];
};

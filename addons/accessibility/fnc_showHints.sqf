#include "script_component.hpp"

private _removedHints = [];
{
    private _hint = _x;
    _hint params ["_text", "_source", "_createdAt", "_expiresAt"];

    if (diag_tickTime > _expiresAt) then {
        _removedHints pushBack (GVAR(hints) deleteAt _foreachIndex);
        continue;
    };
} foreach GVAR(hints);

{
    [
        QGVAR(hintExpired),
        [
            _x
        ]
    ] call CBA_fnc_localEvent;
} foreach _removedHints;

if (count GVAR(hints) == 0) then {
    [GVAR(hintsPFH)] call CBA_fnc_removePerFrameHandler;
    GVAR(hintsPFH) = nil;
};

[
    QGVAR(hintProgress),
    [
        diag_tickTime
    ]
] call CBA_fnc_localEvent;

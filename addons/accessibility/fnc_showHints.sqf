#include "script_component.hpp"

for "_i" from (count GVAR(hints) - 1) to 0 step -1 do {
    private _hint = GVAR(hints) select _i;
    _hint params ["_text", "_source", "_expiresAt"];

    if (diag_tickTime > _expiresAt) then {
        GVAR(hints) deleteAt _i;
        continue;
    };

    // TODO show the hint
};

if (count GVAR(hints) == 0) then {
    [GVAR(hintsPFH)] call CBA_fnc_removePerFrameHandler;
    GVAR(hintsPFH) = nil;
};

/* ----------------------------------------------------------------------------
Description:
    Internal function only

Author:
    Xeno
---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(NetRunEventCTS);

private ["_ea", "_p", "_pa"];
_ea = GVAR(event_holderCTS) getVariable (_this select 0);
if (!isNil "_ea") then {
    _pa = _this select 1;
    if (!isNil "_pa") then {
        {_pa call _x} forEach _ea;
    } else {
        {call _x} forEach _ea;
    };
};

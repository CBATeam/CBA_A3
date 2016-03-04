/* ----------------------------------------------------------------------------
Function: CBA_fnc_getSharedGroup

Description:
    Returns existing group on side, or newly created group when not existent.

Parameters:
    _side - Side to get group for <SIDE>

Returns:
    Group <GROUP>

Examples:
    (begin example)
        _sharedAlliedGroup = west call CBA_fnc_getSharedGroup
    (end)

Author:
    Sickboy, commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(getSharedGroup);

#define SIDES [east, west, resistance, civilian, sideLogic]

params [["_side", sideFriendly, [west]]]; // sideFriendly as pseudo null side, replace with sideEmpty

private _id = SIDES find _side;

if (_id < 0) exitWith {grpNull};

private _group = GVAR(groups) select _id;

if (isNull _group) then {
    _group = createGroup _side;
    GVAR(groups) set [_id, _group];

    // TODO: Evaluate if this doesn't mess things up when multiple clients are requesting groups
    publicVariable QGVAR(groups);
};

_group

#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_switchableAttachments

Description:
    Returns all attachments the item can eventually switch to.

Parameters:
    0: _item - Attachment classname <STRING>

Returns:
    _items - List of switchable items, contains original item. <ARRAY>

Examples:
    (begin example)
        "acc_pointer_IR" call CBA_fnc_switchableAttachments
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

params ["_item"];

private _cfgWeapons = configFile >> "CfgWeapons";
private _config = _cfgWeapons >> _item;

private _forward = [];
while {
    _config = _cfgWeapons >> getText (_config >> "MRT_SwitchItemNextClass");
    isClass _config && {_forward pushBackUnique configName _config != -1}
} do {};

_config = _cfgWeapons >> _item;
private _backward = [];
while {
    _config = _cfgWeapons >> getText (_config >> "MRT_SwitchItemPrevClass");
    isClass _config && {_backward pushBackUnique configName _config != -1}
} do {};

_forward = _forward + _backward;
_forward = _forward arrayIntersect _forward;
_forward select {
    private _item = _x;
    private _usageArray = GVAR(usageHash) getOrDefault [_x, []];
    (_usageArray findIf {([_item] call _x) isEqualTo false}) == -1 // none returned false
} // return


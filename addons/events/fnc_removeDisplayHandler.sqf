/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeDisplayHandler

Description:
    Removes an action to a displayHandler

Parameters:
    _type - Displayhandler type to attach to [String].
    _id - Displayhandler ID to remove [Code].

Returns:

Examples:
    (begin example)
        ["KeyDown", _id] call CBA_fnc_removeDisplayHandler;
    (end)

Author:
    Sickboy
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(removeDisplayHandler);

private ["_ar", "_entry"];
PARAMS_2(_type,_index);

_type = toLower _type;
_ar = [GVAR(handler_hash), _type] call CBA_fnc_hashGet;
if (typeName _ar == "ARRAY") then {
    if (count _ar <= _index) exitWith {}; // Doesn't exist
    _entry = _ar select _index;
    if (count _entry > 1) then {
        if !(isDedicated) then { (findDisplay 46) displayRemoveEventhandler [_type, _entry select 0] };
        _ar set [_index, [nil]];
        [GVAR(handler_hash), _type, _ar] call CBA_fnc_hashSet;
    };
};

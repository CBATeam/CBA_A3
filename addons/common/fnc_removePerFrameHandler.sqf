/* ----------------------------------------------------------------------------
Function: CBA_fnc_removePerFrameHandler

Description:
	Remove a handler that you have added using CBA_fnc_addPerFrameHandler

Parameters:
	_handle - The function handle you wish to remove

Returns:
	_handle - a number representing the handle of the function. Use this to remove the handler.

Examples:
	(begin example)
		_handle = [{player sideChat format["every frame! _this: %1", _this];}, 0, ["some","params",1,2,3]] call CBA_fnc_addPerFrameHandler;
		sleep 10;
		[_handle] call CBA_fnc_removePerFrameHandler;
	(end)

Author:
	Nou & Jaynus, donated from ACRE project code for use by the community.

---------------------------------------------------------------------------- */

#include "script_component.hpp"

PARAMS_1(_publicHandle);
private ["_handle"];
if (isNil "_publicHandle" || (_publicHandle < 0)) exitWith {}; // Nil/no handle, nil action
_handle = GVAR(PFHhandles) select _publicHandle;
if (isNil "_handle") exitWith {}; // Nil handle, nil action
GVAR(PFHhandles) set[_publicHandle, nil];
GVAR(perFrameHandlerArray) set [_handle, nil];
_newArray = [];
for "_i" from (count GVAR(perFrameHandlerArray))-1 to 0 step -1 do {
	_entry = GVAR(perFrameHandlerArray) select _i;
	if (isNil "_entry") then {
		GVAR(nextPFHid) = _i;
	} else {
		_newArray set[_i, _entry];
	};
};
GVAR(perFrameHandlerArray) = _newArray;
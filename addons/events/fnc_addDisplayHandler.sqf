/* ----------------------------------------------------------------------------
Function: CBA_fnc_addDisplayHandler

Description:
	Adds an action to a displayHandler
	
Parameters:
	_type - Displayhandler type to attach to [String].
	_code - Code to execute upon event [String].

Returns:
	the id of the attached handler

Examples:
	(begin example)
		_id = ["KeyDown", "_this call myKeyDownEH"] call CBA_fnc_addDisplayHandler;
	(end)

Author:
	Sickboy
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(addDisplayHandler);

private ["_ar", "_id", "_idx"];
PARAMS_2(_type,_code);

_type = toLower _type;
// TODO: Verify if the eventhandler type exists?
_ar = [GVAR(handler_hash), _type] call CBA_fnc_hashGet;
if (typeName _ar != "ARRAY") then { _ar = [] };
_id = if (isDedicated || (isNull (findDisplay 46))) then { nil } else { (findDisplay 46) displayAddEventhandler [_type, _code] };
_idx = count _ar;
_ar set [_idx, [if (isNil "_id") then { nil } else { _id }, _code]];
[GVAR(handler_hash), _type, _ar] call CBA_fnc_hashSet;
if (isNil "_id" && !isDedicated) then { [] spawn FUNC(attach_handler) };
_idx;

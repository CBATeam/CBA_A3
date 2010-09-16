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

PARAMS_1(_handle);
if (isNil "_handle") exitWith {}; // Nil handle, nil action
GVAR(perFrameHandlerArray) set [_handle, nil];

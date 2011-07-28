/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeMagazine

Description:
	Remove a magazine.

	Function which verifies existence of _item and _unit, returns false in case
	of trouble, or when able to remove _item from _unit true in case of success.

Parameters:
	_unit - the unit or vehicle
	_item - name of the magazine to remove

Returns:
	true on success, false otherwise
	
Examples:
	(begin example)
	_result = [player, "SmokeShell"] call CBA_fnc_removeMagazine
	(end)

Author:

---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(removeMagazine);

#define __scriptname fRemoveMagazine

#define __cfg (configFile >> "CfgMagazines")
#define __action removeMagazine
#define __ar (magazines _unit)

private ["_unit", "_item"];
PARAMS_1(_unit);
if (typeName _unit != "OBJECT") exitWith
{
	TRACE_2("Unit not Object",_unit,_item);
	false
};
_item = _this select 1;
if (typeName _item != "STRING") exitWith
{
	TRACE_2("Item not String",_unit,_item);
	false
};
if (isNull _unit) exitWith
{
	TRACE_2("Unit isNull",_unit,_item);
	false
};
if (_item == "") exitWith
{
	TRACE_2("Empty Item",_unit,_item);
	false
};
if !(isClass (__cfg >> _item)) exitWith
{
	TRACE_2("Item not exist in Config",_unit,_item);
	false
};
if !(_item in __ar) exitWith
{
	TRACE_2("Item not available on Unit",_unit,_item);
	false
};
_unit __action _item;
TRACE_2("Success",_unit,_item);
true

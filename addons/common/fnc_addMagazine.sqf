/* ----------------------------------------------------------------------------
Function: CBA_fnc_addMagazine

Description:
	Add magazine to a vehicle/unit.

	The function also verifies existence of _item and _unit, returns false in
	case of trouble, or true when able to add _item to _unit.

Parameters:
	_unit - the unit or vehicle
	_item - name of the magazine to add

Returns:
	true on success, false otherwise

Examples:
	(begin example)
	_result = [player, "SmokeShell"] call CBA_fnc_addMagazine
	(end)

Author:

---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(addMagazine);

#define __scriptname fAddMagazine

#define __cfg (configFile >> "CfgMagazines")
#define __action addMagazine

PARAMS_2(_unit,_item);
if (typeName _unit != "OBJECT") exitWith
{
	TRACE_2("Unit not Object",_unit,_item);
	false
};
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
_unit __action _item;
TRACE_2("Success",_unit,_item);
true

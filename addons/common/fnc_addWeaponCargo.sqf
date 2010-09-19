/* ----------------------------------------------------------------------------
Function: CBA_fnc_addWeaponCargo

Description:
	Add weapon(s) to vehicle cargo.

	Function which verifies existence of _item and _unit, returns false in case
	of trouble, or when able to add _item to _unit true in case of success.

Parameters:

Returns:

Examples:
	(begin example)

	(end)

Author:
	Sickboy

---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(addWeaponCargo);

#define __scriptname fAddWeaponCargo

#define __cfg (configFile >> "CfgWeapons")
#define __action addWeaponCargo

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
_unit __action _item;
TRACE_2("Success",_unit,_item);
true

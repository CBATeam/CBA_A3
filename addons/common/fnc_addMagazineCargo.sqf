/* ----------------------------------------------------------------------------
Function: CBA_fnc_addMagazineCargo

Description:
	Add magazine to a vehicle cargo.
	
	Function which verifies existence of _item and _unit, returns false in case
	of trouble, or when able to add _item to _unit true in case of success.
	
Parameters:

Returns:

Examples:
	(begin example)

	(end)

Author:

---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(addMagazineCargo);

#define __scriptname fnc_addMagazineCargo

#define __cfg (configFile >> "CfgMagazines")
#define __action addMagazineCargo

private ["_unit", "_item"];
PARAMS_1(_unit);
if (typeName _unit != "OBJECT") exitWith
{
	#ifdef DEBUG
	[format["Unit: %1 - Item: %2 - Unit not Object", _unit, _item], QUOTE(GVAR(__scriptname)), DEBUGSETTINGS] call CBA_fnc_Debug;
	#endif
	false
};
_item = _this select 1;
if (typeName _item != "STRING") exitWith
{
	#ifdef DEBUG
	[format["Unit: %1 - Item: %2 - Item not String", _unit, _item], QUOTE(GVAR(__scriptname)), DEBUGSETTINGS] call CBA_fnc_Debug;
	#endif
	false
};
if (isNull _unit) exitWith
{
	#ifdef DEBUG
	[format["Unit: %1 - Item: %2 - Unit isNull", _unit, _item], QUOTE(GVAR(__scriptname)), DEBUGSETTINGS] call CBA_fnc_Debug;
	#endif
	false
};
if (_item == "") exitWith
{
	#ifdef DEBUG
	[format["Unit: %1 - Item: %2 - Empty Item", _unit, _item], QUOTE(GVAR(__scriptname)), DEBUGSETTINGS] call CBA_fnc_Debug;
	#endif
	false
};
if !(isClass (__cfg >> _item)) exitWith
{
	#ifdef DEBUG
	[format["Unit: %1 - Item: %2 - Item not exist in Config", _unit, _item], QUOTE(GVAR(__scriptname)), DEBUGSETTINGS] call CBA_fnc_Debug;
	#endif
	false
};
_unit __action _item;
#ifdef DEBUG
[format["Unit: %1 - Item: %2 - Success", _unit, _item], QUOTE(GVAR(__scriptname)), DEBUGSETTINGS] call CBA_fnc_Debug;
#endif
true
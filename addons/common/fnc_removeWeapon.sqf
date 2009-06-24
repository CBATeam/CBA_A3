/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeWeapon

Description:
	Remove a weapon.
	
	Function which verifies existence of _item and _unit, returns false in case
	of trouble, or when able to remove _item from _unit true in case of success.
	
Parameters:

Returns:

Examples:
	(begin example)

	(end)

Author:

---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(removeWeapon);

#define __scriptname fRemoveWeapon

#define __cfg (configFile >> "CfgWeapons")
#define __action removeWeapon
#define __ar (weapons _unit)

private ["_unit", "_item"];
_unit = _this select 0;
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
if !(_item in __ar) exitWith
{
	#ifdef DEBUG
	[format["Unit: %1 - Item: %2 - Item not available on Unit", _unit, _item], QUOTE(GVAR(__scriptname)), DEBUGSETTINGS] call CBA_fnc_Debug;
	#endif
	false
};
_unit __action _item;
#ifdef DEBUG
[format["Unit: %1 - Item: %2 - Success", _unit, _item], QUOTE(GVAR(__scriptname)), DEBUGSETTINGS] call CBA_fnc_Debug;
#endif
true
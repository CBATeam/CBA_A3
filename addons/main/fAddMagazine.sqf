#include "script_component.hpp"
/*
	Function which verifies existence of _item and _unit, returns false incase of trouble, or when able to add _item to _unit true incase of success
*/

#define __scriptname fAddMagazine

#define __cfg (configFile >> "CfgMagazines")
#define __action addMagazine

private ["_unit", "_item"];
_unit = _this select 0;
if (typeName _unit != "OBJECT") exitWith
{
	#ifdef DEBUG
	[format["Unit: %1 - Item: %2 - Unit not Object", _unit, _item], STR(GVAR(__scriptname)), DEBUG_SETTINGS] call CBA_fDebug;
	#endif
	false
};
_item = _this select 1;
if (typeName _item != "STRING") exitWith
{
	#ifdef DEBUG
	[format["Unit: %1 - Item: %2 - Item not String", _unit, _item], STR(GVAR(__scriptname)), DEBUG_SETTINGS] call CBA_fDebug;
	#endif
	false
};
if (isNull _unit) exitWith
{
	#ifdef DEBUG
	[format["Unit: %1 - Item: %2 - Unit isNull", _unit, _item], STR(GVAR(__scriptname)), DEBUG_SETTINGS] call CBA_fDebug;
	#endif
	false
};
if (_item == "") exitWith
{
	#ifdef DEBUG
	[format["Unit: %1 - Item: %2 - Empty Item", _unit, _item], STR(GVAR(__scriptname)), DEBUG_SETTINGS] call CBA_fDebug;
	#endif
	false
};
if !(isClass (__cfg >> _item)) exitWith
{
	#ifdef DEBUG
	[format["Unit: %1 - Item: %2 - Item not exist in Config", _unit, _item], STR(GVAR(__scriptname)), DEBUG_SETTINGS] call CBA_fDebug;
	#endif
	false
};
_unit __action _item;
#ifdef DEBUG
[format["Unit: %1 - Item: %2 - Success", _unit, _item], STR(GVAR(__scriptname)), DEBUG_SETTINGS] call CBA_fDebug;
#endif
true
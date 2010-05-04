#include "\x\cba\addons\ui\script_component.hpp"
#include "data\common.hpp"

private ["_msg", "_exit", "_list"];
// _this = ["player", [DIK_LSHIFT], -3, ["mission\weapon_menuDef.sqf", ["main"]]]
// Note: calling script may require this file for dik codes: #include "\ca\editor\Data\Scripts\dikCodes.h"

// validate params_msg = format ["Error: invalid params. %1 (%2)", _this, __FILE__];
if (isNil QUOTE(GVAR(typeMenuSources))) exitWith {diag_log _msg};
if (typeName _this != typeName []) exitWith {diag_log _msg};
if (count _this != 4) exitWith {diag_log _msg};
if !(toLower typeName (_this select _flexiMenu_typeMenuSources_ID_type) in [toLower typeName "", toLower typeName []]) exitWith {diag_log _msg};
if (typeName (_this select _flexiMenu_typeMenuSources_ID_DIKCodes) != typeName []) exitWith {diag_log _msg};
if (typeName (_this select _flexiMenu_typeMenuSources_ID_priority) != typeName 2) exitWith {diag_log _msg};
if !(typeName (_this select _flexiMenu_typeMenuSources_ID_menuSource) in [typeName [], typeName ""]) exitWith {diag_log _msg};

// common bug: invalid DIK code (type any) when missing #include "dikCodes.h"

//_temp = _this select _flexiMenu_typeMenuSources_ID_DIKCodes;
//diag_log ['cba ui fnc_add.sqf: warning: checking:', _this, _temp, str _temp, isNil {_temp}, typeName _temp, typeName 2]; // temp debug
//TODO: still not detecting nil?
if (({isNil {_x}} count (_this select _flexiMenu_typeMenuSources_ID_DIKCodes)) > 0) exitWith {diag_log _msg};
if (({typeName _x != typeName 2} count (_this select _flexiMenu_typeMenuSources_ID_DIKCodes)) > 0) exitWith {diag_log _msg};
//_temp = _this select _flexiMenu_typeMenuSources_ID_DIKCodes;
//if (str _temp == "[any]") exitWith {diag_log _msg};
//if (str _temp == "any") exitWith {diag_log _msg};

// Check for duplicate record and then warn and ignore.
if (({str _x == str _this} count (_this select _flexiMenu_typeMenuSources_ID_DIKCodes)) > 0) exitWith
{
	diag_log format ["Warning: duplicate record, ignoring. %1 (%2)", _this, __FILE__];
};

GVAR(typeMenuSources) = GVAR(typeMenuSources)+[_this];
[GVAR(typeMenuSources), _flexiMenu_typeMenuSources_ID_priority] call CBA_fnc_sortNestedArray;

// reverse the order of sorting, so highest priority is at the top
GVAR(typeMenuSources) = call
{
	private ['_list'];
	_list = [];
	{
		_list = [_x]+_list;
	} forEach GVAR(typeMenuSources);
	_list
};

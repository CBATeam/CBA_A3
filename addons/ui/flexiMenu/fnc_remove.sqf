#define DEBUG_MODE_FULL
#include "\x\cba\addons\ui\script_component.hpp"

private ['_msg', '_i'];

// _this = ["player", [DIK_LSHIFT], -3, ["mission\weapon_menuDef.sqf", ["main"]]]

// validate params
_msg = "";
_msg = format ["Error: invalid params. %1 (%2)", _this, __FILE__ ];
if (isNil "_msg") then  { _msg = "FLEXIMENU: Unknown Error in fnc_remove.sqf"};
if (isNil QUOTE(GVAR(typeMenuSources))) exitWith {diag_log _msg};
if (typeName _this != typeName []) exitWith {diag_log _msg};
if (count _this != 4) exitWith {diag_log _msg};
if !(toLower typeName (_this select _flexiMenu_typeMenuSources_ID_type) in [toLower typeName "", toLower typeName []]) exitWith {diag_log _msg};
if (typeName (_this select _flexiMenu_typeMenuSources_ID_DIKCodes) != typeName []) exitWith {diag_log _msg};
if (typeName (_this select _flexiMenu_typeMenuSources_ID_priority) != typeName 2) exitWith {diag_log _msg};
if !(typeName (_this select _flexiMenu_typeMenuSources_ID_menuSource) in [typeName [], typeName ""]) exitWith {diag_log _msg};

_i = 0;
{
	if (str _x == str _this) then {
		GVAR(typeMenuSources) set [_i, -1];
		_x = -1;
	};
	_i = _i + 1;
} forEach GVAR(typeMenuSources);

GVAR(typeMenuSources) = GVAR(typeMenuSources) - [-1];

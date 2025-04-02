//#define DEBUG_MODE_FULL
#include "..\script_component.hpp"

// _this = ["player", [DIK_LSHIFT], -3, ["mission\weapon_menuDef.sqf", ["main"]]]

// validate params
private _msg = "";
_msg = format ["Error: invalid params. %1 (%2)", _this, __FILE__ ];

if (isNil "_msg") then  {_msg = "FLEXIMENU: Unknown Error in fnc_remove.sqf"};
if (isNil QGVAR(typeMenuSources)) exitWith {diag_log _msg};
if (typeName _this != "ARRAY") exitWith {diag_log _msg};
if (count _this != 5) exitWith {diag_log _msg};
if !(toLower typeName (_this select _flexiMenu_typeMenuSources_ID_type) in [toLower "STRING", toLower "ARRAY"]) exitWith {diag_log _msg};
if (typeName (_this select _flexiMenu_typeMenuSources_ID_DIKCodes) != "ARRAY") exitWith {diag_log _msg};
if (typeName (_this select _flexiMenu_typeMenuSources_ID_priority) != "SCALAR") exitWith {diag_log _msg};
if !(typeName (_this select _flexiMenu_typeMenuSources_ID_menuSource) in ["ARRAY", "STRING"]) exitWith {diag_log _msg};

private _i = 0;
{
    if (str _x == str _this) then {
        GVAR(typeMenuSources) set [_i, -1];
        _x = -1;
    };
    _i = _i + 1;
} forEach GVAR(typeMenuSources);

GVAR(typeMenuSources) = GVAR(typeMenuSources) - [-1];

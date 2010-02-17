#include "\x\cba\addons\ui\script_component.hpp"

// _this = ["player", [DIK_LSHIFT], ["mission\weapon_menuDef.sqf", ["main"]]]
// Note: calling script may require this file for dik codes: #include "\ca\editor\Data\Scripts\dikCodes.h"

// validate params_msg = format ["Error: invalid params. %1 (%2)", _this, __FILE__];
if (isNil QUOTE(GVAR(typeMenuSources))) exitWith {diag_log _msg};
if (typeName _this != typeName []) exitWith {diag_log _msg};
if (count _this != 3) exitWith {diag_log _msg};
if (typeName (_this select 0) != typeName "") exitWith {diag_log _msg};
if (typeName (_this select 1) != typeName []) exitWith {diag_log _msg};
if !(typeName (_this select 2) in [typeName [], typeName ""]) exitWith {diag_log _msg};

// TODO: Consider checking for duplicate ["type", [dik_code]] entry and warn?

GVAR(typeMenuSources) = GVAR(typeMenuSources)+[_this];

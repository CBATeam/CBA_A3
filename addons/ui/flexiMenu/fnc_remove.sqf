#include "\x\cba\addons\ui\script_component.hpp"private ['_msg', '_i'];
/* diag_log ['g', GVAR(typeMenuSources)]; */
/* // _this = ["player", [DIK_LSHIFT], ["mission\weapon_menuDef.sqf", ["main"]]] */
/* // validate params */
_msg = format ["Error: invalid params. %1 (%2)", _this, __FILE__];
if (isNil QUOTE(GVAR(typeMenuSources))) exitWith {diag_log _msg};
if (typeName _this != typeName []) exitWith {diag_log _msg};
if (count _this != 3) exitWith {diag_log _msg};
if (typeName (_this select 0) != typeName "") exitWith {diag_log _msg};
if (typeName (_this select 1) != typeName []) exitWith {diag_log _msg};
if !(typeName (_this select 2) in [typeName [], typeName ""]) exitWith {diag_log _msg};
_i = 0;
{
	if ((_x select 0 == _this select 0) && 
		(str (_x select 1) == str (_this select 1)) && 
		(str (_x select 2) == str (_this select 2)) ) then
	{
		GVAR(typeMenuSources) set [_i, -1];
		_x = -1;
	};
	_i = _i+1;
} forEach GVAR(typeMenuSources);

GVAR(typeMenuSources) = GVAR(typeMenuSources)-[-1];
/* diag_log ['h', GVAR(typeMenuSources)]; */

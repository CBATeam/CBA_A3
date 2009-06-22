#include "script_component.hpp"
/*
	fGetConfigEntry - by Sickboy (sb_at_dev-heaven.net)
	Will check if _cfg exists, and will return either the config value, or supplied default value
*/
// [configEntry, entryType, defaultValue] call _f
private ["_r"];
switch (_this select 1) do
{
	case "text":
	{
		if (isText (_this select 0)) then
		{
			_r = getText (_this select 0);
		};
	};
	case "array":
	{
		if (isArray (_this select 0)) then
		{
			_r = getArray (_this select 0);
		};
	};
	case "number":
	{
		if (isNumber (_this select 0)) then
		{
			_r = getNumber (_this select 0);
		};
	};
};

if (isNil "_r") then { _r = _this select 2 };

_r
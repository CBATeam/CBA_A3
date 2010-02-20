// Desc: determine menuDef to use, based on variable param variations
//-----------------------------------------------------------------------------
#include "\x\cba\addons\ui\script_component.hpp"
#include "data\common.hpp"

private ["_menuDefs", "_target", "_params", "_menuSource", "_menuParams", "_array"];

_target = _this select 0;
_params = _this select 1; // [_target, _menuSource];

_menuSource = "";
_menuParams = [_target];
// Syntax 1
if (typeName _params == typeName "") then
{
	_menuSource = _params;
};
// Syntax 2
if (typeName _params == typeName []) then
{
	if (count _params > 0) then
	{
		_menuSource = _params select 0;
		if (typeName _menuSource == typeName "") then // check for syntax: function, code string or sqf filename
		{
			_menuParams = if (count _params > 1) then {[_target, _params select 1]};
		}
		else // else typeName == typeName []
		{
			_menuSource = _params;
		};
	};
};
//-----------------------------------------------------------------------------
// determine if string represents an executable statement or actual data (via variable).
if (typeName _menuSource == typeName []) then
{
	// _menuSource is _menuDefs. a single menuDef array
	_menuDefs = _menuSource;
}
else
{
	// check which string syntax was used: function, code string or sqf filename
	_array = toArray _menuSource;
	_menuDefs = if (_array find 46 >= 0 && _array find 34 < 0 && _array find 39 < 0) then // 46='.',34=("),39=(') (eg: as in 'path\file.sqf')
	{
		// sqf filename. Eg: 'path\file.sqf'
		_menuParams call compile preprocessFileLineNumbers _menuSource;
	}
	else // code string. Eg: '_this call someFunction' or '_this call compile preprocessFileLineNumbers "file.sqf"'
	{
		_menuParams call compile _menuSource;
	};
};

_menuDefs // return value

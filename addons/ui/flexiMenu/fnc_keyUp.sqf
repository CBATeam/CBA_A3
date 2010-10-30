#include "\x\cba\addons\ui\script_component.hpp"
#include "\ca\editor\Data\Scripts\dikCodes.h"

private["_handled", /* "_ctrl", */ "_dikCode", "_shift", "_ctrlKey", "_alt",
	"_active", "_potentialKeyMatch"];

_dikCode = _this select 1;
_shift = _this select 2;
_ctrlKey = _this select 3;
_alt = _this select 4;

_handled = false;

if (!GVAR(holdKeyDown)) exitWith {_handled}; // key release monitoring not required.

// scan typeMenuSources key list (optimise overhead)
_potentialKeyMatch = false;
{
	// syntax of _keys: [[_dikCode1, [_shift, _ctrlKey, _alt]], [_dikCode2, [...]], ...]
	_keys = (_x select _flexiMenu_typeMenuSources_ID_DIKCodes);
	{
		_settings = _x select 1;
		if ((_x select 0 == _dikCode) &&
			((!(_settings select 0) && !_shift) || ((_settings select 0) && _shift)) &&
			((!(_settings select 1) && !_ctrlKey) || ((_settings select 1) && _ctrlKey)) &&
			((!(_settings select 2) && !_alt) || ((_settings select 2) && _alt)) ) exitWith
		{
			_potentialKeyMatch = true;
		};
	} forEach _keys;
	if (_potentialKeyMatch) exitWith {};
} forEach GVAR(typeMenuSources);

// check if interaction key used
if !(_potentialKeyMatch) exitWith {
	_handled
};
//-----------------------------------------------------------------------------
_active = (!isNil {uiNamespace getVariable QUOTE(GVAR(display))});
if (_active) then {
	_active = (!isNull (uiNamespace getVariable QUOTE(GVAR(display))));
};
if (_active) then {
	closeDialog 0;
	_handled = true;
};
GVAR(optionSelected) = false;

_handled

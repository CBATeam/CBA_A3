#include "script_component.hpp"
private ["_class", "_baseClass", "_entry", "_valid"];
_class = _this select 0;
_baseClass = _this select 1;
_valid = false;

_entry = inheritsFrom _entry;
while { _entry != "" } do
{
	if (_entry == _baseClass) exitWith { _valid = true };
	_entry = inheritsFrom _entry;
};

_valid
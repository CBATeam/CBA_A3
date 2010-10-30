#include "\x\cba\addons\ui\script_component.hpp"
#define _rightMouseButton 1

//private["_display", "_button", "_x", "_y", "_shiftKey", "_ctrlKey", "_altKey"]; // event params
private["_button", "_shiftKey"]; // event params

//_display = _this select 0;
_button = _this select 1;
//_x = _this select 2;
//_y = _this select 3;
_shiftKey = _this select 4;
//_ctrlKey = _this select 5;
//_altKey = _this select 6;

_handled = false;

// right click to close menu
if (!GVAR(holdKeyDown) && _button == _rightMouseButton && !_shiftKey) then {
	if (dialog) then {
		closeDialog 0;
		_handled = true;
	};
};

// [interactKey]+shift+right click to toggle menu lock
if (_button == _rightMouseButton && _shiftKey) then {
	GVAR(holdKeyDown) = !GVAR(holdKeyDown);
	hint format["Menu lock toggled %1", (if (GVAR(holdKeyDown)) then {"off"} else {"on"})];
	if (dialog) then {
		closeDialog 0;
	};
	_handled = true;
};

_handled // result

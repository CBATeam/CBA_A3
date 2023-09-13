#include "..\script_component.hpp"
#define _rightMouseButton 1

params ["_display", "_button", "_x", "_y", "_shiftKey", "_ctrlKey", "_altKey"];;

_handled = false;

// right click to close menu
if (dialog && {!GVAR(holdKeyDown)} && {_button == _rightMouseButton} && {!_shiftKey}) then {
    closeDialog 0;
    _handled = true;
};

// [interactKey] + shift + right click to toggle menu lock
if (_button == _rightMouseButton && {_shiftKey}) then {
    GVAR(holdKeyDown) = !GVAR(holdKeyDown);
    hint format ["Menu lock toggled %1", (if (GVAR(holdKeyDown)) then {"off"} else {"on"})];
    if (dialog) then {
        closeDialog 0;
    };
    _handled = true;
};

_handled // result

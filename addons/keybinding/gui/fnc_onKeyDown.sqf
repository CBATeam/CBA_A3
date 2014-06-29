#include "\x\cba\addons\keybinding\script_component.hpp"

disableSerialization;

_display = _this select 0;
_dikCode = _this select 1;
_shift = _this select 2;
_ctrl = _this select 3;
_alt = _this select 4;

if (GVAR(waitingForInput)) then {
	if !(_dikCode in [42, 29, 56]) then { // Don't accept LShift, LCtrl, or LAlt on their own
		GVAR(input) = [_dikCode, _shift, _ctrl, _alt];
	};
};

// Prevent key passthrough when waiting for input for binding (to prevent escape).
_return = false;
if (GVAR(waitingForInput)) then {
	_return = true;
};

_return;
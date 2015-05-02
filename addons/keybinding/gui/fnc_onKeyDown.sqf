//#define DEBUG_MODE_FULL
#include "\x\cba\addons\keybinding\script_component.hpp"

disableSerialization;

_display = _this select 0;
_dikCode = _this select 1;
_shift = _this select 2;
_ctrl = _this select 3;
_alt = _this select 4;
if(_dikCode == 0) exitWith {false};
if (GVAR(waitingForInput)) then {
	if !(_dikCode in [42, 29, 56, 54, 157, 184]) then { // Don't accept LShift, LCtrl, or LAlt or RShift, RCtrl, or RAlt on their own
		TRACE_4("Update Input",_dikCode,_shift, _ctrl, _alt);
		TRACE_2("Before",GVAR(modifiers), GVAR(input));
		GVAR(input) = [_dikCode, [_shift, _ctrl, _alt]];
		GVAR(modifiers) = [];
		TRACE_2("After",GVAR(modifiers), GVAR(input));
	} else {
		TRACE_4("Update Modifiers",_dikCode,_shift, _ctrl, _alt);
		TRACE_2("Before",GVAR(modifiers), GVAR(input));
		if(!(_dikCode in GVAR(modifiers))) then {
			PUSH(GVAR(modifiers), _dikCode);
		};
		TRACE_2("After",GVAR(modifiers), GVAR(input));
	};
};

// Prevent key passthrough when waiting for input for binding (to prevent escape).
_return = false;
if (GVAR(waitingForInput)) then {
	_return = true;
};

if (_dikCode == 1 && !GVAR(waitingForInput)) then {
	// Esc was pressed to close menu, revert changes.
	[] call cba_keybinding_fnc_onButtonClick_cancel;
} else {
	if(_dikCode == 1) then {
		GVAR(waitingForInput) = false;
	};
};

_return;
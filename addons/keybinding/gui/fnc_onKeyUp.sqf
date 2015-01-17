#include "\x\cba\addons\keybinding\script_component.hpp"

disableSerialization;

_display = _this select 0;
_dikCode = _this select 1;
_shift = false;
_ctrl = false;
_alt = false;
if(_dikCode == 0) exitWith {false};
if((count GVAR(modifiers)) > 0) then {
	//if !(_dikCode in [42, 29, 56]) then { // Don't accept LShift, LCtrl, or LAlt on their own
	if(_dikCode in GVAR(modifiers)) then {
		_dikCode = GVAR(modifiers) select 0;
		GVAR(modifiers) = GVAR(modifiers);
		
		if(29 in GVAR(modifiers)) then {
			_ctrl = true;
		};
		if(42 in GVAR(modifiers)) then {
			_shift = true;
		};
		if(56 in GVAR(modifiers)) then {
			_alt = true;
		};
		GVAR(input) = [_dikCode, _shift, _ctrl, _alt];
	};
};
false;
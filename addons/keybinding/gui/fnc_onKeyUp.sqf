//#define DEBUG_MODE_FULL
#include "\x\cba\addons\keybinding\script_component.hpp"

disableSerialization;

_display = _this select 0;
_dikCode = _this select 1;
_shift = false;
_ctrl = false;
_alt = false;

TRACE_4("KEY UP",_dikCode,_shift, _ctrl, _alt);
TRACE_2("KEY UP",GVAR(modifiers), GVAR(input));

if(_dikCode == 0) exitWith {false};
if((count GVAR(modifiers)) > 0) then {
    //if !(_dikCode in [42, 29, 56  54, 157, 184]) then { // Don't accept LShift, LCtrl, or LAlt or RShift, RCtrl, or RAlt on their own
    if(_dikCode in GVAR(modifiers) && { (count GVAR(input)) > 0 }) then {

        TRACE_4("Update Modifiers before",_dikCode,_shift, _ctrl, _alt);
        TRACE_2("Before",GVAR(modifiers), GVAR(input));

        _dikCode = GVAR(modifiers) select 0;

        GVAR(modifiers) = GVAR(modifiers);
        TRACE_2("After",GVAR(modifiers), GVAR(input));

        if(29 in GVAR(modifiers)) then {
            _ctrl = true;
        };
        if(42 in GVAR(modifiers)) then {
            _shift = true;
        };
        if(56 in GVAR(modifiers)) then {
            _alt = true;
        };

        TRACE_4("Update Modifiers after",_dikCode,_shift, _ctrl, _alt);
        TRACE_4("Update input",_dikCode,_shift, _ctrl, _alt);
        GVAR(input) = [_dikCode, [_shift, _ctrl, _alt]];
    };
};
TRACE_4("No Modifires",_dikCode,_shift, _ctrl, _alt);
TRACE_2("final",GVAR(modifiers), GVAR(input));
false;
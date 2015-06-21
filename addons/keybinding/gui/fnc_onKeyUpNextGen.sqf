#define DEBUG_MODE_FULL
#include "\x\cba\addons\keybinding\script_component.hpp"

disableSerialization;

_display = _this select 0;
_dikCode = _this select 1;
_shift = false;
_ctrl = false;
_alt = false;

TRACE_4("KEY UP",_dikCode,_shift, _ctrl, _alt);
TRACE_4("KEY UP",GVAR(modifiers), GVAR(input), GVAR(firstKey), GVAR(secondKey));

if(_dikCode == 0) exitWith {false};
if((count GVAR(firstKey)) > 0) then {
    //if !(_dikCode in [42, 29, 56  54, 157, 184]) then { // Don't accept LShift, LCtrl, or LAlt or RShift, RCtrl, or RAlt on their own
    if(_dikCode in GVAR(firstKey) && { (count GVAR(input)) > 0 }) then {

        _dikCode = GVAR(firstKey) select 0;

        GVAR(firstKey) = GVAR(firstKey);
        TRACE_2("After",GVAR(firstKey), GVAR(input));


    };
};

TRACE_4("KEY UP",GVAR(modifiers), GVAR(input), GVAR(firstKey), GVAR(secondKey));
//if GVAR(secondKey) is empty then this is a Single-Key Event
if ( (count GVAR(secondKey)) < 1 ) then {
    GVAR(secondKey) = GVAR(firstKey);
    GVAR(firstKey) = [];
    GVAR(input) = [GVAR(secondKey) select 0, [_shift, _ctrl, _alt]];

} else {
        // if it is a Multiple-Key Event then modifiers must be recorded.

        TRACE_4("Update Modifiers before",_dikCode,_shift, _ctrl, _alt);
        TRACE_2("Before",GVAR(secondKey), GVAR(input));

        if(29 in GVAR(firstKey) || {157 in GVAR(firstKey)}  ) then {
            _ctrl = true;
        };
        if(42 in GVAR(firstKey) || {54 in GVAR(firstKey)}   ) then {
            _shift = true;
        };
        if(56 in GVAR(firstKey) || {184 in GVAR(firstKey)}  ) then {
            _alt = true;
        };
        GVAR(input) = [GVAR(secondKey) select 0, [_shift, _ctrl, _alt]];
        TRACE_4("Update modifiers after",_dikCode,_shift, _ctrl, _alt);
        TRACE_4("Update input",_dikCode,_shift, _ctrl, _alt);

};


TRACE_4("KEY UP",GVAR(modifiers), GVAR(input), GVAR(firstKey), GVAR(secondKey));
GVAR(modifiers) = GVAR(firstKey);
TRACE_4("No Modifires",_dikCode,_shift, _ctrl, _alt);
TRACE_2("final",GVAR(modifiers), GVAR(input));
false;
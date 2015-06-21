#define DEBUG_MODE_FULL
#include "\x\cba\addons\keybinding\script_component.hpp"


// GVAR()

disableSerialization;

_display = _this select 0;
_dikCode = _this select 1;
_shift = _this select 2;
_ctrl = _this select 3;
_alt = _this select 4;
if(_dikCode == 0) exitWith {false};




if (GVAR(waitingForInput)) then {

    // Check for firstKey

    if (count GVAR(firstKey)<1) then {

        TRACE_4("Update Input",_dikCode,_shift,_ctrl,_alt);
        TRACE_2("Before",GVAR(firstKey), GVAR(input));
        GVAR(firstKey) = [];
        if(!(_dikCode in GVAR(firstKey))) then {
            PUSH(GVAR(firstKey), _dikCode);
        };
        _shift = false;
        _ctrl = false;
        _alt = false;
        GVAR(input) = [_dikCode, [_shift, _ctrl, _alt]];
        TRACE_2("After",GVAR(firstKey), GVAR(input));
        TRACE_4("Update Modifiers",_dikCode,_shift,_ctrl,_alt);

    } else {
        // Check for secondKey only when firstKey is detected
        TRACE_4("Update Input",_dikCode,_shift,_ctrl,_alt);
        TRACE_3("Before",GVAR(firstKey),GVAR(secondKey), GVAR(input));
        if (count GVAR(secondKey)<1) then {

            if(!(_dikCode in GVAR(firstKey))) then {
                GVAR(secondKey) = [_dikCode];
                GVAR(input) = [_dikCode, [_shift, _ctrl, _alt]];
            };
        };
        TRACE_3("After",GVAR(firstKey),GVAR(secondKey), GVAR(input));
        TRACE_4("Update Modifiers",_dikCode,_shift,_ctrl,_alt);
    };
};


TRACE_1("Checking Current Input",GVAR(input));

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
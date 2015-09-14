//#define DEBUG_MODE_FULL
#include "\x\cba\addons\keybinding\script_component.hpp"

// GVAR()

disableSerialization;
params ["_display", "_dikCode", "_shift", "_ctrl", "_alt"];

if(_dikCode == 0) exitWith {false};


if (GVAR(waitingForInput)) then {

    // Check for firstKey
    if (count GVAR(firstKey)<1) then {

        TRACE_4("KEY DOWN: Update Input",_dikCode,_shift,_ctrl,_alt);
        TRACE_4("KEY DOWN: 1st Key Before",GVAR(firstKey),GVAR(secondKey),GVAR(thirdKey), GVAR(input));
        GVAR(firstKey) = [];
        if(!(_dikCode in GVAR(firstKey))) then {
            PUSH(GVAR(firstKey), _dikCode);
        };
        _shift = false;
        _ctrl = false;
        _alt = false;
        GVAR(input) = [_dikCode, [_shift, _ctrl, _alt]];
        TRACE_4("KEY DOWN: 1st Key After",GVAR(firstKey),GVAR(secondKey),GVAR(thirdKey), GVAR(input));
        TRACE_4("KEY DOWN: Update Modifiers",_dikCode,_shift,_ctrl,_alt);

    } else{

        // Check for secondKey
        if (count GVAR(firstKey)>0 && {(count GVAR(secondKey)<1)}) then {
        // Check for secondKey only when firstKey is detected
        TRACE_4("KEY DOWN: Update Input",_dikCode,_shift,_ctrl,_alt);
        TRACE_4("KEY DOWN: 2nd Key Before",GVAR(firstKey),GVAR(secondKey),GVAR(thirdKey), GVAR(input));

        if(!(_dikCode in GVAR(firstKey))) then {
            GVAR(secondKey) = [_dikCode];
            GVAR(input) = [_dikCode, [_shift, _ctrl, _alt]];
        };

        TRACE_4("KEY DOWN: 2nd Key After",GVAR(firstKey),GVAR(secondKey),GVAR(thirdKey), GVAR(input));
        TRACE_4("KEY DOWN: Update Modifiers",_dikCode,_shift,_ctrl,_alt);

        } else {
            // Check for thirdKey
            if (count GVAR(secondKey)>0 && {count GVAR(firstKey)>0}) then {
                // Check for ThirdKey only when first and Second Key is detected
                TRACE_4("KEY DOWN: Update Input",_dikCode,_shift,_ctrl,_alt);
                TRACE_4("KEY DOWN: 3rd Key Before",GVAR(firstKey),GVAR(secondKey),GVAR(thirdKey), GVAR(input));

                if( ( !(_dikCode in GVAR(secondKey)) && { !(_dikCode in GVAR(firstKey)) })) then {
                    GVAR(thirdKey) = [_dikCode];
                    GVAR(input) = [_dikCode, [_shift, _ctrl, _alt]];
                };
                TRACE_4("KEY DOWN: 3rd Key After",GVAR(firstKey),GVAR(secondKey),GVAR(thirdKey), GVAR(input));
                TRACE_4("KEY DOWN: Update Modifiers",_dikCode,_shift,_ctrl,_alt);
            };
        };
    };



};


TRACE_1("KEY DOWN: Checking Current Input",GVAR(input));
private "_return";
// Prevent key passthrough when waiting for input for binding (to prevent escape).
_return = false;
if (GVAR(waitingForInput)) then {
    _return = true;
};

if (_dikCode == 1 && !GVAR(waitingForInput)) then {
    // Esc was pressed to close menu, revert changes.
    [] call FUNC(onButtonClick_cancel);
} else {
    if(_dikCode == 1) then {
        GVAR(waitingForInput) = false;
    };
};


_return;

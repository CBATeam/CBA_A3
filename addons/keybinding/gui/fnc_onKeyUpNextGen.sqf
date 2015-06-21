#define DEBUG_MODE_FULL
#include "\x\cba\addons\keybinding\script_component.hpp"

disableSerialization;

_display = _this select 0;
_dikCode = _this select 1;
_shift = GVAR(input) select 1 select 0;
_ctrl = GVAR(input) select 1 select 1;
_alt = GVAR(input) select 1 select 2;

TRACE_4("KEY UP",_dikCode,_shift, _ctrl, _alt);
TRACE_5("KEY UP",GVAR(modifiers), GVAR(input), GVAR(firstKey), GVAR(secondKey),GVAR(thirdKey));

if(_dikCode == 0) exitWith {false};
if((count GVAR(firstKey)) > 0) then {

    if(_dikCode in GVAR(firstKey) && { (count GVAR(input)) > 0 }) then {

        _dikCode = GVAR(firstKey) select 0;

        GVAR(firstKey) = GVAR(firstKey);
        TRACE_2("After",GVAR(firstKey), GVAR(input));


    };
};

TRACE_5("KEY UP",GVAR(modifiers), GVAR(input), GVAR(firstKey), GVAR(secondKey),GVAR(thirdKey));
//if GVAR(secondKey) is empty then this is a Single-Key Event
if ( (count GVAR(secondKey)) < 1 ) then {
    GVAR(secondKey) = GVAR(firstKey);
    GVAR(firstKey) = [];
    GVAR(input) set [0, GVAR(secondKey) select 0];

} else {

	// Check for secondKey
	if (count GVAR(firstKey)>0 && {(count GVAR(secondKey)<1)}) then {
    // if it is a Multiple-Key Event then modifiers must be recorded.

    TRACE_4("Update Modifiers before",_dikCode,_shift, _ctrl, _alt);
    TRACE_2("2nd key Before",GVAR(secondKey), GVAR(input));

    GVAR(input) set [0, GVAR(secondKey) select 0];

    TRACE_4("Update modifiers after",_dikCode,_shift, _ctrl, _alt);
    TRACE_4("Update input",_dikCode,_shift, _ctrl, _alt);
	} else {
		// Check for thirdKey
		if (count GVAR(secondKey)>0 && {count GVAR(firstKey)>0}) then {
			// if it is a Multiple-Key Event then modifiers must be recorded.
			TRACE_4("Update Modifiers before",_dikCode,_shift, _ctrl, _alt);
			TRACE_2("3rd Key Before",GVAR(secondKey), GVAR(input));

			GVAR(input) set [0, GVAR(thirdKey) select 0];
			TRACE_4("Update modifiers after",_dikCode,_shift, _ctrl, _alt);
			TRACE_4("Update input",_dikCode,_shift, _ctrl, _alt);
		};
	};
};

if (count GVAR(thirdKey) < 1) then {
	GVAR(thirdKey) = [_dikCode];
};

GVAR(input) set [0, GVAR(thirdKey) select 0];
TRACE_5("KEY UP",GVAR(modifiers), GVAR(input), GVAR(firstKey), GVAR(secondKey), GVAR(thirdKey));
GVAR(modifiers) = GVAR(firstKey) + GVAR(secondKey);
TRACE_4("KEY UP: Modifires",_dikCode,_shift, _ctrl, _alt);
TRACE_2("KEY UP: final",GVAR(modifiers), GVAR(input));
false;
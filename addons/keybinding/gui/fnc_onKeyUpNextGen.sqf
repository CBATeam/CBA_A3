#define DEBUG_MODE_FULL
#include "\x\cba\addons\keybinding\script_component.hpp"

disableSerialization;

_display = _this select 0;
_dikCode = _this select 1;

TRACE_1("KEY UP",_dikCode);
TRACE_5("KEY UP",GVAR(modifiers), GVAR(input), GVAR(firstKey), GVAR(secondKey),GVAR(thirdKey));

if(_dikCode == 0) exitWith {false};
if((count GVAR(firstKey)) > 0) then {

    if(_dikCode in GVAR(firstKey) && { (count GVAR(input)) > 0 }) then {

        _dikCode = GVAR(firstKey) select 0;

        GVAR(firstKey) = GVAR(firstKey);
		
        TRACE_2("KEY UP: 1st key After",GVAR(firstKey), GVAR(input));
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

    TRACE_1("KEY UP: Update Modifiers before",_dikCode);
    TRACE_2("KEY UP: 2nd key Before",GVAR(secondKey), GVAR(input));

    GVAR(input) set [0, GVAR(secondKey) select 0];

    TRACE_1("KEY UP: Update modifiers after",_dikCode);
    TRACE_2("KEY UP: 2nd key After",GVAR(secondKey), GVAR(input));
	} else {
		// Check for thirdKey
		if (count GVAR(secondKey)>0 && {count GVAR(firstKey)>0}) then {
			// if it is a Multiple-Key Event then modifiers must be recorded.
			TRACE_1("KEY UP: Update Modifiers before",_dikCode);
			TRACE_2("KEY UP: 3rd Key Before",GVAR(thirdKey), GVAR(input));

			GVAR(input) set [0, GVAR(thirdKey) select 0];
			
			TRACE_1("KEY UP: Update modifiers after",_dikCode);
			TRACE_2("KEY UP: Third key After",GVAR(thirdKey), GVAR(input));
		};
	};
};

if (count GVAR(thirdKey) < 1) then {
	GVAR(thirdKey) = [_dikCode];
};

GVAR(input) set [0, GVAR(thirdKey) select 0];
TRACE_5("KEY UP",GVAR(modifiers), GVAR(input), GVAR(firstKey), GVAR(secondKey), GVAR(thirdKey));
GVAR(modifiers) = GVAR(firstKey) + GVAR(secondKey);
TRACE_1("KEY UP: Modifires",_dikCode);
TRACE_2("KEY UP: final",GVAR(modifiers), GVAR(input));
false;
#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_waitAndExecute

Description:
    Executes a code once in unscheduled environment with a given game time delay.
    Note that unlike PFEH, the delay is in CBA_missionTime not diag_tickTime (will be adjusted for time accl).

Parameters:
    _function - The function you wish to execute. <CODE>
    _args     - Parameters passed to the function executing. (optional) <ANY>
    _delay    - The amount of time in seconds before the code is executed. (optional, default: 0) <NUMBER>

Passed Arguments:
    _this     - Parameters passed by this function. Same as '_args' above. <ANY>

Returns:
    Nothing

Examples:
    (begin example)
        [{player sideChat format ["5s later! _this: %1", _this];}, ["some","params",1,2,3], 5] call CBA_fnc_waitAndExecute;
    (end)

Author:
    esteldunedain and PabstMirror, donated from ACE3
---------------------------------------------------------------------------- */

params [["_function", {}, [{}]], ["_args", []], ["_delay", 0, [0]],["_getter","cba_missiontime",["",{}]]];
if !(_getter isEqualType {}) then {
	switch (toLower _getter) do {
		case "cba_missiontime": {
			GVAR(waitAndExecArray) pushBack [CBA_missionTime + _delay, _function, _args];
			GVAR(waitAndExecArrayIsSorted) = false;
		};
		#define CASE(command,inverse) case QUOTE(command): {                                                   \
			GVAR(TRIPLES(waitAndExec,command,Array)) pushBack [command + _delay, _function, _args];            \
			if (isNil QGVAR(TRIPLES(waitAndExec,command,handle))) then {                                       \
                GVAR(TRIPLES(waitAndExec,command,handle)) = [_getter,inverse] call CBA_fnc_initWaitAndExecPFH; \
			};                                                                                                 \
		}
		CASE(diag_ticktime,false);
		CASE(diag_frameno,false);
		CASE(time,false);
		CASE(servertime,false);
		CASE(getmusicplayedtime,false);
		CASE(datetonumber,false);
        CASE(playerrespawntime,true);
	};
} else {
	// Scripted getter, convert it to waitUntilAndExecute
	[{
		([] call _this # 0) > (_this # 1)
	},{
		(_this # 2) call (_this # 3);
	},[_getter, ([] call _getter) + _delay, _args, _function]] call CBA_fnc_waitUntilAndExecute;
};

nil

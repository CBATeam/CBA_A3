#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_waitAndExecute

Description:
    Executes a code once in unscheduled environment with a given game time delay.
    Note that unlike PFEH, the delay is in CBA_missionTime not diag_tickTime (will be adjusted for time accl).

Parameters:
    _function - The function you wish to execute. [Code]
    _args     - Parameters passed to the function executing. [Any, defaults to []]
    _delay    - The amount of time in seconds before the code is executed. [Number, defaults to 0]
    _getter   - Command evaluated to get the current "time", available options: [String, Code, defaults to "cba_missiontime"]
                "cba_missiontime"    - Savegame compatible and JIP synced time (Default)
                "diag_ticktime"      - Real time in seconds spent from the start of the game
                "diag_frameno"       - Current number of frame displayed.
                "time"               - Time elapsed since mission start, different for each client.
                "servertime"         - Time since last server restart, synced every 5 minutes.
                "getmusicplayedtime" - Elapsed time on current playing music track.
                "datetonumber"       - Day number / 365.
                "playerrespawntime"  - Time remaining before respawn. Condition and sorting is inverted here.
                {Code}               - Custom function for getting time, passed to CBA_fnc_waitUntilAndExecute

Passed Arguments:
    _this     - Parameters passed by this function. Same as '_args' above. [Any]

Returns:
    Nothing

Examples:
    (begin example)
        [{player sideChat format ["5s later! _this: %1", _this];}, ["some","params",1,2,3], 5] call CBA_fnc_waitAndExecute;
    (end)
    (begin example)
        [{player sideChat "5 frames later";}, [], 5, "diag_frameno"] call CBA_fnc_waitAndExecute;
    (end)
    (begin example)
        // Does not take new years into account.
        [{player sideChat "1 month later";}, [], 0.1, "dateToNumber"] call CBA_fnc_waitAndExecute;
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
		#define CASE(id,command,inverse) case QUOTE(id): {                                                \
			GVAR(TRIPLES(waitAndExec,id,Array)) pushBack [command + _delay, _function, _args];            \
			if (isNil QGVAR(TRIPLES(waitAndExec,id,handle))) then {                                       \
                GVAR(TRIPLES(waitAndExec,id,handle)) = [_getter,inverse] call CBA_fnc_initWaitAndExecPFH; \
			};                                                                                            \
		}
		CASE(diag_ticktime,diag_tickTime,false);
		CASE(diag_frameno,diag_frameno,false);
		CASE(time,time,false);
		CASE(servertime,servertime,false);
		CASE(getmusicplayedtime,getmusicplayedtime,false);
		CASE(datetonumber,(datetonumber date),false);
        CASE(playerrespawntime,playerrespawntime,true);
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

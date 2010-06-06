/*
	Script performance measurements, by Sickboy. Originally by Rommel
*/
#include "script_component.hpp"
#define DELAY 1
#define DIFF 1.1
#define INTERVAL 10

/*
	#define QUOTE(A) #A
	#define GVAR(A) my_##A
	#define PUSH(A,B) A set [count A, B]
*/

private ["_entry", "_create", "_dump", "_f"];

if (isNil QUOTE(GVAR(running))) then { GVAR(running) = false };
if (GVAR(running)) exitWith {}; // Already running
GVAR(running) = true;


FUNC(lag) = {
		for "_i" from 0 to 100 do {
			call compile format["nearestObjects [call compile ""player"", [""All""], 5000]"];
		};
};

FUNC(lag2) = {
		{ deleteVehicle _x } forEach _objects; // _x setDamage 1
		_objects = [];
		for "_i" from 0 to 100 do {
			_logic = "LOGIC" createVehicleLocal [0, 0, 0];
			PUSH(_objects,_logic);
		};
};

TRACE_1("Started",GVAR(running));

GVAR(ar) = [];
if (isNil QUOTE(GVAR(log))) then { GVAR(log) = true };
if (isNil QUOTE(GVAR(lag))) then { GVAR(lag) = true };

[] spawn {
	private ["_nextTime", "_objects", "_logic"];
	_nextTime = time + INTERVAL;
	_objects = [];
	while {GVAR(lag)} do {
		waitUntil {time > _nextTime};
		TRACE_1("Lag Started","");
		call FUNC(lag);
		_nextTime = time + INTERVAL;
		TRACE_1("Lag Ended","");
	};
};

_dump = {
	//diag_log format ["%1	%2	%3	%4	%5",count allunits,time,diag_ticktime,diag_fpsmin,diag_fps];
};

_create = {
	private "_pid";
	_pid = [] spawn _dump;
	waituntil {scriptDone _pid};
};

// Output logged information and add warnings when appropriate
[] spawn {
	private ["_nextTime", "_limit", "_a", "_b", "_deltaTick", "_deltaTime", "_logs", "_log", "_do"];
	_nextTime = time + INTERVAL;
	_limit = DELAY * 1.1;
	_logs = [];
	while {GVAR(log)} do {
		waitUntil {time > _nextTime};
		{
			_a = _x select 0; _b = _x select 1;
			_deltaTick = (_b select 0) - (_a select 0);
			_deltaTime = (_b select 1) - (_a select 1);
			_log = [diag_tickTime, time, _a, _b, _deltaTick, _deltaTime];
			_do = false;
			if (_deltaTime > _limit) then { PUSH(_log,"WARNING: Large deltaTime"); PUSH(_log,_deltaTime); _do = true };
			if (_deltaTick > _limit) then { PUSH(_log,"WARNING: Large deltaTick"); PUSH(_log,_deltaTick); _do = true };
			if (_do) then { PUSH(_logs,_log) };
		} forEach GVAR(ar);
		{ diag_log _x } forEach _logs;
		GVAR(ar) = []; _logs = [];
		_nextTime = time + INTERVAL;
	};
};

// Sleep for 1 second, then execute a simple command, and log the delta between the logged times and ticktimes
while {GVAR(log)} do {
	_entry = [[diag_tickTime, time]];
	sleep DELAY;
	[] call _create;
	_entry set [count _entry, [diag_tickTime, time]];
	PUSH(GVAR(ar),_entry);
};

GVAR(ar) = [];
GVAR(running) = false;
TRACE_1("Exit",GVAR(running));

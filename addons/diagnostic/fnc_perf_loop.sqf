/*
	Script performance measurements, by Sickboy. Originally by Rommel
*/
#include "script_component.hpp"
#define DELAY 1
#define DIFF 1.1
#define INTERVAL 10
#define LAG_INTERVAL 2 // INTERVAL

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
		//_unit = if (isNull player) then { allUnits select 0 } else { player };
		for "_i" from 0 to 100 do {
			{ _unit = _x; call compile format["nearestObjects [call compile ""_unit"", [""All""], 5000]"] } forEach allUnits;
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


GVAR(logs) = []; GVAR(ar) = [];
if (isNil QUOTE(GVAR(log))) then { GVAR(log) = true };
if (isNil QUOTE(GVAR(lag))) then { GVAR(lag) = false };
if (isNil QUOTE(GVAR(interactive))) then { GVAR(interactive) = true };

_dump = {
	//diag_log format ["%1	%2	%3	%4	%5",count allunits,time,diag_ticktime,diag_fpsmin,diag_fps];
};

_create = {
	private "_pid";
	_pid = [] spawn _dump;
	waituntil {scriptDone _pid};
};

waitUntil {SLX_XEH_MACHINE select 5}; // waitUntil player ready etc
TRACE_1("Started",GVAR(running));

if (time == 0) then { sleep 0.001 }; // Sleep until after the briefing

// Induce lag by executing commands
[] spawn {
	private ["_nextTime", "_objects", "_logic"];
	_nextTime = time + LAG_INTERVAL;
	_objects = [];
	while {GVAR(lag)} do {
		waitUntil {time > _nextTime};
		TRACE_1("Lag Started","");
		call FUNC(lag);
		_nextTime = time + LAG_INTERVAL;
		TRACE_1("Lag Ended","");
	};
};

// Output logged information and add warnings when appropriate
[] spawn {
	private ["_nextTime", "_limit", "_a", "_b", "_deltaTick", "_deltaTime", "_log", "_do"];
	_nextTime = time + INTERVAL;
	_limit = DELAY * 1.1;
	while {GVAR(log)} do {
		waitUntil {time > _nextTime};
		_ar = GVAR(ar); GVAR(ar) = [];
		{
			// TODO: Also compare the delta between two entries :)
			_a = _x select 0; _b = _x select 1;
			_deltaTick = (_b select 0) - (_a select 0);
			_deltaTime = (_b select 1) - (_a select 1);
			_log = [diag_tickTime, time, _a, _b, _deltaTick, _deltaTime];
			_do = false;
			if (_deltaTime > _limit) then { PUSH(_log,"WARNING: Large deltaTime"); PUSH(_log,_deltaTime); _do = true };
			if (_deltaTick > _limit) then { PUSH(_log,"WARNING: Large deltaTick"); PUSH(_log,_deltaTick); _do = true };
			if (_do) then { PUSH(GVAR(logs),_log) };
		} forEach _ar;
		if (GVAR(interactive)) then {
			// Output at each iteration
			{ diag_log _x } forEach GVAR(logs);
			GVAR(logs) = [];
		};
		_nextTime = time + INTERVAL;
	};
	if !(GVAR(interactive)) then {
		// Output at exit
		{ diag_log _x } forEach GVAR(log);
	};
	GVAR(log) = [];
};

// Sleep for DELAY seconds, then execute a simple command, and log the delta between the logged times and ticktimes
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

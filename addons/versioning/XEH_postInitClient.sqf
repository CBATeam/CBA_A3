#define DEBUG_MODE_FULL
#include "script_component.hpp"

[] spawn {
	waitUntil {!(isNil QUOTE(GVAR(versions_serv)))};
	TRACE_1("",GVAR(versions_serv));
	[GVAR(versions_serv), {call FUNC(version_check)}] call CBA_fnc_hashEachPair;
};

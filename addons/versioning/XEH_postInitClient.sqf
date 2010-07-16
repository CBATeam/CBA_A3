#include "script_component.hpp"

[] spawn {
	waitUntil {!(isNil QUOTE(GVAR(versions_serv)))};
	["CBA_VERSIONING_SERVER", GVAR(versions_serv)] call CBA_fnc_log;
	[GVAR(versions_serv), {call FUNC(version_check)}] call CBA_fnc_hashEachPair;
};

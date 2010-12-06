#include "script_component.hpp"

[] spawn {
	waitUntil {!(isNil QUOTE(GVAR(versions_serv)))};
	if (!SLX_XEH_DisableLogging) then
	{
		diag_log [diag_frameNo, diag_tickTime, time, "CBA_VERSIONING_SERVER", GVAR(versions_serv)];
	};
	[GVAR(versions_serv), {call FUNC(version_check)}] call CBA_fnc_hashEachPair;
};

// Init Post per Object, Directly or add to array for processing at once at start.

#include "script_component.hpp"
#define INITPOST _unit, "Extended_InitPost_EventHandlers"

PARAMS_3(_unit,_isRespawn,_isDelayed);

// Add unit to InitPost mechanism, or else spawn initPost manually (JIP probably)
if (SLX_XEH_MACHINE select 7) then
{
	if (_isDelayed) then { [INITPOST, _isRespawn, _isDelayed] call FUNC(init) } else { [INITPOST, _isRespawn, _isDelayed] spawn FUNC(init) }; // Spawn; Otherwise setVariable won't hold etc
} else {
	// StartInit was not yet done, this unit is spawned in start of mission
	SLX_XEH_objects set [count SLX_XEH_objects, [INITPOST, _isRespawn, _isDelayed]];
};

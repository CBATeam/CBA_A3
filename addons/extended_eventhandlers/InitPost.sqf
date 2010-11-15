#include "script_component.hpp"
#define INITPOST _unit, "Extended_InitPost_EventHandlers"

private ["_unit"];
_unit = _this select 0;

// Add unit to InitPost mechanism, or else spawn initPost manually (JIP probably)
if (SLX_XEH_MACHINE select 7) then
{
	[INITPOST, _isRespawn] spawn SLX_XEH_init; // Spawn; Otherwise setVariable won't hold etc
} else {
	// StartInit was not yet done, this unit is spawned in start of mission
	SLX_XEH_objects set [count SLX_XEH_objects, [INITPOST]];
};

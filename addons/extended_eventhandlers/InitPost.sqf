#include "script_component.hpp"
#define INITPOST _unit, "Extended_InitPost_EventHandlers"

private ["_unit", "_isRespawn", "_isDelayed"];
_unit = _this select 0; _isRespawn = _this select 1; _isDelayed = _this select 2;

// Add unit to InitPost mechanism, or else spawn initPost manually (JIP probably)
if (SLX_XEH_MACHINE select 7) then
{
	if (_isDelayed) then { [INITPOST, _isRespawn, _isDelayed] call SLX_XEH_init } else { [INITPOST, _isRespawn, _isDelayed] spawn SLX_XEH_init }; // Spawn; Otherwise setVariable won't hold etc
} else {
	// StartInit was not yet done, this unit is spawned in start of mission
	SLX_XEH_objects set [count SLX_XEH_objects, [INITPOST, _isRespawn, _isDelayed]];
};

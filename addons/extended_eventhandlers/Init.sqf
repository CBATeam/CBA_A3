private ["_unit"];
_unit = _this select 0;

if (SLX_XEH_MACHINE select 7) then
{
	[_unit, "Extended_InitPost_EventHandlers"] call SLX_XEH_initPost;
} else {
	// StartInit was not yet done, this unit is spawned in start of mission
	SLX_XEH_objects = SLX_XEH_objects + [[_unit, "Extended_InitPost_EventHandlers"]];
};

/*
Function: CBA_fnc_remoteSay
*/
#include "script_component.hpp"
GVAR(say) = _this;
publicVariable QUOTE(GVAR(say));

if (SLX_XEH_MACHINE select 0) then
{
	{ _x say (_this select 1) } forEach (_this select 0);
};
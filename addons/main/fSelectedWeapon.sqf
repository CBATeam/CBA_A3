#include "script_component.hpp"
private ["_unit", "_anim", "_wepstr"];

_unit = _this;
_anim = toArray(toLower(animationState _unit));

if (count(_anim)<20) then
{
	if (animationState _unit == "SLX_LauncherProne" || animationState _unit == "SLX_LauncherStand") then { secondaryWeapon _unit }
	else { [_unit] call mando_my_weapon }
}
else
{
	switch (toString([_anim select 16, _anim select 17, _anim select 18, _anim select 19])) do
	{
		case "wrfl": { primaryWeapon _unit };
		case "wlnr": { secondaryWeapon _unit };
		case "wpst": { _unit call CBA_fGetPistol };
		case "wbin": { "Binocular" };
		case "wnon": { "" };
		default { [_unit] call mando_my_weapon };
	};
};
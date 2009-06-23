/* ----------------------------------------------------------------------------
Function: CBA_fnc_getUnitAnim

Description:
	Get information about a unit's stance and speed.
	
Parameters:

Returns:

Examples:
	(begin example)

	(end)

Author:

---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(getUnitAnim);

private ["_unit", "_anim", "_upos", "_umov", "_dthstr", "_posstr", "_movstr"];

_unit = _this;
_anim = toArray(toLower(animationState _unit));
_upos = "unknown";
_umov = "stop";

if ((vehicle _unit) != _unit) then
{
	_upos = "vehicle";
}
else
{
 	if (count(_anim)<12) exitWith {};
 	_dthstr = toString([_anim select 0, _anim select 1, _anim select 2, _anim select 3]);
	_posstr = toString([_anim select 4, _anim select 5, _anim select 6, _anim select 7]);
	_movstr = toString([_anim select 8, _anim select 9, _anim select 10, _anim select 11]);
	if (_dthstr == "adth" || _dthstr == "slx_") then
	{
		_upos = "prone";
	}
	else
	{
		switch (_posstr) do
		{
			case "ppne": { _upos = "prone"; };
			case "pknl": { _upos = "kneel"; };
			case "perc": { _upos = "stand"; };
			default { _upos = "kneel"; };
		};
	};
	switch (_movstr) do
	{
		case "mstp": { _umov = "stop"; };
		case "mwlk": { _umov = "slow"; };
		case "mrun": { _umov = "normal"; };
		case "meva": { _umov = "fast"; };
		default { _umov = "stop"; };
	};
};

[_upos,_umov]
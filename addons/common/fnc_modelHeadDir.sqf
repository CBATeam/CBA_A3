/* ----------------------------------------------------------------------------
Function: CBA_fnc_modelHeadDir

Description:
	Get the direction of any unit's head.
	
	This can be used on any character model provided it has the "neck" and
	"pilot" mem points defined in the model.

Parameters:
	_unit - Unit to check [Object]

Returns:
	[<NUMBER>, <NUMBER>, <NUMBER>]
		* Direction of unit head
		* Difference angle (negative or positive), e.g how many degrees turning
			to center object horizontally
		* Pitch of head (off of flat plane)

Examples:
	(begin example)
		_data = [object] call CBA_fnc_headDir;
		// => returns direction of objects head
	(end)

TODO:
	Check for mem points.
	Make sure that it doesn't throw an RPT error if executed pre-init/during init

ImplementationNote:
	Model must contain the needed mempoints for the calculations to work. This
	should not be an issue for any ArmA2 models, but I can not guarantee it will
	work on all models all the time. Until there is a way to test for that it
	should be used with some caution and if you are getting invalid results
	then revert to the older method of CBA_fnc_headDir.

Author:
	Nou
---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(modelHeadDir);
private["_modelLogics", "_pilotLogic", "_neckLogic", "_pilotPos", "_neckPos",
	"_polar", "_pitch", "_abs", "_dif", "_world", "_return"];

PARAMS_1(_unit);

_return = [];

if (_unit isKindOf "CAManBase" ) then {
	_modelLogics = _unit getVariable [QUOTE(GVAR(modelLogics)), []];
	if (count _modelLogics == 0) then {
		_pilotLogic = "logic" createVehicleLocal (getPos _unit);
		_pilotLogic attachTo [_unit, [0,0,0], "pilot"];
		_neckLogic = "logic" createVehicleLocal (getPos _unit);
		_neckLogic attachTo [_unit, [0,0,0], "neck"];
		_modelLogics set[0, _pilotLogic];
		_modelLogics set[1, _neckLogic];
		_unit setVariable [QUOTE(GVAR(modelLogics)), _modelLogics];
	};

	_pilotPos = _unit worldToModel (getPosATL (_modelLogics select 0));
	_neckPos = _unit worldToModel (getPosATL (_modelLogics select 1));
	_polar = ([_neckPos, _pilotPos] call BIS_fnc_vectorFromXToY) call CBA_fnc_vect2polar;
	_pitch = (_polar select 2) - 35; // Subtract 35 to compensate for mem point height dif
	_abs = _polar select 1;
	_dif = 0;

	_dif = if (_abs > 180) then {_abs - 360} else {_abs};
	_world = (getDir _unit) + _dif mod 360;
	_return = [_world, _dif, _pitch];
};

_return;
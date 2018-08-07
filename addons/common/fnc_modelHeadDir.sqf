#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_modelHeadDir

Description:
    Get the direction of any unit's head.

    This can be used on any character model provided it has the "neck" and
    "pilot" mem points defined in the model.

    This works for proxy models as well!

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
SCRIPT(modelHeadDir);

params ["_unit"];

private _return = [];

if (_unit isKindOf "CAManBase" ) then {
    private _pilotPos = (_unit selectionPosition "pilot");
    private _neckPos = (_unit selectionPosition "neck");
    private _polar = ([_neckPos, _pilotPos] call BIS_fnc_vectorFromXToY) call CBA_fnc_vect2polar;
    private _pitch = (_polar select 2) - 23; // Subtract to compensate for mem point height dif
    private _abs = _polar select 1;
    private _dif = if (_abs > 180) then {_abs - 360} else {_abs};
    private _world = (getDir _unit) + _dif mod 360;
    _return = [_world, _dif, _pitch];
};

_return;

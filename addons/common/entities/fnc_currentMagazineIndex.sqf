/* ----------------------------------------------------------------------------
Function: CBA_fnc_currentMagazineIndex

Description:
    Finds out the magazine ID of the currently loaded magazine of given unit.

Parameters:
    _unit   - Unit to check <OBJECT>
    _turret - What turret should be examined. <ARRAY>

Returns:
    Magazine ID <STRING>

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(currentMagazineIndex);

params [["_unit", objNull, [objNull]], ["_turret", nil, [[]]]];

private "_magazine";

if (isNil "_turret") then {
    _magazine = currentMagazineDetail _unit splitString "[:]";
} else {
    _magazine = (_unit currentMagazineDetailTurret _turret) splitString "[:]";
};

_magazine param [count _magazine - 1, ""]

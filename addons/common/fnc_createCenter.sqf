/* ----------------------------------------------------------------------------
Function: CBA_fnc_createCenter

Description:
    Selects center if it already exists, creates it if it doesn't yet.

Parameters:
    _side - [SIDE]

Returns:
    Center [Side]

Examples:
    (begin example)
        _group = createGroup ([West] call CBA_fnc_createCenter);
    (end)

Author:
    Sickboy
---------------------------------------------------------------------------- */
#include "script_component.hpp"
private ["_center"];
params ["_side"];
// TODO: Add _side if already a unit exists on this side ? by trying to create one or otherwise
if (_side in GVAR(centers)) then { _side } else { _center = createCenter _side;
    GVAR(centers) pushBack _center;
    _center
};

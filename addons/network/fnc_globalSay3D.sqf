#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_globalSay3D

Description:
    Says sound on all clients in 3D.

Parameters:
    _objects  - Object or array of objects that perform Say <OBJECT, ARRAY>
    _params   - classname or parameter array - see biki: say3d <STRING, ARRAY>
    _range    - Maximum distance from camera to execute command - will be ignored if _params is an array (optional, default: nil) <NUMBER>
    _attach   - Attach created sound to _object (optional, default: false) <BOOL>
    _instant  - Deletes all previously attached sounds to play the current sound immediately (optional, default: false) <BOOL>
    _rndPitch - Randomizes Pitch. True for a Dynamic Range of 10% - Alternative Number of Dynamic Range in Pecentage. Example: 0.15 -> +- 7.5% (optional, default: false) <BOOL, NUMBER>

Returns:
    Nothing

Example:
    (begin example)
        [player, "Alarm", 500] call CBA_fnc_globalSay3D;
        [player, "Alarm", 500, false, false, 0.15] call CBA_fnc_globalSay3D; // Dynamic Range of 15%, resulting in +- 7,5%
    (end)

Author:
    Sickboy, commy2, DartRuffian, OverlordZorn
---------------------------------------------------------------------------- */

params [["_objects", [], [[], objNull]], ["_params", "", ["", []]], ["_distance", nil, [0]], ["_attach", false, [false]], ["_instant", false, [false]], ["_rndPitch", false, [false,0]]];

if (_objects isEqualType objNull) then {
    _objects = [_objects];
};

if (!isNil "_distance" && { _params isEqualType "" } ) then { _params = [_params, _distance]; };

if (_rndPitch isEqualTo true || { _rndPitch isEqualType 0 } ) then {
    private _defaultPitch = 1;
    if (_params isEqualType "") then {
        _params = [_params, 100];
    } else {
        if (count _params > 2) then { _defaultPitch = _params#2; };
    };
    private _dynamicRange = [0.1, _rndPitch] select (_rndPitch isEqualType 0);
    _params set [2, _defaultPitch + random (_dynamicRange/2) * selectRandom [-1,1] ];
};

{
    [QGVAR(say3D), [_x, _params, _attach, _instant]] call CBA_fnc_globalEvent;
} forEach _objects;

nil

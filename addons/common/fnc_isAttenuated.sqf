#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_isAttenuated

Description:
    Checks whether a unit is attenuated.

Parameters:
    _unit - Unit to check <OBJECT>

Returns:
    true - for inside unit that cant hear the outside <BOOL>

Examples:
    (begin example)
        if ([player] call CBA_fnc_isAttenuated) then {
            player sideChat "I cant hear you outside guy!";
        };
    (end)
    
ToDos:
    - API
    - enabledByAnimationSource didnt help the driver of the "special testcase for RHS car windows"

Author:
    shukari
---------------------------------------------------------------------------- */
params ["_unit"];

// outside of the vehicle or turned out
if (isNull objectParent _unit) exitWith {false};
if ([_unit] call CBA_fnc_isTurnedOut) exitWith {false};

// open vehicle
private _vehicle = vehicle _unit;
private _config = configFile >> "CfgVehicles" >> typeOf _vehicle;
private _attenuationType = getText (_config >> "attenuationEffectType");
if (_attenuationType in ["OpenCarAttenuation", "OpenHeliAttenuation"]) exitWith {false};

private _fullCrew = fullCrew _vehicle;
(_fullCrew select (_fullCrew findIf {_unit == _x select 0})) params ["", "_role", "_cargoIndex", "_turretPath", "_isFFV"];
_role = toLower _role;
private _return = true;

// override for enabledByAnimationSource FFVs
private _turret = [_vehicle, _turretPath] call CBA_fnc_getTurret;
private _enabledAnim = getText (_turret >> "enabledByAnimationSource");
if (!(_enabledAnim isEqualTo "") && {_vehicle animationSourcePhase _enabledAnim < 1}) then {
    _isFFV = false;
};

// special testcase for RHS car windows
// if (_vehicle isKindOf "rhsusf_m1025_w" && {_role in ["driver", "turret"]}) then {
    //// will override _isFFV if window is closed
    // _isFFV = _vehicle animationSourcePhase (["ani_window_1", "ani_window_2", "ani_window_4"] param [_cargoIndex + 1, "ani_window_3"]) > 0
// };

// API ???

// FFVs are always outside
if (_isFFV) exitWith {false};

if (_role isEqualTo "driver") exitWith {
    // check for some kind of enabledByAnimationSource
};

if (_role isEqualTo "cargo") exitWith {
    private _attenuateCargo = getArray (_config >> "soundAttenuationCargo");

    // if attenuate array has less elements than the current cargo index, use the last value of the array
    private _cargoIndex = _cargoIndex min (count _attenuateCargo - 1);

    _attenuateCargo param [_cargoIndex, 1] != 0 // return
};

_return

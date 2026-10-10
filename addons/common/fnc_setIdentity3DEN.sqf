#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_setIdentity3DEN
Description:
    Sets Eden attributes relating to the given identity.

Parameters:
    _unit      - Unit <OBJECT>
    _identity  - Class in CfgIdentities (optional, defaults to CBA_identity property in unit's config) <STRING>

Returns:
    None

Examples
    (begin example)
        _unit call CBA_fnc_setIdentity3DEN
    (end)

Author:
    DartRuffian
---------------------------------------------------------------------------- */

params ["_unit", ["_identity", ""]];
TRACE_2("fnc_setIdentity3DEN",_unity,_identity);

if (_identity == "") then {
    _identity = getText (configOf _unit >> "CBA_identity");
};

if (_identity == "") exitWith {};

private _identityConfig = configFile >> "CfgIdentities" >> _identity;
if !(is3DEN && isClass _identityConfig) exitWith {};

private _name = getText (_identityConfig >> "name");
private _nameSound = getText (_identityConfig >> "nameSound");
private _face = getText (_identityConfig >> "face");
private _glasses = getText (_identityConfig >> "glasses");
private _pitch = getNumber (_identityConfig >> "pitch");
private _speaker = getText (_identityConfig >> "speaker");

_unit set3DENAttribute ["unitName", _name];
_unit set3DENAttribute ["NameSound", _nameSound];
_unit set3DENAttribute ["face", _face];
_unit set3DENAttribute ["pitch", _pitch];
_unit set3DENAttribute ["speaker", _speaker];

if (_glasses != "") then {
    _unit addGoggles _glasses;
    save3DENInventory [get3DENEntityID _unit];
};

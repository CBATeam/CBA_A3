/* ----------------------------------------------------------------------------
Function: CBA_fnc_getAnimType

Description:
    Used to determine which weapon unit is currently holding and return proper
    animation type.

    Main types are for pistol, rifle and no weapon.

Parameters:

Returns:

Examples:
    (begin example)

    (end)

Author:

---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(getAnimType);

private ["_anim", "_weapon", "_pos"];

params ["_man","_array"];
_anim = "";
_weapon = format["%1", currentWeapon _man];
_pos = "";

if (_weapon != "") then {
    _class = configFile >> "CfgWeapons" >> _weapon;

    if (isClass _class) then {
        _temp = "";
        while { isClass _class && {_temp == ""} } do {
            _temp = switch (configName _class) do {
                case "RifleCore": {"rfl"};
                case "LauncherCore": {"lnr"};
                case "PistolCore": {"pst"};
                default {""};
            };
            _class = inheritsFrom _class;
        };
        _weapon = _temp;
    } else {
        // If some unknown class used.
        //_anim = _array select 0;
        _weapon = "";
    };
};

if (typeName (_array select 0) == "ARRAY") then {
    _stance = (_man call CBA_fnc_getUnitAnim) select 0;
    _pos = switch ( _stance ) do {
        case "stand": {0};
        case "kneel": {1};
        case "prone": {2};
        default {0};
    };
    private "_num";
    _num = switch ( _weapon ) do {
        case "rfl": {0};
        case "lnr": {1};
        case "pst": {2};
        default {3};
    };
    _array = (_array select _num) select _pos;
    _anim = _array call BIS_fnc_selectRandom;

    if ( _anim == "") then { _anim = "AdthPercMstpSnonWnonDnon_1"; };
} else {
    private "_num";
    _num = switch ( _weapon ) do {
        case "rfl": {0};
        case "lnr": {2};
        case "pst": {1};
        default {2};
    };
    _anim = _array select _num;
    if ( _anim == "") then { _anim = "AmovPpneMstpSrasWrflDnon_healed"; };
};

// Debug
TRACE_3("",_weapon,_pos,_anim);

_anim

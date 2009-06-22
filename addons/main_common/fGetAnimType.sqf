#include "script_component.hpp"
//  This script is called by onPlayerHit.sqf
//
//  Used to determine which weapon unit is currently holding and return proper animation type.
//  Main types are for pistol, rifle and no weapon.

private ["_man", "_array", "_anim", "_type", "_weapon", "_pos"];

_man = _this select 0;
_array = _this select 1;
_anim = "";
_type = "";
_weapon = format["%1", _man call CBA_fSelectedWeapon];
_pos = "";

if (_weapon != "") then {
    _class = configFile >> "CfgWeapons" >> _weapon;

    if (isClass _class) then {
        _temp = "";
        while { isClass _class && _temp == "" } do {
            switch (configName _class) do {
                case "RifleCore":
                {
                    _temp = "rfl";
                };
                case "LauncherCore":
                {
                    _temp = "lnr";
                };
                case "PistolCore":
                {
                    _temp = "pst";
                };
            };
            _class = inheritsFrom _class;
        };
        _weapon = _temp;
    }
    else
    {
        // If some unknown class used.
        //_anim = _array select 0;
        _weapon = "";
    };
};

if (typeName (_array select 0) == "ARRAY") then {
    _stance = (_man call CBA_fGetUnitStance) select 0;
    _pos = 0;
    if (_stance == "stand") then { _pos = 0; };
    if (_stance == "kneel") then { _pos = 1; };
    if (_stance == "prone") then { _pos = 2; };
    _num = 0;
    switch ( _weapon ) do {
        case "rfl": { _num = 0; };
        case "lnr": { _num = 1; };
        case "pst": { _num = 2; };
        default { _num = 3; };
    };
    _array = (_array select _num) select _pos;
    _anim = _array select round(random (count _array - 1));

    if ( _anim == "") then { _anim = "AdthPercMstpSnonWnonDnon_1"; };
}
else
{
    _num = 0;
    switch ( _weapon ) do {
        case "rfl": { _num = 0; };
        case "lnr": { _num = 2; };
        case "pst": { _num = 1; };
        default { _num = 2; };
    };
    _anim = _array select _num;

    if ( _anim == "") then { _anim = "AmovPpneMstpSrasWrflDnon_healed"; };
};

// Debug
#ifdef DEBUG
	[format["fGetAnimType.sqf: _weapon = %1, _pos = %2, _anim = %3", _weapon,_pos,_anim]] call CBA_fDebug };
#endif

_anim
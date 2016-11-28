#include "script_component.hpp"

params ["_itemType","_switchTo"];
//_itemType = _this select 0; // 0: muzzle, 1: rail, 2: optic
//_switchTo = _this select 1; // "next" or "prev"

private ["_currWeaponType","_currItem","_switchItem"];
private _unit = call CBA_fnc_currentUnit;
private _cw = currentWeapon _unit;

_currWeaponType = call {
    if (_cw == primaryWeapon _unit) exitWith {_currItem = (primaryWeaponItems _unit) select _itemType; 0};
    if (_cw == handgunWeapon _unit) exitWith {_currItem = (handgunItems _unit) select _itemType; 1};
    if (_cw == secondaryWeapon _unit) exitWith {_currItem = (secondaryWeaponItems _unit) select _itemType; 2};
    _currItem = "";
    -1
};
if (_currWeaponType < 0) exitWith {hint "You are not holding a weapon!"; false};

#define __cfgWeapons configfile >> "CfgWeapons"
#define __currItem __cfgWeapons >> _currItem

_switchItem = if (_switchTo == "next") then {(__currItem >> "MRT_SwitchItemNextClass") call bis_fnc_getcfgdata} else {(__currItem >> "MRT_SwitchItemPrevClass") call bis_fnc_getcfgdata};

if (!isNil "_switchItem") then {
    switch (_currWeaponType) do {
        case 0: {
            _unit removePrimaryWeaponItem _currItem;
            _unit addPrimaryWeaponItem _switchItem;
        };
        case 1: {
            _unit removeHandgunItem _currItem;
            _unit addHandgunItem _switchItem;
        };
        case 2: {
            _unit removeSecondaryWeaponItem _currItem;
            _unit addSecondaryWeaponItem _switchItem;
        };
    };
    private _switchItemHintText = (__cfgWeapons >> _switchItem >> "MRT_SwitchItemHintText") call bis_fnc_getcfgdata;
    if (!isNil "_switchItemHintText") then {
        hintSilent format ["%1",_switchItemHintText];
    };
    playSound "click";
} else {
    playSound "ClickSoft";
};

true

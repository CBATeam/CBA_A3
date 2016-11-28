#include "script_component.hpp"

params ["_itemType","_switchTo"];
//_itemType = _this select 0; // 0: muzzle, 1: rail, 2: optic
//_switchTo = _this select 1; // "next" or "prev"

private ["_currWeaponType","_currItem","_switchItem"];
private _cw = currentWeapon player;

_currWeaponType = call {
    if (_cw == primaryWeapon player) exitWith {_currItem = (primaryWeaponItems player) select _itemType; 0};
    if (_cw == handgunWeapon player) exitWith {_currItem = (handgunItems player) select _itemType; 1};
    if (_cw == secondaryWeapon player) exitWith {_currItem = (secondaryWeaponItems player) select _itemType; 2};
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
            player removePrimaryWeaponItem _currItem;
            player addPrimaryWeaponItem _switchItem;
        };
        case 1: {
            player removeHandgunItem _currItem;
            player addHandgunItem _switchItem;
        };
        case 2: {
            player removeSecondaryWeaponItem _currItem;
            player addSecondaryWeaponItem _switchItem;
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

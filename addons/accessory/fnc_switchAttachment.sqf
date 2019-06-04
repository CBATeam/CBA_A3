#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_accessory_fnc_switchAttachment

Description:
    Switches weapon accessories for the player.

Parameters:
    0: _itemType         - Attachment type (0: muzzle, 1: rail, 2: optic). <NUMBER>
    1: _switchTo         - Switch to "next" or "prev" attachement <STRING>

Returns:
    _success - If switching was possible and keybind should be handeled <BOOLEAN>

Examples:
    (begin example)
        [1, "next"] call CBA_accessory_fnc_switchAttachment;
        [2, "prev"] call CBA_accessory_fnc_switchAttachment;
    (end)

Author:
    Robalo, optimized by Anton
---------------------------------------------------------------------------- */

params ["_itemType", "_switchTo"];

private ["_currItem", "_switchItem"];
private _unit = call CBA_fnc_currentUnit;
private _cw = currentWeapon _unit;

private _currWeaponType = call {
    if (_cw == "") exitWith {_currItem = ""; -1};
    if (_cw == primaryWeapon _unit) exitWith {_currItem = (primaryWeaponItems _unit) select _itemType; 0};
    if (_cw == handgunWeapon _unit) exitWith {_currItem = (handgunItems _unit) select _itemType; 1};
    if (_cw == secondaryWeapon _unit) exitWith {_currItem = (secondaryWeaponItems _unit) select _itemType; 2};
    _currItem = "";
    -1
};
if (_currWeaponType < 0) exitWith {hint "You are not holding a weapon!"; false};

#define __cfgWeapons configfile >> "CfgWeapons"
#define __currItem __cfgWeapons >> _currItem

// Get the next/previous item from the attachement's config, but ignore inherited values
private _configs = if (_switchTo == "next") then {
    configProperties [__currItem, "configName _x == 'MRT_SwitchItemNextClass'", false];
} else {
    configProperties [__currItem, "configName _x == 'MRT_SwitchItemPrevClass'", false];
};
if (!(_configs isEqualTo [])) then {
    _switchItem = getText (_configs select 0);
};
TRACE_3("",_currItem,_switchTo,_switchItem);

if (!isNil "_switchItem") then {
    switch (_currWeaponType) do {
        case 0: {
            _unit removePrimaryWeaponItem _currItem;
            [{_this#0 addPrimaryWeaponItem _this#1}, [_unit, _switchItem]] call CBA_fnc_execNextFrame;
        };
        case 1: {
            _unit removeHandgunItem _currItem;
            [{_this#0 addHandgunItem _this#1}, [_unit, _switchItem]] call CBA_fnc_execNextFrame;
        };
        case 2: {
            _unit removeSecondaryWeaponItem _currItem;
            [{_this#0 addSecondaryWeaponItem _this#1}, [_unit, _switchItem]] call CBA_fnc_execNextFrame;
        };
    };
    private _switchItemHintText = getText (__cfgWeapons >> _switchItem >> "MRT_SwitchItemHintText");
    if !(_switchItemHintText isEqualTo "") then {
        hintSilent format ["%1", _switchItemHintText];
    };
    playSound "click";
    [{["CBA_attachmentSwitched", _this] call CBA_fnc_localEvent}, [_unit, _currItem, _switchItem, _currWeaponType]] call CBA_fnc_execNextFrame;
} else {
    playSound "ClickSoft";
};

true

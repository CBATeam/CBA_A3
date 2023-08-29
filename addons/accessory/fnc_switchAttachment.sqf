#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_accessory_fnc_switchAttachment

Description:
    Switches weapon accessories for the player.

Parameters:
    0: _itemType         - Attachment type (0: muzzle, 1: rail, 2: optic, 3: bipod). <NUMBER>
    1: _switchTo         - Switch to "next" or "prev" attachement <STRING>

Returns:
    _success - If switching was possible and keybind should be handled <BOOLEAN>

Examples:
    (begin example)
        [1, "next"] call CBA_accessory_fnc_switchAttachment;
        [2, "prev"] call CBA_accessory_fnc_switchAttachment;
    (end)

Author:
    Robalo, optimized by Anton
---------------------------------------------------------------------------- */

params ["_itemType", "_switchTo"];
if (!isNull curatorCamera) exitWith {};

private ["_currItem", "_switchItem"];
private _unit = call CBA_fnc_currentUnit;
private _cw = currentWeapon _unit;

if !(_unit call CBA_fnc_canUseWeapon) exitWith {false};

private _currWeaponType = call {
    if (_cw == "") exitWith {_currItem = ""; -1};
    if (_cw == primaryWeapon _unit) exitWith {_currItem = (primaryWeaponItems _unit) select _itemType; 0};
    if (_cw == handgunWeapon _unit) exitWith {_currItem = (handgunItems _unit) select _itemType; 1};
    if (_cw == secondaryWeapon _unit) exitWith {_currItem = (secondaryWeaponItems _unit) select _itemType; 2};
    _currItem = "";
    -1
};
if (_currWeaponType < 0) exitWith {false};

private _cfgWeapons = configfile >> "CfgWeapons";

private _testItem = _currItem;
while {_testItem != ""} do {
    // Get the next/previous item from the attachement's config, but ignore inherited values
    private _configs = if (_switchTo == "next") then {
        configProperties [_cfgWeapons >> _testItem, "configName _x == 'MRT_SwitchItemNextClass'", false];
    } else {
        configProperties [_cfgWeapons >> _testItem, "configName _x == 'MRT_SwitchItemPrevClass'", false];
    };
    
    if (_configs isEqualTo []) then {
        _testItem = "";
    } else {
        _testItem = getText (_configs select 0);
        if (_testItem == "") exitWith {};
        if (_testItem == _currItem) exitWith { _testItem = ""; }; // same as start (full loop)
        private _usageArray = GVAR(usageHash) getOrDefault [_testItem, []];
        if ((_usageArray findIf {([_testItem] call _x) isEqualTo false}) == -1) then { // none returned false
            _switchItem = _testItem;
        };
    };
};
TRACE_3("",_currItem,_switchTo,_switchItem);

if (!isNil "_switchItem") then {
    switch (_currWeaponType) do {
        case 0: {
            _unit removePrimaryWeaponItem _currItem;
            [{
                params ["_unit", "", "_switchItem"];
                _unit addPrimaryWeaponItem _switchItem;
                ["CBA_attachmentSwitched", _this] call CBA_fnc_localEvent;
            }, [_unit, _currItem, _switchItem, _currWeaponType]] call CBA_fnc_execNextFrame;
        };
        case 1: {
            _unit removeHandgunItem _currItem;
            [{
                params ["_unit", "", "_switchItem"];
                _unit addHandgunItem _switchItem;
                ["CBA_attachmentSwitched", _this] call CBA_fnc_localEvent;
            }, [_unit, _currItem, _switchItem, _currWeaponType]] call CBA_fnc_execNextFrame;
        };
        case 2: {
            _unit removeSecondaryWeaponItem _currItem;
            [{
                params ["_unit", "", "_switchItem"];
                _unit addSecondaryWeaponItem _switchItem;
                ["CBA_attachmentSwitched", _this] call CBA_fnc_localEvent;
            }, [_unit, _currItem, _switchItem, _currWeaponType]] call CBA_fnc_execNextFrame;
        };
    };
    private _configSwitchItem = _cfgWeapons >> _switchItem;
    private _switchItemHintText = getText (_configSwitchItem >> "MRT_SwitchItemHintText");
    private _switchItemHintImage = getText (_configSwitchItem >> "picture");
    if (_switchItemHintText isNotEqualTo "") then {
        [[_switchItemHintImage, 2.0], [_switchItemHintText], true] call CBA_fnc_notify;
    };
    playSound "click";
} else {
    playSound "ClickSoft";
};

true

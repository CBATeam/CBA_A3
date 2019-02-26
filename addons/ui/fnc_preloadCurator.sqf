#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: cba_ui_fnc_preloadCurator

Description:
    Preload Zeus ammo box item list.

Parameters:
    None

Returns:
    true: preloaded successfully, false: already preloaded <BOOL>

Examples:
    (begin example)
        call cba_ui_fnc_preloadCurator
    (end)

Notes:
    To disable cache use in init.sqf: RscAttrbuteInventory_weaponAddons = nil;

Author:
    commy2
---------------------------------------------------------------------------- */

if (!isNil {uiNamespace getVariable QGVAR(curatorItemCache)}) exitWith {
    INFO("Curator item list already preloaded.");
    false
};

private _list = [];
uiNamespace setVariable [QGVAR(curatorItemCache), _list];

private _types = [
    ["AssaultRifle","Shotgun","Rifle","SubmachineGun"],
    ["MachineGun"],
    ["SniperRifle"],
    ["Launcher","MissileLauncher","RocketLauncher"],
    ["Handgun"],
    ["UnknownWeapon"],
    ["AccessoryMuzzle","AccessoryPointer","AccessorySights","AccessoryBipod"],
    ["Uniform"],
    ["Vest"],
    ["Backpack"],
    ["Headgear","Glasses"],
    ["Binocular","Compass","FirstAidKit","GPS","LaserDesignator","Map","Medikit","MineDetector","NVGoggles","Radio","Toolkit","Watch","UAVTerminal"]
];

//--- Weapons, Magazines and Items
private _cfgPatches = configFile >> "CfgPatches";
private _cfgVehicles = configFile >> "CfgVehicles";
private _cfgWeapons = configFile >> "CfgWeapons";
private _cfgMagazines = configFile >> "CfgMagazines";

private _magazines = [];

{
    private _patchConfig = _cfgPatches >> _x;
    _addon = toLower _x;

    private _addonList = [[],[],[],[],[],[],[],[],[],[],[],[]];

    {
        private _item = toLower _x;
        (_item call BIS_fnc_itemType) params ["_itemCategory", "_itemType"];

        private _index = -1;
        {
            if (_itemType in _x) exitWith {
                _index = _forEachIndex;
            };
        } forEach _types;

        if (_index >= 0 && {_itemCategory != "VehicleWeapon"}) then {
            private _weaponConfig = _cfgWeapons >> _item;
            private _isPublic = getNumber (_weaponConfig >> "scope") == 2;
            private _listItem = _addonList select _index;

            if (_isPublic) then {
                _displayName = getText (_weaponConfig >> "displayName");

                // append display name with attachment names
                {
                    _displayName = format [
                        "%1 + %2",
                        _displayName,
                        getText (_cfgWeapons >> getText (_x >> "item") >> "displayName")
                    ];
                } forEach ("true" configClasses (_weaponConfig >> "linkeditems")); //configProperties [_weaponConfig >> "linkeditems", "isClass _x"];

                private _displayNameShort = _displayName;
                private _displayNameShortArray = toArray _displayNameShort;

                if (count _displayNameShortArray > 41) then {
                    _displayNameShortArray resize 41;
                    _displayNameShort = format ["%1...", toString _displayNameShortArray];
                };

                _listItem pushBack [
                    _item,
                    _displayName,
                    _displayNameShort,
                    getText (_weaponConfig >> "picture"),
                    parseNumber (getNumber (_weaponConfig >> "type") in [4096, 131072]),
                    false
                ];
            };

            //--- Magazines
            if (_isPublic || {_item in ["throw","put"]}) then {
                {
                    private _muzzleConfig = _weaponConfig;

                    if (_x != "this") then {
                        _muzzleConfig = _weaponConfig >> _x;
                    };

                    {
                        private _item = toLower _x;

                        if ({_x select 0 == _item} count _listItem == 0) then {
                            private _magazineConfig = _cfgMagazines >> _item;

                            if (getNumber (_magazineConfig >> "scope") == 2) then {
                                private _displayName = getText (_magazineConfig >> "displayName");

                                _listItem pushBack [
                                    _item,
                                    _displayName,
                                    _displayName,
                                    getText (_magazineConfig >> "picture"),
                                    2,
                                    _item in _magazines
                                ];

                                _magazines pushBack _item;
                            };
                        };
                    } forEach getArray (_muzzleConfig >> "magazines");
                } forEach getArray (_weaponConfig >> "muzzles");
            };
        };
    } forEach getArray (_patchConfig >> "weapons");

    {
        private _item = toLower _x;
        private _weaponConfig = _cfgVehicles >> _item;

        if (getNumber (_weaponConfig >> "isBackpack") == 1 && {getNumber (_weaponConfig >> "scope") == 2}) then {
            private _itemType = _item call BIS_fnc_itemType select 1;

            private _index = -1;
            {
                if (_itemType in _x) exitWith {
                    _index = _forEachIndex;
                };
            } forEach _types;

            if (_index >= 0) then {
                private _displayName = getText (_weaponConfig >> "displayName");

                (_addonList select _index) pushBack [
                    _item,
                    _displayName,
                    _displayName,
                    getText (_weaponConfig >> "picture"),
                    3,
                    false
                ];
            };
        };
    } forEach getArray (_patchConfig >> "units");

    _list append [_addon, _addonList];
} forEach call (uiNamespace getVariable QEGVAR(common,addons));

true

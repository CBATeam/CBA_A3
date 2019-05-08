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

private _itemTypes = call CBA_fnc_createNamespace;
_itemTypes setVariable ["AssaultRifle", 0];
_itemTypes setVariable ["Shotgun", 0];
_itemTypes setVariable ["Rifle", 0];
_itemTypes setVariable ["SubmachineGun", 0];
_itemTypes setVariable ["MachineGun", 1];
_itemTypes setVariable ["SniperRifle", 2];
_itemTypes setVariable ["Launcher", 3];
_itemTypes setVariable ["MissileLauncher", 3];
_itemTypes setVariable ["RocketLauncher", 3];
_itemTypes setVariable ["Handgun", 4];
_itemTypes setVariable ["UnknownWeapon", 5];
_itemTypes setVariable ["AccessoryMuzzle", 6];
_itemTypes setVariable ["AccessoryPointer", 6];
_itemTypes setVariable ["AccessorySights", 6];
_itemTypes setVariable ["AccessoryBipod", 6];
_itemTypes setVariable ["Uniform", 7];
_itemTypes setVariable ["Vest", 8];
_itemTypes setVariable ["Backpack", 9];
_itemTypes setVariable ["Headgear", 10];
_itemTypes setVariable ["Glasses", 10];
_itemTypes setVariable ["Binocular", 11];
_itemTypes setVariable ["Compass", 11];
_itemTypes setVariable ["FirstAidKit", 11];
_itemTypes setVariable ["GPS", 11];
_itemTypes setVariable ["LaserDesignator", 11];
_itemTypes setVariable ["Map", 11];
_itemTypes setVariable ["Medikit", 11];
_itemTypes setVariable ["MineDetector", 11];
_itemTypes setVariable ["NVGoggles", 11];
_itemTypes setVariable ["Radio", 11];
_itemTypes setVariable ["Toolkit", 11];
_itemTypes setVariable ["Watch", 11];
_itemTypes setVariable ["UAVTerminal", 11];

//--- Weapons, Magazines and Items
private _cfgPatches = configFile >> "CfgPatches";
private _cfgVehicles = configFile >> "CfgVehicles";
private _cfgWeapons = configFile >> "CfgWeapons";
private _cfgMagazines = configFile >> "CfgMagazines";

private _magazines = [];
private _magazinesLists = [];

{
    private _patchConfig = _cfgPatches >> _x;
    _addon = toLower _x;

    private _addonList = [[],[],[],[],[],[],[],[],[],[],[],[]];

    {
        private _item = toLower _x;
        (_item call BIS_fnc_itemType) params ["_itemCategory", "_itemType"];

        private _index = _itemTypes getVariable [_itemType, -1];
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
                    _displayName,
                    _displayNameShort,
                    _item,
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

                    private _compatibleMagazines = getArray (_muzzleConfig >> "magazines");
                    {
                        {
                            _compatibleMagazines append getArray _x;
                        } forEach configProperties [configFile >> "CfgMagazineWells" >> _x, "isArray _x"];
                    } foreach getArray (_muzzleConfig >> "magazineWell");

                    {
                        private _item = toLower _x;

                        if (_magazinesLists pushBackUnique [_item, _listItem] != -1) then {
                            private _magazineConfig = _cfgMagazines >> _item;

                            if (getNumber (_magazineConfig >> "scope") == 2) then {
                                private _displayName = getText (_magazineConfig >> "displayName");

                                _listItem pushBack [
                                    _displayName,
                                    _displayName,
                                    _item,
                                    getText (_magazineConfig >> "picture"),
                                    2,
                                    _item in _magazines
                                ];

                                _magazines pushBack _item;
                            };
                        };
                    } forEach _compatibleMagazines;
                } forEach getArray (_weaponConfig >> "muzzles");
            };
        };
    } forEach getArray (_patchConfig >> "weapons");

    {
        private _item = toLower _x;
        private _weaponConfig = _cfgVehicles >> _item;

// In case you are executing the unit test with addons loaded, should an addon
// use the same classname in CfgVehicles and CfgWeapons this isBackpack
// optimization prevents the item from added by twice.
#ifdef DEBUG_MODE_FULL
        if (getNumber (_weaponConfig >> "scope") == 2)
#else
        if (getNumber (_weaponConfig >> "isBackpack") == 1 && {getNumber (_weaponConfig >> "scope") == 2})
#endif
        then {
            private _itemType = _item call BIS_fnc_itemType select 1;

            private _index = _itemTypes getVariable [_itemType, -1];
            if (_index >= 0) then {
                private _displayName = getText (_weaponConfig >> "displayName");

                (_addonList select _index) pushBack [
                    _displayName,
                    _displayName,
                    _item,
                    getText (_weaponConfig >> "picture"),
                    3,
                    false
                ];
            };
        };
    } forEach getArray (_patchConfig >> "units");

    _list append [_addon, _addonList];
} forEach call (uiNamespace getVariable QEGVAR(common,addons));

_itemTypes call CBA_fnc_deleteNamespace;

true

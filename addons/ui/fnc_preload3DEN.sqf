#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: cba_ui_fnc_preload3DEN

Description:
    Preload 3den editor ammo box item list.

Parameters:
    None

Returns:
    true: preloaded successfully, false: already preloaded <BOOL>

Examples:
    (begin example)
        call cba_ui_fnc_preload3DEN
    (end)

Notes:
    To disable cache use: uiNamespace setVariable ["AmmoBox_list", nil];

Author:
    commy2
---------------------------------------------------------------------------- */

if (!isNil {uiNamespace getVariable "AmmoBox_list"}) exitWith {
    INFO("3DEN item list already preloaded.");
    false
};

private _list = [[],[],[],[],[],[],[],[],[],[],[],[]];
uiNamespace setVariable ["AmmoBox_list", _list];

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
private _cfgWeapons = configFile >> "CfgWeapons";
private _cfgMagazines = configFile >> "CfgMagazines";

private _magazines = [];
private _magazinesLists = [];

{
    private _item = toLower configName _x;
    (_item call BIS_fnc_itemType) params ["_itemCategory", "_itemType"];

    private _index = _itemTypes getVariable [_itemType, -1];
    if (_index >= 0 && {_itemCategory != "VehicleWeapon"}) then {
        private _weaponConfig = _x;
        private _isPublic = getNumber (_weaponConfig >> "scope") == 2;
        private _listItem = _list select _index;

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

            _listItem pushBack [
                _displayName,
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

                {
                    private _item = toLower _x;

                    if (_magazinesLists pushBackUnique [_item, _listItem] != -1) then {
                        private _magazineConfig = _cfgMagazines >> _item;

                        if (getNumber (_magazineConfig >> "scope") == 2) then {
                            _listItem pushBack [
                                getText (_magazineConfig >> "displayName"),
                                _item,
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
} forEach ("true" configClasses _cfgWeapons);

//--- Backpacks
{
// In case you are executing the unit test with addons loaded, should an addon
// use the same classname in CfgVehicles and CfgWeapons this isBackpack
// optimization prevents the item from added by twice.
#ifdef DEBUG_MODE_FULL
    if (getNumber (_x >> "scope") == 2)
#else
    if (getNumber (_x >> "isBackpack") == 1 && {getNumber (_x >> "scope") == 2})
#endif
    then {
        private _item = toLower configName _x;
        private _itemType = _item call BIS_fnc_itemType select 1;

        private _index = _itemTypes getVariable [_itemType, -1];
        if (_index >= 0) then {
            (_list select _index) pushBack [
                getText (_x >> "displayName"),
                _item,
                getText (_x >> "picture"),
                3,
                false
            ];
        };
    };
} forEach ("true" configClasses (configFile >> "CfgVehicles"));

//--- Glasses
private _listHeadgear = _list select 10;

{
    if (getNumber (_x >> "scope") == 2) then {
        _listHeadgear pushBack [
            getText (_x >> "displayName"),
            toLower configName _x,
            getText (_x >> "picture"),
            3,
            false
        ];
    };
} forEach ("true" configClasses (configFile >> "CfgGlasses"));

{
    _x sort true;
} forEach _list;

true

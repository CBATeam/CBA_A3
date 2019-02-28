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

[] spawn {
diag_log "x: preload started";

private _iterationsLeft = 10;

private _list = [[],[],[],[],[],[],[],[],[],[],[],[]];

private _itemTypes = [
    "AssaultRifle","Shotgun","Rifle","SubmachineGun",
    "MachineGun",
    "SniperRifle",
    "Launcher","MissileLauncher","RocketLauncher",
    "Handgun",
    "UnknownWeapon",
    "AccessoryMuzzle","AccessoryPointer","AccessorySights","AccessoryBipod",
    "Uniform",
    "Vest",
    "Backpack",
    "Headgear","Glasses",
    "Binocular","Compass","FirstAidKit","GPS","LaserDesignator","Map","Medikit","MineDetector","NVGoggles","Radio","Toolkit","Watch","UAVTerminal"
];

private _types = [
    0,0,0,0,
    1,
    2,
    3,3,3,
    4,
    5,
    6,6,6,6,
    7,
    8,
    9,
    10,10,
    11,11,11,11,11,11,11,11,11,11,11,11,11
];

//--- Weapons, Magazines and Items
private _cfgWeapons = configFile >> "CfgWeapons";
private _cfgMagazines = configFile >> "CfgMagazines";

private _magazines = [];

{
    _iterationsLeft = _iterationsLeft - 1;
    if (_iterationsLeft <= 0) then {
        systemChat format ["Tick: %1", diag_tickTime]; 
        uiSleep 0.01;
        _iterationsLeft = 10;
    };
    isNil {

    private _item = toLower configName _x;
    (_item call BIS_fnc_itemType) params ["_itemCategory", "_itemType"];

    private _index = _types param [_itemTypes find _itemType, -1];
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

                    if ({_x select 1 == _item} count _listItem == 0) then {
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
    };
} forEach ("true" configClasses _cfgWeapons);
if (!isNil {uiNamespace getVariable "AmmoBox_list"}) exitWith {diag_log "x: alredy built"};

//--- Backpacks
{
    if (getNumber (_x >> "isBackpack") == 1 && {getNumber (_x >> "scope") == 2}) then {
        private _item = toLower configName _x;
        private _itemType = _item call BIS_fnc_itemType select 1;

        private _index = _types param [_itemTypes find _itemType, -1];
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
if (!isNil {uiNamespace getVariable "AmmoBox_list"}) exitWith {diag_log "x: alredy built"};

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

diag_log "x: preload finished";
if (!isNil {uiNamespace getVariable "AmmoBox_list"}) exitWith {diag_log "x: alredy built"};
uiNamespace setVariable ["AmmoBox_list", _list];
};
true

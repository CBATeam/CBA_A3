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
    - curator needs a similar function
    - function can be run without adjustments to the ui init script (opposed to curator)
    - BIS_fnc_itemType caching
    //"\a3\ui_f_curator\UI\RscCommon\RscAttributeInventory.sqf"

Author:
    commy2
---------------------------------------------------------------------------- */






//--- Get weapons and magazines from curator addons
_curator = getassignedcuratorlogic player;
_weaponAddons = missionnamespace getvariable ["RscAttrbuteInventory_weaponAddons",[]];
_types = [
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
_typeMagazine = _types find "Magazine";
_list = [[],[],[],[],[],[],[],[],[],[],[],[]];
_magazines = []; //--- Store magazines in an array and mark duplicates, so nthey don't appear in the list of all items
{
    _addon = tolower _x;
    _addonList = [[],[],[],[],[],[],[],[],[],[],[],[]];
    _addonID = _weaponAddons find _addon;
    if (_addonID < 0) then {
        {
            _weapon = tolower _x;
            _weaponType = (_weapon call bis_fnc_itemType);
            _weaponTypeCategory = _weaponType select 0;
            _weaponTypeSpecific = _weaponType select 1;
            _weaponTypeID = -1;
            {
                if (_weaponTypeSpecific in _x) exitwith {_weaponTypeID = _foreachindex;};
            } foreach _types;
            //_weaponTypeID = _types find (_weaponType select 0);
            if (_weaponTypeCategory != "VehicleWeapon" && _weaponTypeID >= 0) then {
                _weaponCfg = configfile >> "cfgweapons" >> _weapon;
                _weaponPublic = getnumber (_weaponCfg >> "scope") == 2;
                _addonListType = _addonList select _weaponTypeID;
                if (_weaponPublic) then {
                    _displayName = gettext (_weaponCfg >> "displayName");
                    _picture = gettext (_weaponCfg >> "picture");
                    {
                        _item = gettext (_x >> "item");
                        _itemName = gettext (configfile >> "cfgweapons" >> _item >> "displayName");
                        _displayName = _displayName + " + " + _itemName;
                    } foreach ((_weaponCfg >> "linkeditems") call bis_fnc_returnchildren);
                    _displayNameShort = _displayName;
                    _displayNameShortArray = toarray _displayNameShort;
                    if (count _displayNameShortArray > 41) then { //--- Cut when the name is too long (41 chars is approximate)
                        _displayNameShortArray resize 41;
                        _displayNameShort = tostring _displayNameShortArray + "...";
                    };
                    _type = if (getnumber (configfile >> "cfgweapons" >> _weapon >> "type") in [4096,131072]) then {1} else {0};
                    _addonListType pushback [_weapon,_displayName,_displayNameShort,_picture,_type,false];
                };
                //--- Add magazines compatible with the weapon
                if (_weaponPublic || _weapon in ["throw","put"]) then {
                    //_addonListType = _addonList select _typeMagazine;
                    {
                        _muzzle = if (_x == "this") then {_weaponCfg} else {_weaponCfg >> _x};
                        {
                            _mag = tolower _x;
                            if ({(_x select 0) == _mag} count _addonListType == 0) then {
                                _magCfg = configfile >> "cfgmagazines" >> _mag;
                                if (getnumber (_magCfg >> "scope") == 2) then {
                                    _displayName = gettext (_magCfg >> "displayName");
                                    _picture = gettext (_magCfg >> "picture");
                                    _addonListType pushback [_mag,_displayName,_displayName,_picture,2,_mag in _magazines];
                                    _magazines pushback _mag;
                                };
                            };
                        } foreach getarray (_muzzle >> "magazines");
                    } foreach getarray (_weaponCfg >> "muzzles");
                };
            };
        } foreach getarray (configfile >> "cfgpatches" >> _x >> "weapons");
        {
            _weapon = tolower _x;
            _weaponType = _weapon call bis_fnc_itemType;
            _weaponTypeSpecific = _weaponType select 1;
            _weaponTypeID = -1;
            {
                if (_weaponTypeSpecific in _x) exitwith {_weaponTypeID = _foreachindex;};
            } foreach _types;
            //_weaponTypeID = _types find (_weaponType select 0);
            if (_weaponTypeID >= 0) then {
                _weaponCfg = configfile >> "cfgvehicles" >> _weapon;
                if (getnumber (_weaponCfg >> "scope") == 2) then {
                    _displayName = gettext (_weaponCfg >> "displayName");
                    _picture = gettext (_weaponCfg >> "picture");
                    _addonListType = _addonList select _weaponTypeID;
                    _addonListType pushback [_weapon,_displayName,_displayName,_picture,3,false];
                };
            };
        } foreach getarray (configfile >> "cfgpatches" >> _x >> "units");
        _weaponAddons set [count _weaponAddons,_addon];
        _weaponAddons set [count _weaponAddons,_addonList];
    } else {
        _addonList = _weaponAddons select (_addonID + 1);
    };
    {
        _current = _list select _foreachindex;
        _list set [_foreachindex,_current + (_x - _current)];
    } foreach _addonList;
} foreach (curatoraddons _curator);
missionnamespace setvariable ["RscAttrbuteInventory_weaponAddons",_weaponAddons];
RscAttributeInventory_list = _list;

#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_randomizeLoadout

Description:
    Add config defined weighted random weapons, uniforms, vests, headgear, facewear, etc. to a unit.

    CBA_headgearList[] = {}; // default: Use `linkedItems` property
    CBA_headgearList[] = {"H_HelmetHBK_headset_F", 1, "H_HelmetHBK_chops_F", 1}; // 50% headset, 50% chops

    CBA_primaryList[] = {
        // 50% chance for AK-12, with 2 30Rnd magazines and 2 75Rnd magazines
        // 50% chance for hunter shotgun with 3 12 gauge magazines
        {"arifle_AK12_F", {{"30Rnd_762x39_AK12_Mag_F", 2}, {"75Rnd_762x39_Mag_F", 2}}}, 1,
        {"sgun_HunterShotgun_01_F", {{"2Rnd_12Gauge_Pellets", 3}}}, 1
    };

Parameters:
    _unit - unit <OBJECT>

Returns:
    true on success, false on error <BOOLEAN>

Examples:
    (begin example)
        [unit] call CBA_fnc_randomizeLoadout;
    (end)

Author:
    DartRuffian
---------------------------------------------------------------------------- */

#define INDEX_UNIFORM 3
#define INDEX_VEST 4
#define INDEX_BACKPACK 5
#define INDEX_HELMET 6
#define INDEX_FACEWEAR 7
#define INDEX_BINOCULARS 8
#define INDEX_LINKEDITEMS 9

// Note that this is specifically for a loadout array
#define INDEX_NVG 5

params [["_unit", objNull, [objNull]]];

if (isNull _unit) exitWith {
    WARNING_1("Unit [%1] is null",_unit);
    false
};

// Disabled conditions
if (!local _unit) exitWith {true};

private _randomizationDisabled = getArray (missionConfigFile >> "disableRandomization") findIf {
    _unit isKindOf _x || {(vehicleVarName _unit) isEqualTo _x}
} != -1;

if (_randomizationDisabled || {!(_unit getVariable ["BIS_enableRandomization", true])}) exitWith { true };

private _cache = _unit call CBA_fnc_getRandomizedEquipment;

// Exit if unit has no randomization
if (!(_cache select 0)) exitWith { true };
_cache params ["", "_primaryList", "_launcherList", "_handgunList", "_uniformList", "_vestList", "_backpackList", "_headgearList", "_facewearList", "_binocularList", "_nvgList"];

(_unit call CBA_fnc_getLoadout) params ["_loadout", "_extendedInfo"];

{
    _x params ["_loadoutIndex", "_items"];
    if (_items isEqualTo []) then { continue };

    _loadout set [_loadoutIndex, selectRandomWeighted _items];
} forEach [
    [INDEX_HELMET, _headgearList],
    [INDEX_FACEWEAR, _facewearList]
];

{
    _x params ["_loadoutIndex", "_items"];
    if (_items isEqualTo []) then { continue };

    // Handle no item being equipped in the current slot, e.g. ["UniformClass"] would be invalid
    private _section = _loadout select _loadoutIndex;
    if (_section isEqualTo []) then { _section = ["", []] };

    _section set [0, selectRandomWeighted _items];
    _loadout set [_loadoutIndex, _section];
} forEach [
    [INDEX_UNIFORM, _uniformList],
    [INDEX_VEST, _vestList],
    [INDEX_BACKPACK, _backpackList]
];

if (_nvgList isNotEqualTo []) then {
    _loadout select INDEX_LINKEDITEMS set [INDEX_NVG, selectRandomWeighted _nvgList];
};

// Set loadout and then add weapons to avoid issues with conflicting weapon items
[_unit, [_loadout, _extendedInfo]] call CBA_fnc_setLoadout;

if (_binocularList isNotEqualTo []) then {
    private _item = selectRandomWeighted _binocularList;
    private _magazine = (_item call CBA_fnc_compatibleMagazines) param [0, ""]; // For laser designators
    _unit addWeapon _item;
    if (_magazine != "") then {
        _unit addBinocularItem _magazine
    };
};

{
    private _items = _x;
    if (_items isEqualTo []) then { continue };

    // Add a single magazine so the gun is pre-loaded
    // The rest of the magazines are added in PostInit to preserve changes made in Eden
    (selectRandomWeighted _items) params ["_weapon", "_magazineCounts"];
    [_unit, _magazineCounts select 0 select 0] call CBA_fnc_addMagazine;
    _unit addWeapon _weapon;
} forEach [
    _primaryList,
    _launcherList,
    _handgunList
];

if (is3DEN) then {
    // CBA's frame functions don't work in Eden
    _unit spawn {
        sleep 0.1;
        save3DENInventory [get3DENEntityID _this];
    };
};

// Immediately select weapon and set animation
private _fnc_fixAnimation = {
    private _weapons = [primaryWeapon _this, handgunWeapon _this, secondaryWeapon _this];
    private _weaponIndex = _weapons findIf { _x != "" };
    if (_weaponIndex != -1) then {
        _this switchMove (["amovpercmstpsraswrfldnon", "amovpercmstpsraswpstdnon", "amovpercmstpsnonwnondnon"] select _weaponIndex);
        _this selectWeapon (_weapons select _weaponIndex);
    };
};

if (is3DEN) then {
    [_unit, _fnc_fixAnimation] spawn {
        sleep 0.1;
        (_this select 0) call (_this select 1);
    };
} else {
    [_fnc_fixAnimation, _unit] call CBA_fnc_execNextFrame;
};

true;

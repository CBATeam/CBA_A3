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

#define INDEX_PRIMARY 0
#define INDEX_LAUNCHER 1
#define INDEX_HANDGUN 2
#define INDEX_UNIFORM 3
#define INDEX_VEST 4
#define INDEX_BACKPACK 5
#define INDEX_HELMET 6
#define INDEX_FACEWEAR 7
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

if (_randomizationDisabled || {!(_unit getVariable ["BIS_enableRandomization", true])}) exitWith {true};

if (isNull _unit || !(_unit getVariable ["BIS_enableRandomization", true])) exitWith {};

private ["_headgearList", "_uniformList", "_vestList", "_backpackList", "_nvgList", "_facewearList", "_primaryList", "_secondaryList", "_launcherList"];

private _cache = GVAR(randomLoadoutUnits) getOrDefaultCall [typeOf _unit, {
    private _unitConfig = configOf _unit;
    _headgearList = getArray (_unitConfig >> "CBA_headgearList");
    _uniformList = getArray (_unitConfig >> "CBA_uniformList");
    _vestList = getArray (_unitConfig >> "CBA_vestList");
    _backpackList = getArray (_unitConfig >> "CBA_backpackList");
    _nvgList = getArray (_unitConfig >> "CBA_nvgList");
    _facewearList = getArray (_unitConfig >> "CBA_facewearList");

    _primaryList = getArray (_unitConfig >> "CBA_primaryList");
    _secondaryList = getArray (_unitConfig >> "CBA_secondaryList");
    _launcherList = getArray (_unitConfig >> "CBA_launcherList");

    // If all arrays are empty, just cache `[false]` to not save a bunch of empty arrays
    if (_headgearList isEqualTo [] &&
        _uniformList isEqualTo [] &&
        _vestList isEqualTo [] &&
        _backpackList isEqualTo [] &&
        _nvgList isEqualTo [] &&
        _facewearList isEqualTo [] &&
        _primaryList isEqualTo [] &&
        _secondaryList isEqualTo [] &&
        _launcherList isEqualTo []
    ) then { [false] } else {
        [true, _headgearList, _uniformList, _vestList, _backpackList, _nvgList, _facewearList, _primaryList, _secondaryList, _launcherList];
    };
}, true];

// Exit if unit has no randomization
if (!(_cache select 0)) exitWith {};

(_unit call CBA_fnc_getLoadout) params ["_loadout", "_extendedInfo"];

{
    _x params ["_loadoutIndex", "_items"];
    if (_items isEqualTo []) then { continue };

    _loadout set [_loadoutIndex, selectRandomWeighted _items];
} forEach [
    [INDEX_HELMET, _headgearList],
    [INDEX_UNIFORM, _uniformList],
    [INDEX_VEST, _vestList],
    [INDEX_BACKPACK, _backpackList],
    [INDEX_FACEWEAR, _facewearList]
];

if (_nvgList isNotEqualTo []) then {
    _loadout select INDEX_LINKEDITEMS set [INDEX_NVG, selectRandomWeighted _nvgList];
};

{
    _x params ["_loadoutIndex", "_items"];
    if (_items isEqualTo []) then { continue };

    (selectRandomWeighted _items) params ["_weapon", "_magazineCounts"];
    _loadout set [_loadoutIndex, _weapon];

    {
        _x params ["_magazine", "_count"];
        for "_" from 1 to _count do {
            // Exit if magazine can't be added
            if !([_unit, _magazine] call CBA_fnc_addMagazine) exitWith {};
        };
    } forEach _magazineCounts;
} forEach [
    [INDEX_PRIMARY, _primaryList],
    [INDEX_HANDGUN, _secondaryList],
    [INDEX_LAUNCHER, _launcherList]
];

[_unit, [_loadout, _extendedInfo]] call CBA_fnc_setLoadout;
true;

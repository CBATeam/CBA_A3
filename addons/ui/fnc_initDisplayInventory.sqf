#include "script_component.hpp"

// Do nothing if no context menu options exist.
if (isNil QGVAR(ItemContextMenuOptions)) exitWith {};

params ["_display"];

// Slots
private _uniformSlot = _display displayCtrl IDC_FG_UNIFORM_TAB;
private _vestSlot = _display displayCtrl IDC_FG_VEST_TAB;
private _backpackSlot = _display displayCtrl IDC_FG_BACKPACK_TAB;

private _uniformSlotBackground = _display displayCtrl IDC_FG_UNIFORM_TEXT;
private _vestSlotBackground = _display displayCtrl IDC_FG_VEST_TEXT;
private _backpackSlotBackground = _display displayCtrl IDC_FG_BACKPACK_TEXT;

private _headgearSlot = _display displayCtrl IDC_FG_HEADGEAR;
private _glassesSlot = _display displayCtrl IDC_FG_GOGGLES;
private _hmdSlot = _display displayCtrl IDC_FG_HMD;
private _binocularSlot = _display displayCtrl IDC_FG_BINOC;

private _rifleSlot = _display displayCtrl IDC_FG_PRIMARY;
private _rifleSilencerSlot = _display displayCtrl IDC_FG_PW_MUZZLE;
private _rifleBipodSlot = _display displayCtrl IDC_FG_PW_UNDERBARREL;
private _rifleOpticSlot = _display displayCtrl IDC_FG_PW_OPTICS;
private _riflePointerSlot = _display displayCtrl IDC_FG_PW_FLASHLIGHT;
private _rifleMagazine2Slot = _display displayCtrl IDC_FG_PW_MAGAZINE_GL;
private _rifleMagazineSlot = _display displayCtrl IDC_FG_PW_MAGAZINE;

private _launcherSlot = _display displayCtrl IDC_FG_SECONDARY;
private _launcherSilencerSlot = _display displayCtrl IDC_FG_SW_MUZZLE;
private _launcherBipodSlot = _display displayCtrl IDC_FG_SW_UNDERBARREL;
private _launcherOpticSlot = _display displayCtrl IDC_FG_SW_OPTICS;
private _launcherPointerSlot = _display displayCtrl IDC_FG_SW_FLASHLIGHT;
private _launcherMagazineSlot = _display displayCtrl IDC_FG_SW_MAGAZINE;

private _pistolSlot = _display displayCtrl IDC_FG_HANDGUN;
private _pistolSilencerSlot = _display displayCtrl IDC_FG_HG_MUZZLE;
private _pistolBipodSlot = _display displayCtrl IDC_FG_HG_UNDERBARREL;
private _pistolOpticSlot = _display displayCtrl IDC_FG_HG_OPTICS;
private _pistolPointerSlot = _display displayCtrl IDC_FG_HG_FLASHLIGHT;
private _pistolMagazineSlot = _display displayCtrl IDC_FG_HG_MAGAZINE;

private _mapSlot = _display displayCtrl IDC_FG_MAP;
private _gpsSlot = _display displayCtrl IDC_FG_GPS;
private _radioSlot = _display displayCtrl IDC_FG_RADIO;
private _compassSlot = _display displayCtrl IDC_FG_COMPASS;
private _watchSlot = _display displayCtrl IDC_FG_WATCH;

_uniformSlot setVariable [QGVAR(slotType), "UNIFORM"];
_vestSlot setVariable [QGVAR(slotType), "VEST"];
_backpackSlot setVariable [QGVAR(slotType), "BACKPACK"];

_uniformSlotBackground setVariable [QGVAR(slotType), "UNIFORM"];
_vestSlotBackground setVariable [QGVAR(slotType), "VEST"];
_backpackSlotBackground setVariable [QGVAR(slotType), "BACKPACK"];

_headgearSlot setVariable [QGVAR(slotType), "HEADGEAR"];
_glassesSlot setVariable [QGVAR(slotType), "GOGGLES"];
_hmdSlot setVariable [QGVAR(slotType), "HMD"];
_binocularSlot setVariable [QGVAR(slotType), "BINOCULAR"];

_rifleSlot setVariable [QGVAR(slotType), "RIFLE"];
_rifleSilencerSlot setVariable [QGVAR(slotType), "RIFLE_SILENCER"];
_rifleBipodSlot setVariable [QGVAR(slotType), "RIFLE_BIPOD"];
_rifleOpticSlot setVariable [QGVAR(slotType), "RIFLE_OPTIC"];
_riflePointerSlot setVariable [QGVAR(slotType), "RIFLE_POINTER"];
_rifleMagazine2Slot setVariable [QGVAR(slotType), "RIFLE_MAGAZINE_GL"];
_rifleMagazineSlot setVariable [QGVAR(slotType), "RIFLE_MAGAZINE"];

_launcherSlot setVariable [QGVAR(slotType), "LAUNCHER"];
_launcherSilencerSlot setVariable [QGVAR(slotType), "LAUNCHER_SILENCER"];
_launcherBipodSlot setVariable [QGVAR(slotType), "LAUNCHER_BIPOD"];
_launcherOpticSlot setVariable [QGVAR(slotType), "LAUNCHER_OPTIC"];
_launcherPointerSlot setVariable [QGVAR(slotType), "LAUNCHER_POINTER"];
_launcherMagazineSlot setVariable [QGVAR(slotType), "LAUNCHER_MAGAZINE"];

_pistolSlot setVariable [QGVAR(slotType), "PISTOL"];
_pistolSilencerSlot setVariable [QGVAR(slotType), "PISTOL_SILENCER"];
_pistolBipodSlot setVariable [QGVAR(slotType), "PISTOL_BIPOD"];
_pistolOpticSlot setVariable [QGVAR(slotType), "PISTOL_OPTIC"];
_pistolPointerSlot setVariable [QGVAR(slotType), "PISTOL_POINTER"];
_pistolMagazineSlot setVariable [QGVAR(slotType), "PISTOL_MAGAZINE"];

_mapSlot setVariable [QGVAR(slotType), "MAP"];
_gpsSlot setVariable [QGVAR(slotType), "GPS"];
_radioSlot setVariable [QGVAR(slotType), "RADIO"];
_compassSlot setVariable [QGVAR(slotType), "COMPASS"];
_watchSlot setVariable [QGVAR(slotType), "WATCH"];

{
    _x ctrlAddEventHandler ["MouseButtonDblClick", {
        params ["_control", "_button"];
        if (_button != 0) exitWith {}; // LMB only
        private _unit = call CBA_fnc_currentUnit;

        private _classname = "";
        private _slotType = _control getVariable QGVAR(slotType);
        switch _slotType do {
            // containers
            case "UNIFORM": {
                _classname = uniform _unit;
            };
            case "VEST": {
                _classname = vest _unit;
            };
            case "BACKPACK": {
                _classname = backpack _unit;
            };

            // gear
            case "HEADGEAR": {
                _classname = headgear _unit;
            };
            case "GOGGLES": {
                _classname = goggles _unit;
            };
            case "HMD": {
                _classname = hmd _unit;
            };
            case "BINOCULAR": {
                _classname = binocular _unit;
            };

            // rifle
            case "RIFLE": {
                _classname = primaryWeapon _unit;
            };
            case "RIFLE_SILENCER": {
                _classname = primaryWeaponItems _unit select 0;
            };
            case "RIFLE_BIPOD": {
                _classname = primaryWeaponItems _unit select 3;
            };
            case "RIFLE_OPTIC": {
                _classname = primaryWeaponItems _unit select 2;
            };
            case "RIFLE_POINTER": {
                _classname = primaryWeaponItems _unit select 1;
            };
            case "RIFLE_MAGAZINE": {
                _classname = getUnitLoadout _unit param [0, ["","","","",[],[],""]] select 4 param [0, ""];
            };
            case "RIFLE_MAGAZINE_GL": {
                _classname = getUnitLoadout _unit param [0, ["","","","",[],[],""]] select 5 param [0, ""];
            };

            // launcher
            case "LAUNCHER": {
                _classname = secondaryWeapon _unit;
            };
            case "LAUNCHER_SILENCER": {
                _classname = secondaryWeaponItems _unit select 0;
            };
            case "LAUNCHER_BIPOD": {
                _classname = secondaryWeaponItems _unit select 3;
            };
            case "LAUNCHER_OPTIC": {
                _classname = secondaryWeaponItems _unit select 2;
            };
            case "LAUNCHER_POINTER": {
                _classname = secondaryWeaponItems _unit select 1;
            };
            case "LAUNCHER_MAGAZINE": {
                _classname = secondaryWeaponMagazine _unit select 0;
            };

            // pistol
            case "PISTOL": {
                _classname = handgunWeapon _unit;
            };
            case "PISTOL_SILENCER": {
                _classname = handgunItems _unit select 0;
            };
            case "PISTOL_BIPOD": {
                _classname = handgunItems _unit select 3;
            };
            case "PISTOL_OPTIC": {
                _classname = handgunItems _unit select 2;
            };
            case "PISTOL_POINTER": {
                _classname = handgunItems _unit select 1;
            };
            case "PISTOL_MAGAZINE": {
                _classname = handgunMagazine _unit select 0;
            };

            // items
            case "MAP": {
                _classname = getUnitLoadout _unit param [9, ["","","","","",""]] select 0;
            };
            case "GPS": {
                _classname = getUnitLoadout _unit param [9, ["","","","","",""]] select 1;
            };
            case "RADIO": {
                _classname = getUnitLoadout _unit param [9, ["","","","","",""]] select 2;
            };
            case "COMPASS": {
                _classname = getUnitLoadout _unit param [9, ["","","","","",""]] select 3;
            };
            case "WATCH": {
                _classname = getUnitLoadout _unit param [9, ["","","","","",""]] select 4;
            };
        };

        [ctrlParent _control, _unit, _classname, _slotType] call FUNC(openItemContextMenu);
    }];
} forEach [
    _uniformSlot, _vestSlot, _backpackSlot,
    _uniformSlotBackground, _vestSlotBackground, _backpackSlotBackground,
    _headgearSlot, _glassesSlot, _hmdSlot, _binocularSlot,
    _rifleSlot, _rifleSilencerSlot, _rifleBipodSlot, _rifleOpticSlot, _riflePointerSlot, _rifleMagazine2Slot, _rifleMagazineSlot,
    _launcherSlot, _launcherSilencerSlot, _launcherBipodSlot, _launcherOpticSlot, _launcherPointerSlot, _launcherMagazineSlot,
    _pistolSlot, _pistolSilencerSlot, _pistolBipodSlot, _pistolOpticSlot, _pistolPointerSlot, _pistolMagazineSlot,
    _mapSlot, _gpsSlot, _radioSlot, _compassSlot, _watchSlot
];

// Containers
private _groundItems = _display displayCtrl IDC_FG_GROUND_ITEMS;
private _containerItems = _display displayCtrl IDC_FG_CHOSEN_CONTAINER;
private _uniformItems = _display displayCtrl IDC_FG_UNIFORM_CONTAINER;
private _vestItems = _display displayCtrl IDC_FG_VEST_CONTAINER;
private _backpackItems = _display displayCtrl IDC_FG_BACKPACK_CONTAINER;

_groundItems setVariable [QGVAR(containerType), "GROUND"];
_containerItems setVariable [QGVAR(containerType), "CARGO"];
_uniformItems setVariable [QGVAR(containerType), "UNIFORM_CONTAINER"];
_vestItems setVariable [QGVAR(containerType), "VEST_CONTAINER"];
_backpackItems setVariable [QGVAR(containerType), "BACKPACK_CONTAINER"];

private _controls = [];
_display setVariable [QGVAR(controls), _controls];

{
    _controls pushBack _x;

    // Item Context Menu Framework
    _x ctrlAddEventHandler ["lbDblClick", {
        params ["_control", "_index"];
        ([_control, _index] call FUNC(getInventoryClassname)) params ["_classname", "_container", "_containerType"];
        [ctrlParent _control, _container, _classname, _containerType] call FUNC(openItemContextMenu);
    }];
} forEach [
    _groundItems, _containerItems,
    _uniformItems, _vestItems, _backpackItems
];

private _fnc_update = {
    params ["_display"];
    systemChat str _this;

   {
        _x params ["_control"];
        if !(ctrlShown _control) exitWith {};

        // Item Rename Framework
        for [{_i = 0}, {_i < (lbSize _control)}, {_i = _i + 1}] do
        {
            private _classname = ([_control, _i] call FUNC(getInventoryClassname)) select 0;
            private _name = GVAR(renamedItems) getVariable [_classname, ""];
            if !(_name isEqualTo "") then {
                _control lbSetText [_i, _name];
            };
        };
    } forEach (_display getVariable QGVAR(controls));
};
_display displayAddEventHandler ["MouseMoving", _fnc_update];
_display displayAddEventHandler ["MouseHolding", _fnc_update];

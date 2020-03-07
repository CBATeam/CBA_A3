#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_addItemContextMenuOption (@todo currently: cba_ui_fnc_addItemContextMenuOption)

Description:
    Adds context menu option to inventory display.

Parameters:
    _item           - Item classname <STRING>
                      Can be base class.

    _slots          - Relevant slots <ARRAY, STRING>
                      Values:
                        ALL
                            GROUND
                            CARGO
                            CONTAINER
                                UNIFORM_CONTAINER
                                VEST_CONTAINER
                                BACKPACK_CONTAINER

                            CLOTHES
                                UNIFORM
                                VEST
                                BACKPACK
                                HEADGEAR
                                GOGGLES

                            WEAPON
                                RIFLE
                                LAUNCHER
                                PISTOL
                                BINOCULAR

                            SILENCER
                                RIFLE_SILENCER
                                LAUNCHER_SILENCER
                                PISTOL_SILENCER

                            BIPOD
                                RIFLE_BIPOD
                                LAUNCHER_BIPOD
                                PISTOL_BIPOD

                            OPTIC
                                RIFLE_OPTIC
                                LAUNCHER_OPTIC
                                PISTOL_OPTIC

                            POINTER
                                RIFLE_POINTER
                                LAUNCHER_POINTER
                                PISTOL_POINTER

                            MAGAZINE
                                RIFLE_MAGAZINE
                                RIFLE_MAGAZINE_GL
                                LAUNCHER_MAGAZINE
                                PISTOL_MAGAZINE

                            ASSIGNED_ITEM
                                MAP
                                GPS
                                RADIO
                                COMPASS
                                WATCH
                                HMD

    _displayName    - Option display name, or display name and tooltip <STRING, ARRAY>
                      String keys are automatically translated.

    _condition      - Option condition (default: {true}) <CODE>
                      Menu option is shown and executed only if this condition reports 'true'

    _statement      - Option statement (default: {}) <CODE>
                      Return true to keep context menu opened.

    _params         - Arguments passed as '_this select X' to condition and
                      statement (optional, default: []) <ANY>

Returns:
    Nothing/Undefined.

Examples:
    (begin example)
        call CBA_fnc_addItemContextMenuOption;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

// Force unscheduled environment to prevent race conditions.
if (canSuspend) exitWith {
    [CBA_fnc_addItemContextMenuOption, _this] call CBA_fnc_directCall;
};

if (!hasInterface) exitWith {};

// Initialize system on first execution.
if (isNil QGVAR(ContextMenuOptions)) then {
    GVAR(ContextMenuOptions) = false call CBA_fnc_createNamespace;

    ["CAManBase", "InventoryOpened", {
        params ["_unit", "_container1", "_container2"];
        if (_unit != call CBA_fnc_currentUnit) exitWith {};

        if (isNull _container2) then {
            GVAR(CurrentGroundItemHolder) = _container1;
        } else {
            GVAR(CurrentContainer) = _container1;
            GVAR(CurrentGroundItemHolder) = _container2;
        };
    }] call CBA_fnc_addClassEventHandler;
};

params [
    ["_item", "All", [""]],
    ["_slots", [], [[], ""]],
    ["_displayName", "<default>", ["", []]],
    ["_condition", {true}, [{}]],
    ["_statement", {}, [{}]],
    ["_params", []]
];

if (_item isEqualTo "") exitWith {};

if (_slots isEqualType "") then {
    _slots = [_slots];
};
_slots = _slots apply {toUpper _x}; // This also copies the array.

if ("CONTAINER" in _slots) then {
    _slots append ["UNIFORM_CONTAINER", "VEST_CONTAINER", "BACKPACK_CONTAINER"];
};

if ("CLOTHES" in _slots) then {
    _slots append ["UNIFORM", "VEST", "BACKPACK", "HEADGEAR", "GOGGLES"];
};

if ("WEAPON" in _slots) then {
    _slots append ["RIFLE", "LAUNCHER", "PISTOL", "BINOCULAR"];
};

if ("SILENCER" in _slots) then {
    _slots append ["RIFLE_SILENCER", "LAUNCHER_SILENCER", "PISTOL_SILENCER"];
};

if ("BIPOD" in _slots) then {
    _slots append ["RIFLE_BIPOD", "LAUNCHER_BIPOD", "PISTOL_BIPOD"];
};

if ("OPTIC" in _slots) then {
    _slots append ["RIFLE_OPTIC", "LAUNCHER_OPTIC", "PISTOL_OPTIC"];
};

if ("POINTER" in _slots) then {
    _slots append ["RIFLE_POINTER", "LAUNCHER_POINTER", "PISTOL_POINTER"];
};

if ("MAGAZINE" in _slots) then {
    _slots append ["RIFLE_MAGAZINE", "RIFLE_MAGAZINE_GL", "LAUNCHER_MAGAZINE", "PISTOL_MAGAZINE"];
};

if ("ASSIGNED_ITEM" in _slots) then {
    _slots append ["MAP", "GPS", "RADIO", "COMPASS", "WATCH", "HMD"];
};

_displayName params ["_displayName", ["_tooltip", ""]];

GVAR(ContextMenuOptions) setVariable [_item, [_slots, _displayName, _tooltip, _condition, _statement, _params]];

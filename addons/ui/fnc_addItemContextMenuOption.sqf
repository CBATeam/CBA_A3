#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_addItemContextMenuOption

Description:
    Adds context menu option to inventory display.

Parameters:
    _item                   - Item classname <STRING>
                              Can be base class.

                              Can be item type as reported by BIS_fnc_itemType:
                                ["Equipment","Headgear"]
                                ->
                                "#Equipment" and/or "##Headgear"

                              Wildcard:
                                #All

    _slots                  - Relevant slots <ARRAY, STRING>
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

    _displayName            String keys are automatically translated. <STRING, ARRAY>
        0: _displayName     - Option display name <STRING>
        1: _tooltip         - Option tooltip <STRING>

    _color                  - Option text color. Default alpha is 1.
                              (default: [] = default color) <ARRAY>

    _icon                   - Path to icon. (default: "" = no icon) <STRING>

    _condition              <CODE, ARRAY>
        0: _conditionEnable - Menu option is enabled and executed only if this
                              condition reports 'true' (default: {true}) <CODE>
        1: _conditionShow   - Menu option is shown only if this condition
                              reports 'true'. (optional, default: {true}) <CODE>

                            - Passed arguments:
                              params ["_unit", "_container", "_item", "_slot", "_params", "_id"];

    _statement              - Option statement (default: {}) <CODE>
                              Return true to keep context menu opened.

                            - Passed arguments:
                              params ["_unit", "_container", "_item", "_slot", "_params", "_id"];

    _consume                - Remove the item before executing the statement
                              code. (default: false) <BOOLEAN>

                            - This does NOT work for the following slots:
                                GROUND
                                CARGO

    _params                 - Arguments passed as '_this select 4' to condition and
                              statement (optional, default: []) <ANY>
    
    _id                     - ID of the option. Can be used to remove an option.
                              If none provided, generic ID will be generated.
                              An already existing ID will overwrite the previous settings.
                              (optional, default: "") <STRING>

Returns:
    ID <STRING>.

Examples:
    (begin example)
        ["#All", "ALL", ">DEBUG ACTION<", nil, nil, {true}, {
            params ["_unit", "_container", "_item", "_slot", "_params"];
            systemChat str [name _unit, typeOf _container, _item, _slot, _params];
            true
        }, false, [0,1,2]] call CBA_fnc_addItemContextMenuOption;
    (end)

Author:
    commy2, Zorn
---------------------------------------------------------------------------- */

// Force unscheduled environment to prevent race conditions.
if (canSuspend) exitWith {
    [CBA_fnc_addItemContextMenuOption, _this] call CBA_fnc_directCall;
};

if (!hasInterface) exitWith {};

// Initialize system on first execution.
if (isNil QGVAR(ItemContextMenuOptions)) then {
    GVAR(ItemContextMenuOptions) = createHashMap;

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
    ["_displayName", [], ["", []]],
    ["_color", [], [[]], [0,3,4]],
    ["_icon", "", [""]],
    ["_condition", [], [{}, []]],
    ["_statement", {}, [{}]],
    ["_consume", false, [false]],
    ["_params", []],
    ["_id", "", [""]]
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

_displayName params [
    ["_displayName", "<default>", [""]],
    ["_tooltip", "", [""]]
];

if (_color isNotEqualTo []) then {
    _color params [["_r", 1, [0]], ["_g", 1, [0]], ["_b", 1, [0]], ["_a", 1, [0]]];
    _color = [_r, _g, _b, _a];
};

if (_icon isEqualTo "") then {
    _icon = "#(argb,8,8,3)color(0,0,0,0)";
};

_condition params [
    ["_conditionEnable", {true}, [{}]],
    ["_conditionShow", {true}, [{}]]
];

private _options = GVAR(ItemContextMenuOptions) get _item;

if (isNil "_options") then {
    _options = createHashMap;
    GVAR(ItemContextMenuOptions) set [_item, _options];
};

if (_id isEqualTo "") then {
    private _keys = keys _options;
    private _index = count _keys;

    while { str _index in _keys } do { _index = _index + 1; };
    _id = _item + "_" + str _index;
};

_options set [
    _id,
    [_slots, _displayName, _tooltip, _color, _icon, _conditionEnable, _conditionShow, _statement, _consume, _params]
];

_id

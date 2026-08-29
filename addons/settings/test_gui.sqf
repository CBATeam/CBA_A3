// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL
#include "script_component.hpp"

SCRIPT(test_settings_gui);

// ----------------------------------------------------------------------------

LOG('Testing Settings GUI');

// Showing a controls group shows every control inside it, nested ones included,
// so anything a row hid by itself comes back with it. These tests walk the menu
// the way a user does and check that the overwrite checkboxes of every visible
// row still match the source it is pointed at.

private _parentDisplay = findDisplay 46;

if (isNull _parentDisplay) exitWith {
    WARNING("Settings GUI test needs to run in a mission, skipped.");
};

// ----- settings to test against. Every CBA setting lives in one category, and
// ----- the menu needs more than one of them to have something to switch to.
private _previousAddon = uiNamespace getVariable [QGVAR(addon), ""];
private _previousSource = uiNamespace getVariable [QGVAR(source), ""];

private _testCategoryA = "CBA Settings Test A";
private _testCategoryB = "CBA Settings Test B";
private _testSettings = [];

{
    _x params ["_name", "_category", "_subCategory", "_isGlobal"];

    // an empty sub-category is the same as not passing one at all
    private _setting = format ["%1_%2", QGVAR(test_gui), _name];

    [
        _setting,
        "CHECKBOX",
        ["-test setting-", "-test setting-"],
        [_category, _subCategory],
        false,
        _isGlobal
    ] call CBA_fnc_addSetting;

    _testSettings pushBack _setting;
} forEach [
    ["a1", _testCategoryA, "", SETTING_LOCAL_OVERRIDABLE],
    ["a2", _testCategoryA, "Folded", SETTING_LOCAL_OVERRIDABLE],
    ["a3", _testCategoryA, "Folded", SETTING_GLOBAL_ONLY], // always overwrites the clients
    ["a4", _testCategoryA, "Folded", SETTING_LOCAL_ONLY], // can't be overwritten
    ["b1", _testCategoryB, "", SETTING_LOCAL_OVERRIDABLE],
    ["b2", _testCategoryB, "", SETTING_LOCAL_OVERRIDABLE]
];

// ----- every visible row's checkboxes have to match the source it is showing
private _fnc_check = {
    params ["_tag"];

    private _display = uiNamespace getVariable [QGVAR(display), displayNull];
    private _category = uiNamespace getVariable [QGVAR(addon), ""];
    private _source = uiNamespace getVariable [QGVAR(source), ""];
    private _optionsGroups = _display getVariable [QGVAR(optionsGroups), createHashMap];
    private _ctrlOptionsGroup = _optionsGroups getOrDefault [_category, controlNull];
    private _bad = [];

    {
        // a folded or filtered out row is hidden itself, what its checkboxes say
        // then is invisible either way
        if (ctrlShown _x) then {
            private _setting = ROW_SETTING(_x);
            private _isGlobal = _x getVariable [QGVAR(isGlobal), SETTING_LOCAL_OVERRIDABLE];
            private _enabled = ROW_ENABLED(_x);

            private _showClient = _source isNotEqualTo "client" && _isGlobal isNotEqualTo SETTING_LOCAL_ONLY;
            private _showMission = _source isEqualTo "server" && _isGlobal isNotEqualTo SETTING_LOCAL_ONLY;

            private _ctrlOverwriteClient = _x controlsGroupCtrl IDC_SETTING_OVERWRITE_CLIENT;
            private _ctrlOverwriteMission = _x controlsGroupCtrl IDC_SETTING_OVERWRITE_MISSION;

            if ((ctrlShown _ctrlOverwriteClient) isNotEqualTo _showClient) then {
                _bad pushBack [_setting, "client shown", ctrlShown _ctrlOverwriteClient];
            };

            if ((ctrlShown _ctrlOverwriteMission) isNotEqualTo _showMission) then {
                _bad pushBack [_setting, "mission shown", ctrlShown _ctrlOverwriteMission];
            };

            // a checkbox that isn't there must not be reachable either
            if (!_showClient && ctrlEnabled _ctrlOverwriteClient) then {
                _bad pushBack [_setting, "client on while hidden"];
            };

            if (!_showMission && ctrlEnabled _ctrlOverwriteMission) then {
                _bad pushBack [_setting, "mission on while hidden"];
            };

            // and neither of them may switch a locked row back on
            if (!_enabled && {ctrlEnabled _ctrlOverwriteClient || ctrlEnabled _ctrlOverwriteMission}) then {
                _bad pushBack [_setting, "checkbox on, locked row"];
            };

            // the mission can't overwrite a local only setting, so it can't set one
            if (_source isEqualTo "mission" && _isGlobal isEqualTo SETTING_LOCAL_ONLY && _enabled) then {
                _bad pushBack [_setting, "local only row editable from mission"];
            };
        };
    } forEach (_ctrlOptionsGroup getVariable [QGVAR(rows), []]);

    // only the selected category may be drawn
    private _shownCategories = 0;

    {
        if (ctrlShown _y) then {_shownCategories = _shownCategories + 1};
    } forEach _optionsGroups;

    if (_shownCategories > 1) then {
        _bad pushBack ["-", "categories drawn at once", _shownCategories];
    };

    // the message can't be built inside the macro, its commas would split the arguments
    private _message = format ["settings menu (%1): %2", _tag, _bad];

    TEST_TRUE(_bad isEqualTo [],_message);
};

// ----- open the menu on the first category
[_parentDisplay] call FUNC(openSettingsMenu);

private _display = uiNamespace getVariable [QGVAR(display), displayNull];
private _ctrlAddonList = _display displayCtrl IDC_ADDONS_LIST;

["opened"] call _fnc_check;

// ----- every source shows its own set of checkboxes
{
    _x params ["_idc", "_name"];

    (_display displayCtrl _idc) call FUNC(gui_sourceChanged);

    [format ["source %1", _name]] call _fnc_check;
} forEach [[IDC_BTN_SERVER, "server"], [IDC_BTN_MISSION, "mission"], [IDC_BTN_CLIENT, "client"]];

// ----- a category is built for the source that was shown when it was created,
// ----- and every category after the first is created while another one is shown
(_display displayCtrl IDC_BTN_MISSION) call FUNC(gui_sourceChanged);

private _testIndices = [];

for "_index" from 0 to (lbSize _ctrlAddonList) - 1 do {
    [_ctrlAddonList, _index] call FUNC(gui_addonChanged);

    [format ["category %1", _index]] call _fnc_check;

    if ((uiNamespace getVariable [QGVAR(addon), ""]) in [toLower _testCategoryA, toLower _testCategoryB]) then {
        _testIndices pushBack _index;
    };
};

// ----- searching hides rows and clearing the search brings them back
private _ctrlSearch = _display displayCtrl IDC_SEARCH_EDIT;

_ctrlSearch ctrlSetText "test setting";
_display call FUNC(gui_search);

["searched"] call _fnc_check;

_ctrlSearch ctrlSetText "";
_display call FUNC(gui_search);

["search cleared"] call _fnc_check;

// ----- folding a sub-category away hides its rows, unfolding brings them back
[_ctrlAddonList, _testIndices param [0, 0]] call FUNC(gui_addonChanged);

private _category = uiNamespace getVariable [QGVAR(addon), ""];
private _ctrlOptionsGroup = (_display getVariable [QGVAR(optionsGroups), createHashMap]) getOrDefault [_category, controlNull];
private _rowOrder = _ctrlOptionsGroup getVariable [QGVAR(rowOrder), []];
private _headerIndex = _rowOrder findIf {!isNil {_x getVariable QGVAR(members)}};

if (_headerIndex == -1) then {
    WARNING("No sub-category to fold, part of the settings GUI test was skipped.");
} else {
    private _ctrlHeaderGroup = _rowOrder select _headerIndex;

    [_ctrlHeaderGroup] call FUNC(gui_toggleSubCategory);
    ["folded"] call _fnc_check;

    [_ctrlHeaderGroup] call FUNC(gui_toggleSubCategory);
    ["unfolded"] call _fnc_check;
};

// ----- switching to the base game menu and back shows the addons group again,
// ----- and with it everything that was ever built inside it
private _ctrlToggleButton = _display displayCtrl IDC_BTN_CONFIGURE_ADDONS;

// FUNC(openSettingsMenu) hides the button, this doesn't go through it
_ctrlToggleButton ctrlEnable true;
_ctrlToggleButton ctrlShow true;

_ctrlToggleButton call FUNC(gui_configure);
_ctrlToggleButton call FUNC(gui_configure);

["configure round trip"] call _fnc_check;

// ----- close without keeping any of it
_display closeDisplay IDC_CANCEL;

// ----- and take the test settings back out
{
    GVAR(default) setVariable [_x, nil];
    GVAR(client) setVariable [_x, nil];
    GVAR(mission) setVariable [_x, nil];
    missionNamespace setVariable [_x, nil];

    if (isServer && {!isNull GVAR(server)}) then {
        GVAR(server) setVariable [_x, nil, true];
    };

    GVAR(allSettings) deleteAt (GVAR(allSettings) find _x);
} forEach _testSettings;

// the menu indices still list them, they are rebuilt when it is next opened
GVAR(searchIndex) = nil;
GVAR(categorySettings) = nil;
GVAR(subCategories) = nil;

uiNamespace setVariable [QGVAR(addon), _previousAddon];
uiNamespace setVariable [QGVAR(source), _previousSource];

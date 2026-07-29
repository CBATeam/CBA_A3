#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_gui_createCategory

Description:
    Creates the controls of one category of the Addon Options menu. Categories are
    created the first time they are selected and kept for as long as the menu is
    open.

    The settings and the position of their sub-category headers are read from the
    indices FUNC(gui_index) builds, so this doesn't have to look at any setting
    outside the category.

Parameters:
    _display  - Addon Options dialog <DISPLAY>
    _category - Lower case category to create <STRING>

Returns:
    None

Examples:
    (begin example)
        [_display, "cba_ui"] call CBA_settings_fnc_gui_createCategory;
    (end)

Author:
    commy2, kymckay, LinkIsGrim
---------------------------------------------------------------------------- */

params ["_display", "_category"];

call FUNC(gui_index);

private _optionsGroups = _display getVariable QGVAR(optionsGroups);
if (_category in _optionsGroups) exitWith {};

private _categorySettings = GVAR(categorySettings) getOrDefault [_category, ["", []]];
_categorySettings params ["", "_settings"];

// [sub-category, index of its first setting], in order
private _subCategoryRuns = + (GVAR(subCategories) getOrDefault [_category, []]);
private _runIndex = 0;

// Settings registered without a sub-category come first and had no header, so
// they were the one block that couldn't be folded away. Give them one, but only
// where there is something else to fold them against.
if (_subCategoryRuns isNotEqualTo [] && {(_subCategoryRuns select 0 select 1) > 0}) then {
    _subCategoryRuns insert [0, [[localize LSTRING(general), 0]]];
};

// nothing here is positioned, FUNC(gui_reflow) lays the table out once afterwards
private _ctrlOptionsGroup = _display ctrlCreate [QGVAR(OptionsGroup), -1, _display displayCtrl IDC_ADDONS_GROUP];
_ctrlOptionsGroup ctrlEnable false;
_ctrlOptionsGroup ctrlShow false;

_optionsGroups set [_category, _ctrlOptionsGroup];

// order of headers and settings in the table, used to re-flow it when searching
private _rowOrder = [];
private _rows = [];

_ctrlOptionsGroup setVariable [QGVAR(rowOrder), _rowOrder];

// the settings alone, without the headers between them
_ctrlOptionsGroup setVariable [QGVAR(rows), _rows];

private _ctrlHeaderGroup = controlNull;

// the rows are built for the source that is shown and pointed at another one by
// FUNC(gui_refresh) when it changes
private _source = uiNamespace getVariable [QGVAR(source), "client"];

{
    private _setting = _x;

    // ----- a header goes in front of the first setting of every sub-category
    private _subCategory = "";

    if (_runIndex < count _subCategoryRuns) then {
        (_subCategoryRuns select _runIndex) params ["_runSubCategory", "_runFirstIndex"];

        if (_forEachIndex isEqualTo _runFirstIndex) then {
            _subCategory = _runSubCategory;
            _runIndex = _runIndex + 1;
        };
    };

    (GVAR(default) getVariable _setting) params ["_defaultValue", "", "_settingType", "_settingData", "", "_displayName", "_tooltip", "_isGlobal"];

    if (_tooltip != _setting) then { // Append setting name to bottom line
        if (_tooltip isEqualTo "") then {
            _tooltip = _setting;
        } else {
            _tooltip = format ["%1\n%2", _tooltip, _setting];
        };
    };

    // Add sub-category header
    if (_subCategory isNotEqualTo "") then {
        _ctrlHeaderGroup = _display ctrlCreate [QGVAR(subCat), -1, _ctrlOptionsGroup];

        // FUNC(gui_reflow) writes the name, it carries the folded marker
        _ctrlHeaderGroup setVariable [QGVAR(subCategory), _subCategory];

        // the settings below this header, used to hide it when they are all
        // filtered out and to fold them away
        _ctrlHeaderGroup setVariable [QGVAR(members), []];

        // folding a sub-category away holds for as long as the menu is open. Keyed
        // by category too, two addons can both have a "Blood" group.
        _ctrlHeaderGroup setVariable [QGVAR(foldKey), [_category, _subCategory] joinString "$"];
        _ctrlHeaderGroup setVariable [
            QGVAR(collapsed),
            (uiNamespace getVariable [QGVAR(collapsedSubCategories), createHashMap]) getOrDefault [[_category, _subCategory] joinString "$", false]
        ];

        _rowOrder pushBack _ctrlHeaderGroup;
    };

    // ----- create setting group
    private _ctrlSettingGroup = switch (toUpper _settingType) do {
        case "CHECKBOX": {
            _display ctrlCreate [QGVAR(Row_Checkbox), IDC_SETTING_CONTROLS_GROUP, _ctrlOptionsGroup]
        };
        case "EDITBOX": {
            _display ctrlCreate [QGVAR(Row_Editbox), IDC_SETTING_CONTROLS_GROUP, _ctrlOptionsGroup]
        };
        case "LIST": {
            _display ctrlCreate [QGVAR(Row_List), IDC_SETTING_CONTROLS_GROUP, _ctrlOptionsGroup]
        };
        case "SLIDER": {
            _display ctrlCreate [QGVAR(Row_Slider), IDC_SETTING_CONTROLS_GROUP, _ctrlOptionsGroup]
        };
        case "COLOR": {
            _display ctrlCreate [[QGVAR(Row_Color), QGVAR(Row_ColorAlpha)] select (count _defaultValue > 3), IDC_SETTING_CONTROLS_GROUP, _ctrlOptionsGroup]
        };
        case "TIME": {
            _display ctrlCreate [QGVAR(Row_Time), IDC_SETTING_CONTROLS_GROUP, _ctrlOptionsGroup]
        };
        default {controlNull};
    };

    // ----- where the overwrite checkboxes belong. Has to be read before anything
    // ----- can move them, hiding one puts it off screen and it can't be read back.
    {
        private _ctrlOverwrite = _ctrlSettingGroup controlsGroupCtrl _x;
        _ctrlOverwrite setVariable [QGVAR(position), ctrlPosition _ctrlOverwrite];
    } forEach [IDC_SETTING_OVERWRITE_CLIENT, IDC_SETTING_OVERWRITE_MISSION];

    // ----- determine display string for default value
    private _defaultValueTooltip = switch (toUpper _settingType) do {
        case "LIST": {
            _settingData params ["_values", "_labels"];

            _labels param [_values find _defaultValue, ""]
        };
        case "SLIDER": {
            if (_settingData param [3, false]) then {
                format [localize "STR_3DEN_percentageUnit", round (_defaultValue * 100), "%"]
            } else {
                _defaultValue
            };
        };
        case "COLOR": {
            private _template = (["R: %1", "G: %2", "B: %3", "A: %4"] select [0, count _defaultValue]) joinString "\n";
            format ([_template] + _defaultValue)
        };
        case "TIME": {
            _defaultValue call CBA_fnc_formatElapsedTime
        };
        default {_defaultValue};
    };

    // ----- set tooltip on "Reset to default" button
    private _ctrlDefault = _ctrlSettingGroup controlsGroupCtrl IDC_SETTING_DEFAULT;
    _ctrlDefault ctrlSetTooltip (format ["%1\n%2", localize LSTRING(default_tooltip), _defaultValueTooltip]);

    _ctrlSettingGroup setVariable [QGVAR(settingData), _settingData];
    _ctrlSettingGroup setVariable [QGVAR(isGlobal), _isGlobal];

    _rowOrder pushBack _ctrlSettingGroup;
    _rows pushBack _ctrlSettingGroup;

    if (!isNull _ctrlHeaderGroup) then {
        (_ctrlHeaderGroup getVariable QGVAR(members)) pushBack _ctrlSettingGroup;

        // so a row knows whether the group it belongs to is folded away
        _ctrlSettingGroup setVariable [QGVAR(header), _ctrlHeaderGroup];
    };

    // ----- how far an open dropdown reaches below its row, so the table can
    // ----- keep the scroll area tall enough for it
    if (toUpper _settingType == "LIST") then {
        _ctrlSettingGroup setVariable [QGVAR(dropdownHeight), POS_H(count (_settingData select 0)) + TABLE_LINE_SPACING];
    };

    // ----- set setting name
    private _ctrlSettingName = _ctrlSettingGroup controlsGroupCtrl IDC_SETTING_NAME;
    _ctrlSettingName ctrlSetText format ["%1:", _displayName];
    _ctrlSettingName ctrlSetTooltip _tooltip;

    // ----- point the row at the source being shown. Has to happen before the
    // ----- scripts below run, they only switch their controls back on if the
    // ----- setting can be edited from it.
    [_ctrlSettingGroup, _setting, _source] call FUNC(gui_retargetRow);

    private _currentValue = GET_TEMP_NAMESPACE_VALUE_OR_CURRENT(_setting,_source);
    private _currentPriority = GET_TEMP_NAMESPACE_PRIORITY_OR_CURRENT(_setting,_source);

    // ----- execute setting script
    private _script = getText (configFile >> ctrlClassName _ctrlSettingGroup >> QGVAR(script));
    [_ctrlSettingGroup, _setting, _source, _currentValue, _settingData] call (uiNamespace getVariable _script);

    // ----- default button
    [_ctrlSettingGroup, _setting, _source, _currentValue, _defaultValue] call FUNC(gui_settingDefault);

    // ----- priority list
    [_ctrlSettingGroup, _setting, _source, _currentPriority, _isGlobal] call FUNC(gui_settingOverwrite);
} forEach _settings;

// ----- created after every row so it is drawn below them
_ctrlOptionsGroup setVariable [QGVAR(pad), _display ctrlCreate [QGVAR(ScrollPad), -1, _ctrlOptionsGroup]];

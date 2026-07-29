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

private _lists = _display getVariable QGVAR(lists);

// nothing here is positioned, FUNC(gui_reflow) lays the table out once afterwards
private _createdGroups = [];

private _categorySettings = GVAR(categorySettings) getOrDefault [_category, ["", []]];
_categorySettings params ["", "_settings"];

// [sub-category, index of its first setting], in order
private _subCategoryRuns = GVAR(subCategories) getOrDefault [_category, []];
private _runIndex = 0;

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

    private _settingControlsGroups = [];

    {
        private _source = toLower _x;

        private _currentValue = GET_TEMP_NAMESPACE_VALUE(_setting,_source);
        private _wasEdited = false;

        if (isNil "_currentValue") then {
            _currentValue = [_setting, _source] call FUNC(get);
        } else {
            _wasEdited = true;
        };

        private _currentPriority = GET_TEMP_NAMESPACE_PRIORITY(_setting,_source);
        if (isNil "_currentPriority") then {
            _currentPriority = [_setting, _source] call FUNC(priority);
        } else {
            _wasEdited = true;
        };

        // ----- create or retrieve options "list" controls group
        private _list = [QGVAR(list), _category, _source] joinString "$";

        private _ctrlOptionsGroup = controlNull;

        if !(_list in _lists) then {
            _ctrlOptionsGroup = _display ctrlCreate [QGVAR(OptionsGroup), -1, _display displayCtrl IDC_ADDONS_GROUP];
            _ctrlOptionsGroup ctrlEnable false;
            _ctrlOptionsGroup ctrlShow false;

            _lists pushBack _list;
            _display setVariable [_list, _ctrlOptionsGroup];
            _createdGroups pushBack _ctrlOptionsGroup;

            // order of headers and settings in the table, used to re-flow it when searching
            _ctrlOptionsGroup setVariable [QGVAR(rowOrder), []];

            // the settings alone, without the headers between them
            _ctrlOptionsGroup setVariable [QGVAR(rows), []];
        } else {
            _ctrlOptionsGroup = _display getVariable _list;
        };

        private _rowOrder = _ctrlOptionsGroup getVariable QGVAR(rowOrder);

        // Add sub-category header
        if (_subCategory isNotEqualTo "") then {
            private _ctrlHeaderGroup = _display ctrlCreate [QGVAR(subCat), -1, _ctrlOptionsGroup];
            private _ctrlHeaderName = _ctrlHeaderGroup controlsGroupCtrl IDC_SETTING_NAME;
            _ctrlHeaderName ctrlSetText format ["%1:", _subCategory];

            // the settings below this header, used to hide it when they are all filtered out
            _ctrlHeaderGroup setVariable [QGVAR(members), []];
            _rowOrder pushBack _ctrlHeaderGroup;

            // settings without a sub-category are sorted first, so this is nil for them
            _ctrlOptionsGroup setVariable [QGVAR(currentHeader), _ctrlHeaderGroup];
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

        _ctrlSettingGroup setVariable [QGVAR(setting), _setting];
        _ctrlSettingGroup setVariable [QGVAR(source), _source];
        _ctrlSettingGroup setVariable [QGVAR(settingData), _settingData];
        _ctrlSettingGroup setVariable [QGVAR(groups), _settingControlsGroups];
        _settingControlsGroups pushBack _ctrlSettingGroup;

        _rowOrder pushBack _ctrlSettingGroup;
        (_ctrlOptionsGroup getVariable QGVAR(rows)) pushBack _ctrlSettingGroup;

        private _ctrlHeaderGroup = _ctrlOptionsGroup getVariable [QGVAR(currentHeader), controlNull];
        if (!isNull _ctrlHeaderGroup) then {
            (_ctrlHeaderGroup getVariable QGVAR(members)) pushBack _ctrlSettingGroup;
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

        // change color if setting was edited
        if (_wasEdited) then {
            _ctrlSettingName ctrlSetTextColor COLOR_TEXT_ENABLED_WAS_EDITED;
        };

        // ----- execute setting script
        private _script = getText (configFile >> ctrlClassName _ctrlSettingGroup >> QGVAR(script));
        [_ctrlSettingGroup, _setting, _source, _currentValue, _settingData] call (uiNamespace getVariable _script);

        // ----- default button
        [_ctrlSettingGroup, _setting, _source, _currentValue, _defaultValue] call FUNC(gui_settingDefault);

        // ----- priority list
        [_ctrlSettingGroup, _setting, _source, _currentPriority, _isGlobal] call FUNC(gui_settingOverwrite);

        // ----- check if setting can be altered
        private _enabled = switch (_source) do {
            case "client": {CAN_SET_CLIENT_SETTINGS && {isNil {GVAR(userconfig) getVariable _setting}}};
            case "mission": {CAN_SET_MISSION_SETTINGS && {isNil {GVAR(missionConfig) getVariable _setting}}};
            case "server": {CAN_SET_SERVER_SETTINGS && {isNil {GVAR(serverConfig) getVariable _setting}}};
            default {false};
        };

        if !(_enabled) then {
            _ctrlSettingName ctrlSetTextColor COLOR_TEXT_DISABLED;

            {
                (_ctrlSettingGroup controlsGroupCtrl _x) ctrlEnable false;
            } forEach (_ctrlSettingGroup call FUNC(gui_rowClassInfo) select 1);
        };
    } forEach ["client", "mission", "server"];
} forEach _settings;

// ----- created after every row so it is drawn below them
{
    _x setVariable [QGVAR(pad), _display ctrlCreate [QGVAR(ScrollPad), -1, _x]];
} forEach _createdGroups;

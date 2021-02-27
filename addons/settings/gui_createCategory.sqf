//pragma SKIP_COMPILE - inline function, don't include script_component.hpp

private _fnc_controlSetTablePosY = {
    params ["_control", "_tablePosY", "_height"];

    private _config = configFile >> ctrlClassName _control;

    private _posX = getNumber (_config >> "x");
    private _posY = getNumber (_config >> "y") + _tablePosY;
    private _width = getNumber (_config >> "w");

    if (isNil "_height") then {
        _height = getNumber (_config >> "h");
    };

    _control ctrlSetPosition [_posX, _posY, _width, _height];
    _control ctrlCommit 0;

    _posY + _height
};

private _lists = _display getVariable QGVAR(lists);

private _categorySettings = [];

{
    (GVAR(default) getVariable _x) params ["", "_setting", "", "", "_category", "", "", "", "", "_subCategory"];
    if (_category == _selectedAddon) then {
        if (isLocalized _subCategory) then {
            _subCategory = localize _subCategory;
        };
        _categorySettings pushBack [_subCategory, _forEachIndex, _setting];
    };
} forEach GVAR(allSettings);

_categorySettings sort true;
private _lastSubCategory = "$START";

{
    _x params ["_subCategory", "", "_setting"];
    private _createHeader = false;
    if (_subCategory != _lastSubCategory) then {
        _lastSubCategory = _subCategory;
        if (_subCategory == "") exitWith {};
        _createHeader = true;
    };

    (GVAR(default) getVariable _setting) params ["_defaultValue", "", "_settingType", "_settingData", "_category", "_displayName", "_tooltip", "_isGlobal"];

    if (isLocalized _displayName) then {
        _displayName = localize _displayName;
    };

    if (isLocalized _tooltip) then {
        _tooltip = localize _tooltip;
    };
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
        } else {
            _ctrlOptionsGroup = _display getVariable _list;
        };

        // Add sub-category header
        if (_createHeader) then {
            private _ctrlHeaderGroup = _display ctrlCreate [QGVAR(subCat), -1, _ctrlOptionsGroup];
            private _ctrlHeaderName = _ctrlHeaderGroup controlsGroupCtrl IDC_SETTING_NAME;
            _ctrlHeaderName ctrlSetText format ["%1:", _subCategory];

            private _tablePosY = (_ctrlOptionsGroup getVariable [QGVAR(tablePosY), TABLE_LINE_SPACING/2]);
            _tablePosY = [_ctrlHeaderGroup, _tablePosY] call _fnc_controlSetTablePosY;
            _ctrlOptionsGroup setVariable [QGVAR(tablePosY), _tablePosY];
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

                private _label = _labels param [_values find _defaultValue, ""];

                if (isLocalized _label) then {
                    _label = localize _label;
                };

                _label
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
        _ctrlSettingGroup setVariable [QGVAR(params), _settingData];
        _ctrlSettingGroup setVariable [QGVAR(groups), _settingControlsGroups];
        _settingControlsGroups pushBack _ctrlSettingGroup;

        // ----- adjust y position in table
        private _tablePosY = _ctrlOptionsGroup getVariable [QGVAR(tablePosY), TABLE_LINE_SPACING/2];
        _tablePosY = [_ctrlSettingGroup, _tablePosY] call _fnc_controlSetTablePosY;
        _ctrlOptionsGroup setVariable [QGVAR(tablePosY), _tablePosY];

        // ----- padding to make listboxes work
        if (_settingType == "LIST") then {
            private _ctrlEmpty = _display ctrlCreate [QGVAR(Row_Empty), -1, _ctrlOptionsGroup];
            private _height = POS_H(count (_settingData select 0)) + TABLE_LINE_SPACING;
            [_ctrlEmpty, _tablePosY, _height] call _fnc_controlSetTablePosY;
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
        };

        if !(_enabled) then {
            _ctrlSettingName ctrlSetTextColor COLOR_TEXT_DISABLED;

            //private _ctrlSettingGroupControls = allControls ctrlParent _ctrlSettingGroup select {ctrlParentControlsGroup _x == _ctrlSettingGroup};
            private _ctrlSettingGroupControls = "true" configClasses (configFile >> ctrlClassName _ctrlSettingGroup >> "controls") apply {_ctrlSettingGroup controlsGroupCtrl getNumber (_x >> "idc")};

            {
                _x ctrlEnable false;
            } forEach _ctrlSettingGroupControls;
        };
    } forEach ["client", "mission", "server"];
} forEach _categorySettings;

// inline function, don't include script_component.hpp

private _fnc_controlSetTablePosY = {
    params ["_control", "_tablePosY"];

    private _config = configFile >> ctrlClassName _control;

    private _posX = getNumber (_config >> "x");
    private _posY = getNumber (_config >> "y") + _tablePosY;
    private _posH = getNumber (_config >> "h");

    _control ctrlSetPosition [_posX, _posY];
    _control ctrlCommit 0;

    _posY + _posH
};

private _lists = [];
_display setVariable [QGVAR(lists), _lists];

{
    (GVAR(default) getVariable _x) params ["_defaultValue", "_setting", "_settingType", "_settingData", "_category", "_displayName", "_tooltip", "_isGlobal"];

    if (isLocalized _category) then {
        _category = localize _category;
    };

    if (isLocalized _displayName) then {
        _displayName = localize _displayName;
    };

    if (isLocalized _tooltip) then {
        _tooltip = localize _tooltip;
    };

    _categories pushBackUnique _category;

    private _settingControlsGroups = [];

    {
        private _source = toLower _x;
        private _currentValue = [_setting, _source] call FUNC(get);
        private _currentPriority = [_setting, _source] call FUNC(priority);

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
            default {controlNull};
        };

        _ctrlSettingGroup setVariable [QGVAR(setting), _setting];
        _ctrlSettingGroup setVariable [QGVAR(source), _source];
        _ctrlSettingGroup setVariable [QGVAR(params), _settingData];
        _ctrlSettingGroup setVariable [QGVAR(groups), _settingControlsGroups];
        _settingControlsGroups pushBack _ctrlSettingGroup;

        // ----- adjust y position in table
        private _tablePosY = _ctrlOptionsGroup getVariable [QGVAR(tablePosY), TABLE_LINE_SPACING/2];
        _tablePosY = [_ctrlSettingGroup, _tablePosY] call _fnc_controlSetTablePosY;
        _ctrlOptionsGroup setVariable [QGVAR(tablePosY), _tablePosY];

        // ----- set setting name
        private _ctrlSettingName = _ctrlSettingGroup controlsGroupCtrl IDC_SETTING_NAME;
        _ctrlSettingName ctrlSetText format ["%1:", _displayName];
        _ctrlSettingName ctrlSetTooltip _tooltip;

        // ----- execute setting script
        private _script = getText (configFile >> ctrlClassName _ctrlSettingGroup >> QGVAR(script));
        [_ctrlSettingGroup, _setting, _source, _currentValue, _settingData] call (uiNamespace getVariable _script);

        // ----- default button
        [_ctrlSettingGroup, _setting, _source, _currentValue, _defaultValue] call FUNC(gui_settingDefault);

        // ----- priority list
        [_ctrlSettingGroup, _setting, _source, _currentPriority] call FUNC(gui_settingOverwrite);

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
} forEach GVAR(allSettings);

#include "script_component.hpp"

params ["_display"];
uiNamespace setVariable [QGVAR(display), _display];

private _ctrlAddonsGroup = _display displayCtrl IDC_ADDONS_GROUP;
private _ctrlServerButton = _display displayCtrl IDC_BTN_SERVER;
private _ctrlMissionButton = _display displayCtrl IDC_BTN_MISSION;
private _ctrlClientButton = _display displayCtrl IDC_BTN_CLIENT;

// ----- hide and disable the custom controls by default
{
    _x ctrlEnable false;
    _x ctrlShow false;
} forEach [_ctrlAddonsGroup, _ctrlServerButton, _ctrlMissionButton, _ctrlClientButton];

// ----- disable in main menu
if (isNil QUOTE(ADDON)) exitWith {
    private _ctrlToggleButton = _display displayCtrl IDC_BTN_CONFIGURE_ADDONS;

    _ctrlToggleButton ctrlEnable false;
};

// ----- situational tooltips
if (!isMultiplayer) then {
    _ctrlServerButton ctrlSetTooltip localize LSTRING(ButtonClient_tooltip);
};

if (is3DEN) then {
    _ctrlMissionButton ctrlSetTooltip localize LSTRING(ButtonMission_tooltip_3den);
};

if (isServer) then {
    _ctrlClientButton ctrlSetTooltip "";
};

// ----- reload settings file if in editor
if (is3DEN && {FILE_EXISTS(MISSION_SETTINGS_FILE)}) then {
    GVAR(missionConfig) call CBA_fnc_deleteNamespace;
    GVAR(missionConfig) = [] call CBA_fnc_createNamespace;

    private _missionConfig = preprocessFile MISSION_SETTINGS_FILE;

    {
        _x params ["_setting", "_value", "_priority"];

        GVAR(missionConfig) setVariable [_setting, [_value, _priority]];
    } forEach ([_missionConfig, false] call FUNC(parse));

    {
        private _setting = _x;

        (GVAR(missionConfig) getVariable [_setting, []]) params ["_value", "_priority"];
        [_setting, _value, _priority, "mission"] call FUNC(set);
    } forEach GVAR(allSettings);
};

// ----- create temporary setting namespaces
with uiNamespace do {
    GVAR(clientTemp)  = _display ctrlCreate ["RscText", -1];
    GVAR(missionTemp) = _display ctrlCreate ["RscText", -1];
    GVAR(serverTemp)  = _display ctrlCreate ["RscText", -1];
};

// ----- create addons list (filled later)
private _ctrlAddonList = _display ctrlCreate [QGVAR(AddonsList), -1, _ctrlAddonsGroup];

_ctrlAddonList ctrlAddEventHandler ["LBSelChanged", {_this call FUNC(gui_addonChanged)}];

// ----- Add lists
_display setVariable [QGVAR(lists),[]];

// ----- fill addons list
private _categories = [];
{
    (GVAR(default) getVariable _x) params ["", "", "", "", "_category"];

    if !(_category in _categories) then {
        private _categoryLocalized = _category;
        if (isLocalized _category) then {
            _categoryLocalized = localize _category;
        };

        private _index = _ctrlAddonList lbAdd _categoryLocalized;
        _ctrlAddonList lbSetData [_index, str _index];
        _display setVariable [str _index, _category];

        _categories pushBack _category;
    };
} forEach GVAR(allSettings);

lbSort _ctrlAddonList;
_ctrlAddonList lbSetCurSel (uiNamespace getVariable [QGVAR(addonIndex), 0]);

// ----- create save and load presets buttons
private _ctrlButtonSave = _display ctrlCreate ["RscButtonMenu", IDC_BTN_SAVE];

_ctrlButtonSave ctrlSetPosition [
    POS_X(1.5),
    POS_Y(20.5),
    POS_W(6),
    POS_H(1)
];

_ctrlButtonSave ctrlCommit 0;
_ctrlButtonSave ctrlSetText localize "STR_DISP_INT_SAVE";
_ctrlButtonSave ctrlSetTooltip localize LSTRING(ButtonSave_tooltip);
_ctrlButtonSave ctrlEnable false;
_ctrlButtonSave ctrlShow false;
_ctrlButtonSave ctrlAddEventHandler ["ButtonClick", {[ctrlParent (_this select 0), "save"] call FUNC(gui_preset)}];

private _ctrlButtonLoad = _display ctrlCreate ["RscButtonMenu", IDC_BTN_LOAD];

_ctrlButtonLoad ctrlSetPosition [
    POS_X(7.6),
    POS_Y(20.5),
    POS_W(6),
    POS_H(1)
];

_ctrlButtonLoad ctrlCommit 0;
_ctrlButtonLoad ctrlSetText localize "STR_DISP_INT_LOAD";
_ctrlButtonLoad ctrlSetTooltip localize LSTRING(ButtonLoad_tooltip);
_ctrlButtonLoad ctrlEnable false;
_ctrlButtonLoad ctrlShow false;
_ctrlButtonLoad ctrlAddEventHandler ["ButtonClick", {[ctrlParent (_this select 0), "load"] call FUNC(gui_preset)}];

// ----- create export and import buttons
private _ctrlButtonImport = _display ctrlCreate ["RscButtonMenu", IDC_BTN_IMPORT];

_ctrlButtonImport ctrlSetPosition [
    POS_X(26.4),
    POS_Y(20.5),
    POS_W(6),
    POS_H(1)
];

_ctrlButtonImport ctrlCommit 0;
_ctrlButtonImport ctrlSetText localize LSTRING(ButtonImport);
_ctrlButtonImport ctrlSetTooltip localize LSTRING(ButtonImport_tooltip);
_ctrlButtonImport ctrlEnable false;
_ctrlButtonImport ctrlShow false;
_ctrlButtonImport ctrlAddEventHandler ["ButtonClick", {
    [ctrlParent (_this select 0), "import"] call FUNC(gui_export);
}];

private _ctrlButtonExport = _display ctrlCreate ["RscButtonMenu", IDC_BTN_EXPORT];

_ctrlButtonExport ctrlSetPosition [
    POS_X(32.5),
    POS_Y(20.5),
    POS_W(6),
    POS_H(1)
];

_ctrlButtonExport ctrlCommit 0;
_ctrlButtonExport ctrlSetText localize LSTRING(ButtonExport);
_ctrlButtonExport ctrlSetTooltip localize LSTRING(ButtonExport_tooltip);
_ctrlButtonExport ctrlEnable false;
_ctrlButtonExport ctrlShow false;
_ctrlButtonExport ctrlAddEventHandler ["ButtonClick", {
    [ctrlParent (_this select 0), "export"] call FUNC(gui_export);
}];

// ----- source buttons (server, mission, client)
{
    _x ctrlAddEventHandler ["ButtonClick", FUNC(gui_sourceChanged)];
} forEach [_ctrlServerButton, _ctrlMissionButton, _ctrlClientButton];

(_display displayCtrl IDC_BTN_CONFIGURE_ADDONS) ctrlAddEventHandler ["ButtonClick", {_this call FUNC(gui_configure)}];

// ----- scripted OK button
(_display displayCtrl 999) ctrlAddEventHandler ["ButtonClick", {
    call FUNC(gui_saveTempData);
    ctrlParent (_this select 0) closeDisplay IDC_OK;
}];

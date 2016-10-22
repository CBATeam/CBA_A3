#include "script_component.hpp"

params ["_display"];

uiNamespace setVariable [QGVAR(display), _display];

// ----- create addons list (filled later)
private _ctrlAddonsGroup = _display displayCtrl IDC_ADDONS_GROUP;
private _ctrlAddonList = _display ctrlCreate [QGVAR(AddonsList), -1, _ctrlAddonsGroup];

_ctrlAddonsGroup ctrlEnable false;
_ctrlAddonsGroup ctrlShow false;

_ctrlAddonList ctrlAddEventHandler ["LBSelChanged", FUNC(gui_addonChanged)];

private _categories = [];

// ----- create settings lists
#include "gui_createMenu.sqf"

// ----- fill addons list
{
    private _category = _x;

    private _index = _ctrlAddonList lbAdd _category;

    _ctrlAddonList lbSetData [_index, str _index];
    _display setVariable [str _index, _category];
} forEach _categories;

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

// copyFromClipboard has no effect in MP, so only add button in SP
if (!isMultiplayer) then {
    // ----- create export and import buttons
    private _ctrlButtonImport = _display ctrlCreate ["RscButtonMenu", IDC_BTN_IMPORT];

    _ctrlButtonImport ctrlSetPosition [
        POS_X(24.4),
        POS_Y(20.5),
        POS_W(6),
        POS_H(1)
    ];

    _ctrlButtonImport ctrlCommit 0;
    _ctrlButtonImport ctrlSetText localize LSTRING(ButtonImport);
    _ctrlButtonImport ctrlSetTooltip localize LSTRING(ButtonImport_tooltip);
    _ctrlButtonImport ctrlEnable false;
    _ctrlButtonImport ctrlShow false;
    _ctrlButtonImport ctrlAddEventHandler ["ButtonClick", {[copyFromClipboard, uiNamespace getVariable QGVAR(source)] call FUNC(import)}];

    uiNamespace setVariable [QGVAR(ctrlButtonImport), _ctrlButtonImport];
};

private _ctrlButtonExport = _display ctrlCreate ["RscButtonMenu", IDC_BTN_EXPORT];

_ctrlButtonExport ctrlSetPosition [
    POS_X(30.5),
    POS_Y(20.5),
    POS_W(6),
    POS_H(1)
];

_ctrlButtonExport ctrlCommit 0;
_ctrlButtonExport ctrlSetText localize LSTRING(ButtonExport);
_ctrlButtonExport ctrlSetTooltip localize LSTRING(ButtonExport_tooltip);
_ctrlButtonExport ctrlEnable false;
_ctrlButtonExport ctrlShow false;
_ctrlButtonExport ctrlAddEventHandler ["ButtonClick", {copyToClipboard ([uiNamespace getVariable QGVAR(source)] call FUNC(export))}];

uiNamespace setVariable [QGVAR(ctrlButtonExport), _ctrlButtonExport];

// ----- source buttons (client, server, mission)
{
    _x ctrlEnable false;
    _x ctrlShow false;
    _x ctrlAddEventHandler ["ButtonClick", FUNC(gui_sourceChanged)];
} forEach [_display displayCtrl IDC_BTN_SERVER, _display displayCtrl IDC_BTN_CLIENT, _display displayCtrl IDC_BTN_MISSION];

GVAR(clientSettingsTemp) call CBA_fnc_deleteNamespace;
GVAR(clientSettingsTemp) = [] call CBA_fnc_createNamespace;

GVAR(serverSettingsTemp) call CBA_fnc_deleteNamespace;
GVAR(serverSettingsTemp) = [] call CBA_fnc_createNamespace;

GVAR(missionSettingsTemp) call CBA_fnc_deleteNamespace;
GVAR(missionSettingsTemp) = [] call CBA_fnc_createNamespace;

(_display displayCtrl IDC_BTN_CONFIGURE_ADDONS) ctrlAddEventHandler ["ButtonClick", FUNC(gui_configure)];

// ----- scripted OK button
(_display displayCtrl 999) ctrlAddEventHandler ["ButtonClick", {call FUNC(saveTempData)}];

// set this per script to avoid it being all upper case
(_display displayCtrl IDC_TXT_FORCE) ctrlSetText localize LSTRING(priority);

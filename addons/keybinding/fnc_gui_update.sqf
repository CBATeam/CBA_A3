#include "script_component.hpp"

private _display = uiNamespace getVariable [QGVAR(display), displayNull];
if (isNull _display) exitWith {};

private _ctrlAddonList = _display displayCtrl IDC_ADDON_LIST;
private _ctrlKeyList = _display displayCtrl IDC_KEY_LIST;

// clear key list
private _subcontrols = _ctrlKeyList getVariable [QGVAR(KeyListSubcontrols), []];

{
    ctrlDelete _x;
} forEach _subcontrols;

_subcontrols = [];
_ctrlKeyList setVariable [QGVAR(KeyListSubcontrols), _subcontrols];

private _editableSubcontrols = [];
_ctrlKeyList setVariable [QGVAR(KeyListEditableSubcontrols), _editableSubcontrols];

private _index = lbCurSel _ctrlAddonList;
private _addon = _ctrlAddonList lbData _index;

private _addonActions = GVAR(addons) getVariable [_addon, [nil, []]] select 1;

uiNamespace setVariable [QGVAR(addonIndex), _index];

private _tempNamespace = uiNamespace getVariable QGVAR(tempKeybinds);

private _categoryKeyActions = [];

{
    private _action = format ["%1$%2", _addon, _x];
    private _subcategory = (GVAR(actions) getVariable _action) param [8, "", [""]];

    _categoryKeyActions pushBack [_subcategory, _forEachIndex, _x];
} forEach _addonActions;

_categoryKeyActions sort true;
private _lastSubcategory = "$START";
private _tablePosY = 0;

{
    _x params ["_subcategory", "", "_keyAction"];

    private _createHeader = false;
    if (_subcategory != _lastSubcategory) then {
        _lastSubcategory = _subcategory;
        _createHeader = _subcategory != "";
    };

    private _action = format ["%1$%2", _addon, _keyAction];
    (GVAR(actions) getVariable _action) params ["_displayName", "_tooltip", "_keybinds", "_defaultKeybind"];

    if (isLocalized _displayName) then {
        _displayName = localize _displayName;
    };

    if (isLocalized _tooltip) then {
        _tooltip = localize _tooltip;
    };

    _keybinds = _tempNamespace getVariable [_action, _keybinds];

    private _keyNames = [];
    {
        private _keybind = _x;
        private _keyName = _keybind call CBA_fnc_localizeKey;

        // add quotes around string.
        if (_keyName != "") then {
            _keyName = str _keyName;
        };

        // search the addon for any other keybinds using this key.
        if (_keybind select 0 > DIK_ESCAPE) then {
            if (_addonActions findIf {
                private _duplicateAction = format ["%1$%2", _addon, _x];
                private _duplicateKeybinds = GVAR(actions) getVariable _duplicateAction select 2;
                _duplicateKeybinds = _tempNamespace getVariable [_duplicateAction, _duplicateKeybinds];

                _keybind in _duplicateKeybinds && {_action != _duplicateAction}
            } > -1) then {
                _keyNames pushBack format ["<t color='#FF0000'>%1</t>", _keyName];
            } else {
                _keyNames pushBack format ["<t color='#FFFFFF'>%1</t>", _keyName];
            };
        };
    } forEach _keybinds;

    // add subcategory header
    if (_createHeader) then {
        private _header = _display ctrlCreate [QGVAR(subCat), -1, _ctrlKeyList];

        if (isLocalized _subcategory) then {
            _subcategory = localize _subcategory;
        };

        (_header controlsGroupCtrl IDC_SUBCATEGORY_NAME) ctrlSetText format ["%1:", _subcategory];
        _header ctrlSetPosition [POS_W(0), _tablePosY];
        _header ctrlCommit 0;

        _tablePosY = _tablePosY + getNumber (configFile >> QGVAR(subCat) >> "h");
        _subcontrols pushBack _header;
    };

    // tooltips bugged for lnb
    private _subcontrol = _display ctrlCreate [QGVAR(key), -1, _ctrlKeyList];

    _subcontrol ctrlSetPosition [POS_W(0), _tablePosY];
    _subcontrol ctrlCommit 0;

    _tablePosY = _tablePosY + POS_H(1);

    private _edit = _subcontrol controlsGroupCtrl IDC_KEY_EDIT;
    _edit ctrlSetText _displayName;
    _edit ctrlSetTooltip _tooltip;
    _edit ctrlSetTooltipColorBox [1,1,1,1];
    _edit ctrlSetTooltipColorShade [0,0,0,0.7];
    _edit setVariable [QGVAR(data), [_action, _displayName, _keybinds, _defaultKeybind, _forEachIndex]];

    private _assigned = _subcontrol controlsGroupCtrl IDC_KEY_ASSIGNED;
    _assigned ctrlSetStructuredText parseText (_keyNames joinString ", ");
    _assigned ctrlSetTooltip _tooltip;
    _assigned ctrlSetTooltipColorBox [1,1,1,1];
    _assigned ctrlSetTooltipColorShade [0,0,0,0.7];

    _subcontrols pushBack _subcontrol;
    _editableSubcontrols pushBack _subcontrol;
} forEach _categoryKeyActions;

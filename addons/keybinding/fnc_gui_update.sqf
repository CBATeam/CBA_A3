#include "script_component.hpp"

private _display = uiNamespace getVariable [QGVAR(display), displayNull];
if (isNull _display) exitWith {};

private _ctrlAddonList = _display displayCtrl IDC_ADDON_LIST;
private _ctrlKeyList = _display displayCtrl IDC_KEY_LIST;

lnbClear _ctrlKeyList;

private _index = lbCurSel _ctrlAddonList;
private _addon = _ctrlAddonList lbData _index;

private _addonActions = GVAR(addons) getVariable [_addon, [nil, []]] select 1;

uiNamespace setVariable [QGVAR(addonIndex), _index];

private _tempNamespace = uiNamespace getVariable QGVAR(tempKeybinds);

{
    private _action = format ["%1$%2", _addon, _x];
    (GVAR(actions) getVariable _action) params ["_displayName", "_tooltip", "_keybinds", "_defaultKeybind"];

    if (isLocalized _displayName) then {
        _displayName = localize _displayName;
    };

    if (isLocalized _tooltip) then {
        _tooltip = localize _tooltip;
    };

    _keybinds = _tempNamespace getVariable [_action, _keybinds];

    private _keyNames = [];
    private _isDuplicated = false;

    {
        private _keybind = _x;
        private _keyName = _keybind call CBA_fnc_localizeKey;

        // add quotes around string.
        if (_keyName != "") then {
            _keyName = str _keyName;
        };

        // search the addon for any other keybinds using this key.
        if (_keybind select 0 > DIK_ESCAPE) then {
            {
                private _duplicateAction = format ["%1$%2", _addon, _x];
                private _duplicateKeybinds = GVAR(actions) getVariable _duplicateAction select 2;
                _duplicateKeybinds = _tempNamespace getVariable [_duplicateAction, _duplicateKeybinds];

                if (_keybind in _duplicateKeybinds && {_action != _duplicateAction}) exitWith {
                    _isDuplicated = true;
                };
            } forEach _addonActions;

            _keyNames pushBack _keyName;
        };
    } forEach _keybinds;

    // add keybinds to action list
    private _index = _ctrlKeyList lnbAddRow [_displayName, _keyNames joinString ", "];

    // tooltips bugged for lnb
    _ctrlKeyList lbSetTooltip [2 * _index, _tooltip];
    _ctrlKeyList lbSetTooltip [2 * _index + 1, _tooltip];

    _ctrlKeyList lnbSetData [[_index, 0], str [_action, _displayName, _keybinds, _defaultKeybind]];

    if (_isDuplicated) then {
        _ctrlKeyList lnbSetColor [[_index, 1], [1, 0, 0, 1]];
    };
} forEach _addonActions;

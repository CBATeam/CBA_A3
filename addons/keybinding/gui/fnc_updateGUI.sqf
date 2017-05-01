//#define DEBUG_MODE_FULL
#include "\x\cba\addons\keybinding\script_component.hpp"
private ["_firstRun", "_display", "_combo", "_lnb", "_modName", "_modActions"];
disableSerialization;


// Pass any parameter to the function for full initialization behavior.
_firstRun = (count _this == 1);

_display = uiNamespace getVariable "RscDisplayConfigure";

if !(isNull _display) then {
    _combo = _display displayCtrl 208;
    _lnb = _display displayCtrl 202;

    _lnb ctrlSetTooltipColorShade [0,0,0,0.5];

    // First run only actions.
    if (_firstRun) then {
        lbClear _combo;

        {
            private _addonInfo = GVAR(activeMods) getVariable _x;
            private _addonName = GVAR(modPrettyNames) getVariable [_x, _addonInfo select 0];

            _combo lbSetData [_combo lbAdd _addonName, _x];
        } forEach allVariables GVAR(activeMods);

        lbSort _combo;
        _combo lbSetCurSel 0;
    };

    // Fill the listnbox with actions.
    if (count allVariables GVAR(activeMods) > 0) then {
        // Get the selected mod.
        _modName = _combo lbData (lbCurSel _combo);
        // Get the actions associated with the current mod.
        _modActions = GVAR(activeMods) getVariable _modName select 1;

        // Clear the listbox.
        lnbClear _lnb;

        // Add the actions to the listbox and associate their data.
        // of keybinds due to keyup/keydown.
        {
            private ["_actionId", "_action", "_keybind", "_isDuplicated", "_dupeActionName", "_lbCount", "_indexArray"];
            _actionId = _x;
            if((toLower format ["%1$%2", _modName, _actionId]) in allVariables GVAR(activeBinds)) then {
                _action = GVAR(activeBinds) getVariable format ["%1$%2", _modName, _actionId];
                _action params ["_displayName", "_tooltip", "_registryKeybinds"];
                _keybind = _registryKeybinds select 0;

                TRACE_4("",_modName,_action,_displayName,_keybind);
                if(IS_ARRAY(_keybind) && {IS_ARRAY(_keybind select 1)}) then {
                    _keybind params ["_key", "_modifier"];
                    _modifier params ["_shift", "_ctrl", "_alt"];

                    // Try to convert dik code to a human key code.
                    private _keyName = GVAR(keyNames) getVariable str _key;

                    if (isNil "_keyName") then {
                        _keyName = format [localize LSTRING(unkownKey), _key];
                    };

                    // Build the full key combination name.
                    if (_shift && {!(_key in [DIK_LSHIFT, DIK_RSHIFT])}) then {
                        _keyName = localize "str_dik_shift" + "+" + _keyName;
                    };

                    if (_alt && {!(_key in [DIK_LMENU, DIK_RMENU])}) then {
                        _keyName = localize "str_dik_alt" + "+" + _keyName;
                    };

                    if (_ctrl && {!(_key in [DIK_LCONTROL, DIK_RCONTROL])}) then {
                        _keyName = localize "str_dik_control" + "+" + _keyName;
                    };

                    // Add quotes around whole string.
                    if (_keyName != "") then {
                        _keyName = str _keyName;
                    };

                    TRACE_1("",_keyName);
                    // Search the handler array for any other keybinds using this key.
                    _isDuplicated = false;
                    if (_key > 0) then {
                        _dupeActionName = "";
                        {
                            private _dupeActionId = _x;
                            private _dupeKeybinds = GVAR(activeBinds) getVariable format ["%1$%2", _modName, _dupeActionId] select 2;

                            if (_keybind in _dupeKeybinds && {_actionId != _dupeActionId}) exitWith {
                                _isDuplicated = true;
                                _dupeActionName = GVAR(activeBinds) getVariable format ["%1$%2", _modName, _dupeActionId] select 0;
                            };
                        } forEach _modActions;

                        if (_isDuplicated) then {
                            // Add the name of the action that dupes the keybinding to the
                            // end of the readable bind string.
                            _keyName = format ["%1 [%2]", _keyName, _dupeActionName];
                        };
                    } else {
                        //(dikCode <= 0): so it's unbound, leave string blank
                        _keyName = "";
                    };

                    // Add the row.
                    _lbCount = _lnb lnbAddRow [_displayName, _keyName];
                    _lnb lbSetTooltip [2*_lbCount, _toolTip];
                    _lnb lbSetTooltip [2*_lbCount + 1, _toolTip];

                    // Format the array containing the indexes referred to by the action name.
                    // It is stored as a string.
                    _indexArray = [_index];
                    if (_foundIndex > -1) then {
                        _indexArray pushBack _foundIndex;
                    };

                    // Set row data to the index of the action in the handler tracker.
                    _lnb lnbSetData [[_lbCount, 0], _actionId];

                    // Set the row color to red if a duplicate keybind exists.
                    if (_isDuplicated) then {
                        _lnb lnbSetColor [[_lbCount, 1], [1,0,0,1]];
                    };
                };
            };
        } foreach _modActions;
    };
};

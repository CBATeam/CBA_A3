//#define DEBUG_MODE_FULL
#include "\x\cba\addons\keybinding\script_component.hpp"

disableSerialization;

_firstRun = false;
// Pass any parameter to the function for full initialization behavior.
if (count _this == 1) then {_firstRun = true};

_display = uiNamespace getVariable "RscDisplayConfigure";

if !(isNull _display) then {
    _combo = _display displayCtrl 208;
    _lnb = _display displayCtrl 202;

    _lnb ctrlSetTooltipColorShade [0,0,0,0.5];

    // First run only actions.
    if (_firstRun) then {
        // Clear the combobox.
        lbClear _combo;

        if (count GVAR(activeMods) > 0) then {
            // Populate the combolistbox.
            {
                if(_x in GVAR(activeMods)) then {
                    _nameIndex = (GVAR(modPrettyNames) select 0) find _x;
                    _modPrettyName = _x;
                    if(_nameIndex != -1) then {
                        _modPrettyName = (GVAR(modPrettyNames) select 1) select _nameIndex;
                    };
                    _entry = _combo lbAdd _modPrettyName;
                    _combo lbSetData [_entry, _x];
                };
            } foreach (GVAR(handlers) select 0);
        };

        _combo lbSetCurSel 0;
    };

    // Fill the listnbox with actions.
    if (count GVAR(activeMods) > 0) then {
        // Get the selected mod.
        _modName = _combo lbData (lbCurSel _combo);
        // Get the actions associated with the current mod.
        _modActions = (GVAR(handlers) select 1) select ((GVAR(handlers) select 0) find _modName);

        // Clear the listbox.
        lnbClear _lnb;

        // Add the actions to the listbox and associate their data.
        // of keybinds due to keyup/keydown.
        {
            _actionId = _x;
            if((_modName + "_" + _actionId) in GVAR(activeBinds)) then {
                _action = (_modActions select 1) select _forEachIndex;
                _actionName = _action select 0;
                _keybind = _action select 1;

                _toolTip = "";
                if(IS_ARRAY(_actionName)) then {
                    _prettyName = (_actionName select 0);
                    if((count _actionName) > 1) then {
                        _toolTip = _actionName select 1;
                    };
                    _actionName = _prettyName;
                };
                TRACE_4("",_modName,_action,_actionName,_keybind);
                if(IS_ARRAY(_keybind) && {IS_ARRAY(_keybind select 1)}) then {
                    _dikCode = _keybind select 0;
                    _shift = (_keybind select 1) select 0;
                    _ctrl = (_keybind select 1) select 1;
                    _alt = (_keybind select 1) select 2;

                    // Try to convert dik code to a human key code.
                    _keyName = [GVAR(dikDecToStringTable), format ["%1", _dikCode]] call bis_fnc_getFromPairs;
                    if (isNil "_keyName") then {
                        _keyName = format ["Unknown Code %1", _dikCode];
                    };

                    // Build the full key combination name.
                    _keyString = format ["%1", _keyName];
                    if (_shift && {_dikCode != 42} && {_dikCode != 54}) then {_keyString = format ["Shift+%1", _keyString]};
                    if (_alt && _dikCode != 56) then {_keyString = format ["Alt+%1", _keyString]};
                    if (_ctrl && _dikCode != 29) then {_keyString = format ["Ctrl+%1", _keyString]};
                    if (_keyString != "") then {
                        // Add quotes around whole string.
                        _keyString = format ["""%1""", _keyString]
                    };
                    TRACE_1("",_keyString);
                    // Search the handler array for any other keybinds using this key.
                    _isDuplicated = false;
                    if(_dikCode != 0) then {
                        _dupeActionName = "";
                        {

                            _sActionId = _x;
                            _dupeAction = (_modActions select 1) select _forEachIndex;
                            _sActionName = _dupeAction select 0;
                            _sKeybind = _dupeAction select 1;
                            if((_modName + "_" + _sActionId) in GVAR(activeBinds)) then {
                                if (_sActionId != _actionId && _sKeybind isEqualTo _keybind) exitWith {
                                    _isDuplicated = true;
                                    _dupeActionName = _sActionName;
                                };
                            };
                        } foreach (_modActions select 0);

                        if (_isDuplicated) then {
                            // Add the name of the action that dupes the keybinding to the
                            // end of the readable bind string.
                            _keyString = format ["%1 [%2]", _keyString, _dupeActionName];
                        };
                    };

                    // Add the row.
                    _lbCount = _lnb lnbAddRow [_actionName, _keyString];
                    _lnb lbSetTooltip [_lbCount, _toolTip];

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

                    if(_dikCode == 0) then {
                        // @TODO: Set the color seperately if it is an unbound key.
                    };
                };
            };
        } foreach (_modActions select 0);
    };
};
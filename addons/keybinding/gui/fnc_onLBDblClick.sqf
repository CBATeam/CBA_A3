#include "\x\cba\addons\keybinding\script_component.hpp"

disableSerialization;

_display = uiNamespace getVariable "RscDisplayConfigure";

// Get listnbox
_lnb = _display displayCtrl 202;
// Get currently selected index
_lnbIndex = lnbCurSelRow _lnb;
// Get combobox
_combo = _display displayCtrl 208;
// Get the mod selected in the comobo
_comboMod = _combo lbData (lbCurSel _combo);

// Don't allow multiple keys to be changed at once.
if (GVAR(waitingForInput)) exitWith {};

// Get handler tracker index array for keys stored in listbox data string
_actionId = _lnb lnbData [_lnbIndex, 0];



// Clear keypress data.
GVAR(input) = [];

GVAR(modifiers) = [];

// Mark that we're waiting so that onKeyDown handler blocks input (Esc key)
GVAR(waitingForInput) = true;

// Update box content to indicate that we're waiting for input.
_lnb lnbSetText [[_lnbIndex, 1], "Press key or Esc to cancel"];
_lnb lnbSetColor [[_lnbIndex, 1], [0,1,0,1]];

// Wait for input, selection, or mod change.
_fnc = {
    _data = _this select 0;
    _actionId = _data select 0;
    _lnb = _data select 1;
    _lnbIndex = _data select 2;
    _comboMod = _data select 3;
    _combo = _data select 4;
    _display = _data select 5;

    if(count GVAR(input) > 0 || !GVAR(waitingForInput) || lnbCurSelRow _lnb != _lnbIndex || _comboMod != (_combo lbData (lbCurSel _combo))) then {
        [(_this select 1)] call cba_fnc_removePerFrameHandler;
        if (GVAR(waitingForInput)) then {
            // Tell the onKeyDown handler that we're not waiting anymore, so it stops blocking input.
            GVAR(waitingForInput) = false;

            if (!isNull _display) then { // Make sure user hasn't exited dialog before continuing.
                // Get stored keypress data.
                _newKeycode = GVAR(input);

                // If a valid key other than Escape was pressed,
                if (_newKeycode select 0 != 1) then {
                    _modId = (GVAR(handlers) select 0) find _comboMod;
                    if(_modId == -1) exitWith {};

                    _modRegistry = (GVAR(handlers) select 1) select _modId;

                    _actionEntryId = (_modRegistry select 0) find _actionId;
                    if(_actionEntryId == -1) exitWith {};
                    _actionEntry = (_modRegistry select 1) select _actionEntryId;

                    _hashDown = format["%1_%2_down", _comboMod, _actionId];
                    _entryIndex = (GVAR(defaultKeybinds) select 0) find _hashDown;
                    if(_entryIndex == -1) exitWith {};
                    _defaultEntry = (GVAR(defaultKeybinds) select 1) select _entryIndex;
                    
                    [
                        _comboMod, 
                        _actionId, 
                        _actionEntry select 0, 
                        _defaultEntry select 0,
                        _defaultEntry select 1,
                        _newKeycode,
                        _defaultEntry select 2,
                        _defaultEntry select 3,
                        true
                    ] call cba_fnc_registerKeybind;
                    // Update the main dialog.
                    saveProfileNamespace;
                };
                
                
            };
        };
        [] call FUNC(updateGUI);
    };
};
[_fnc, 0, [_actionId, _lnb, _lnbIndex, _comboMod, _combo, _display]] call cba_fnc_addPerFrameHandler;
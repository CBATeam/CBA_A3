//#define DEBUG_MODE_FULL
#include "\x\cba\addons\keybinding\script_component.hpp"

disableSerialization;
private ["_display", "_lnb", "_lnbIndex", "_combo", "_comboMod", "_actionId"];
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
GVAR(frameNoKeyPress) = diag_frameNo;

GVAR(modifiers) = [];
GVAR(firstKey) = [];
GVAR(secondKey) = [];
GVAR(thirdKey) = [];

// Mark that we're waiting so that onKeyDown handler blocks input (Esc key)
GVAR(waitingForInput) = true;

// Update box content to indicate that we're waiting for input.
_lnb lnbSetText [[_lnbIndex, 1], "Press key or Esc to cancel"];
_lnb lnbSetColor [[_lnbIndex, 1], [0,1,0,1]];

// Wait for input, selection, or mod change.
_fnc = {
    params ["_args", "_idPFH"];
    _args params ["_actionId", "_lnb", "_lnbIndex", "_comboMod", "_combo", "_display"];
    if (count GVAR(thirdKey) > 0 || !GVAR(waitingForInput) || lnbCurSelRow _lnb != _lnbIndex || _comboMod != (_combo lbData (lbCurSel _combo))) then {
        if ((GVAR(input) select 0) in GVAR(forbiddenKeys)) exitWith {};
        [_idPFH] call cba_fnc_removePerFrameHandler;
        if (GVAR(waitingForInput)) then {
            // Tell the onKeyDown handler that we're not waiting anymore, so it stops blocking input.
            GVAR(waitingForInput) = false;

            if (!isNull _display) then { // Make sure user hasn't exited dialog before continuing.
                private ["_newKeycode", "_modId", "_modRegistry", "_actionEntryId", "_actionEntry", "_hashDown", "_entryIndex", "_defaultEntry"];
                // Get stored keypress data.
                if (GVAR(frameNoKeyPress) == diag_frameNo) exitWith {};
                _newKeycode = GVAR(input);
                TRACE_4("",_newKeycode,GVAR(handlers),_comboMod,GVAR(defaultKeybinds));
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
                    ] call cba_fnc_addKeybind;
                    // Update the main dialog.
                    saveProfileNamespace;
                };

            };
        };
        [] call FUNC(updateGUI);
    };
};
[_fnc, 0, [_actionId, _lnb, _lnbIndex, _comboMod, _combo, _display]] call cba_fnc_addPerFrameHandler;

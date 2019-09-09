#include "script_component.hpp"

params ["_display"];

private _messageBox = _display displayCtrl IDC_MSG_BOX_MESSAGE;
private _message = ctrlText _messageBox;

// This check has to work with all languages and without functions defined in mission namespace.
private _isSignatureMissingMessage = _message find (with uiNamespace do {
    [localize "str_signature_missing", "%s"] call CBA_fnc_split
} select 1) != -1;

if (_isSignatureMissingMessage) then {
    private _messageBoxHeader = _display displayCtrl 11001;
    _messageBoxHeader ctrlSetText toUpper LLSTRING(ContactServerAdmin);
};

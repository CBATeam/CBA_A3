#include "script_component.hpp"

params ["_parentDisplay", "_mode"];

_display = _parentDisplay createDisplay QGVAR(export);

private _ctrlPresetsGroup = _display displayCtrl IDC_EXPORT_GROUP;
private _ctrlTitle = _display displayCtrl IDC_EXPORT_TITLE;
private _ctrlValue = _display displayCtrl IDC_EXPORT_VALUE;
private _ctrlOK = _display displayCtrl IDC_EXPORT_OK;
private _ctrlCancel = _display displayCtrl IDC_EXPORT_CANCEL;
private _ctrlToggleDefault = _display displayCtrl IDC_EXPORT_TOGGLE_DEFAULT;
private _ctrlToggleDefaultText = _display displayCtrl IDC_EXPORT_TOGGLE_DEFAULT_TEXT;

// --- scripted buttons
if (_mode == "import") then {
    _ctrlTitle ctrlSetText localize LSTRING(ButtonImport);

    _ctrlToggleDefault ctrlEnable false;
    _ctrlToggleDefault ctrlShow false;
    _ctrlToggleDefaultText ctrlEnable false;
    _ctrlToggleDefaultText ctrlShow false;

    _ctrlOK ctrlAddEventHandler ["ButtonClick", {
        params ["_control"];
        private _display = ctrlParent _control;

        private _ctrlValue = _display displayCtrl IDC_EXPORT_VALUE;
        [ctrlText _ctrlValue, uiNamespace getVariable QGVAR(source)] call FUNC(import);

        _display closeDisplay IDC_OK;
    }];
} else {
    _ctrlTitle ctrlSetText localize LSTRING(ButtonExport);

    _ctrlToggleDefault cbSetChecked (uiNamespace getVariable [QGVAR(showDefault), true]);
    _ctrlToggleDefault ctrlAddEventHandler ["CheckedChanged", {
        params ["_ctrlToggleDefault", "_state"];
        _state = _state isEqualTo 1;

        uiNamespace setVariable [QGVAR(showDefault), _state];

        private _ctrlValue = ctrlParent _ctrlToggleDefault displayCtrl IDC_EXPORT_VALUE;
        _ctrlValue ctrlSetText ([uiNamespace getVariable QGVAR(source), _state] call FUNC(export));
    }];

    _ctrlValue ctrlSetText ([uiNamespace getVariable QGVAR(source), cbChecked _ctrlToggleDefault] call FUNC(export));

    if (isServer) then {
        _ctrlOK ctrlSetText localize LSTRING(copy_to_clipboard);
        _ctrlOK ctrlAddEventHandler ["ButtonClick", {
            params ["_control"];
            private _display = ctrlParent _control;

            private _ctrlValue = _display displayCtrl IDC_EXPORT_VALUE;
            copyToClipboard ctrlText _ctrlValue;

            _display closeDisplay IDC_OK;
        }];
    } else {
        _ctrlOK ctrlEnable false;
        _ctrlOK ctrlShow false;
    };
};

private _position = ctrlPosition _ctrlValue;
_position set [3, (ctrlTextHeight _ctrlValue) + (_position select 3)];
_ctrlValue ctrlSetPosition _position;
_ctrlValue ctrlCommit 0;

_ctrlCancel ctrlAddEventHandler ["ButtonClick", {
    params ["_control"];
    private _display = ctrlParent _control;

    _display closeDisplay IDC_CANCEL;
}];

#include "script_component.hpp"

params ["_parentDisplay", "_mode"];

_display = _parentDisplay createDisplay QGVAR(export);

private _ctrlPresetsGroup = _display displayCtrl IDC_EXPORT_GROUP;
private _ctrlTitle = _display displayCtrl IDC_EXPORT_TITLE;
private _ctrlValue = _display displayCtrl IDC_EXPORT_VALUE;
private _ctrlOK = _display displayCtrl IDC_EXPORT_OK;
private _ctrlCancel = _display displayCtrl IDC_EXPORT_CANCEL;

// --- scripted buttons
if (_mode == "import") then {
    _ctrlTitle ctrlSetText localize LSTRING(ButtonImport);

    _ctrlOK ctrlAddEventHandler ["ButtonClick", {
        params ["_control"];
        private _display = ctrlParent _control;

        private _ctrlValue = _display displayCtrl IDC_EXPORT_VALUE;
        [ctrlText _ctrlValue, uiNamespace getVariable QGVAR(source)] call FUNC(import);

        _display closeDisplay IDC_OK;
    }];
} else {
    _ctrlTitle ctrlSetText localize LSTRING(ButtonExport);
    _ctrlValue ctrlSetText ([uiNamespace getVariable QGVAR(source)] call FUNC(export));

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

_ctrlCancel ctrlAddEventHandler ["ButtonClick", {
    params ["_control"];
    private _display = ctrlParent _control;

    _display closeDisplay IDC_CANCEL;
}];

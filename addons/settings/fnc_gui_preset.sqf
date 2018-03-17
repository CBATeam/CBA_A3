#include "script_component.hpp"

// get button
params ["_parentDisplay", "_mode"];

_display = _parentDisplay createDisplay QGVAR(presets);

private _ctrlPresetsGroup = _display displayCtrl IDC_PRESETS_GROUP;
private _ctrlTitle = _display displayCtrl IDC_PRESETS_TITLE;
private _ctrlName = _display displayCtrl IDC_PRESETS_NAME;
private _ctrlEdit = _display displayCtrl IDC_PRESETS_EDIT;
private _ctrlValue = _display displayCtrl IDC_PRESETS_VALUE;
private _ctrlOK = _display displayCtrl IDC_PRESETS_OK;
private _ctrlCancel = _display displayCtrl IDC_PRESETS_CANCEL;
private _ctrlDelete = _display displayCtrl IDC_PRESETS_DELETE;

if (_mode == "save") then {
    _ctrlTitle ctrlSetText format ["%1 (%2)", localize "STR_DISP_INT_SAVE", localize STR_SOURCE];

    // --- generate default name
    _ctrlEdit ctrlSetText format ["New: %1",
        localize ([
            LSTRING(ButtonServer), LSTRING(ButtonMission), LSTRING(ButtonClient)
        ] param [[
            "server", "mission", "client"
        ] find (uiNamespace getVariable QGVAR(source))])
    ];

    _ctrlValue ctrlAddEventHandler ["LBSelChanged", {
        params ["_control", "_index"];
        private _display = ctrlParent _control;

        private _ctrlEdit = _display displayCtrl IDC_PRESETS_EDIT;
        _ctrlEdit ctrlSetText (_control lbText _index);
    }];

    ctrlSetFocus _ctrlEdit;
} else {
    _ctrlTitle ctrlSetText format ["%1 (%2)", localize "STR_DISP_INT_LOAD", localize STR_SOURCE];

    // --- hide edit box in "load" mode
    _ctrlName ctrlEnable false;
    _ctrlName ctrlShow false;

    _ctrlEdit ctrlEnable false;
    _ctrlEdit ctrlShow false;
};

// --- fill listbox with profile stored presets
private _presetsHash = profileNamespace getVariable [QGVAR(presetsHash), HASH_NULL];

[_presetsHash, {
    private _index = _ctrlValue lbAdd _key;
    _ctrlValue lbSetData [_index, str _index];
    _ctrlValue setVariable [str _index, _value];
}] call CBA_fnc_hashEachPair;

// --- scripted buttons
if (_mode == "save") then {
    _ctrlOK ctrlAddEventHandler ["ButtonClick", {
        params ["_control"];
        private _display = ctrlParent _control;

        private _ctrlEdit = _display displayCtrl IDC_PRESETS_EDIT;
        private _presetName = ctrlText _ctrlEdit;

        private _preset = [uiNamespace getVariable QGVAR(source)] call FUNC(export);
        private _presetsHash = profileNamespace getVariable [QGVAR(presetsHash), HASH_NULL];

        [_presetsHash, _presetName, _preset] call CBA_fnc_hashSet;
        profileNamespace setVariable [QGVAR(presetsHash), _presetsHash];

        _display closeDisplay IDC_OK;
    }];
} else {
    _ctrlOK ctrlAddEventHandler ["ButtonClick", {
        params ["_control"];
        private _display = ctrlParent _control;

        private _ctrlValue = _display displayCtrl IDC_PRESETS_VALUE;
        private _index = lbCurSel _ctrlValue;
        private _preset = _ctrlValue getVariable [_ctrlValue lbData _index, ""];

        [_preset, uiNamespace getVariable QGVAR(source)] call FUNC(import);

        _display closeDisplay IDC_OK;
    }];
};

_ctrlCancel ctrlAddEventHandler ["ButtonClick", {
    params ["_control"];
    private _display = ctrlParent _control;

    _display closeDisplay IDC_CANCEL;
}];

_ctrlDelete ctrlAddEventHandler ["ButtonClick", {
    params ["_control"];
    private _display = ctrlParent _control;

    private _ctrlValue = _display displayCtrl IDC_PRESETS_VALUE;
    private _index = lbCurSel _ctrlValue;
    private _presetName = _ctrlValue lbText _index;

    _ctrlValue lbDelete _index;

    private _presetsHash = profileNamespace getVariable [QGVAR(presetsHash), HASH_NULL];

    [_presetsHash, _presetName] call CBA_fnc_hashRem;
    profileNamespace setVariable [QGVAR(presetsHash), _presetsHash];
}];

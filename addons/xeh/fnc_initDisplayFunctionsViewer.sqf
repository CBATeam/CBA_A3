#include "script_component.hpp"
#include "\a3\ui_f\hpp\defineResinclDesign.inc"

params ["_display"];

private _listSources = _display displayCtrl IDC_RSCDISPLAYFUNCTIONSVIEWER_SOURCES;
private _listAddons = _display displayCtrl IDC_RSCDISPLAYFUNCTIONSVIEWER_TAGS;
private _listComponents = _display displayCtrl IDC_RSCDISPLAYFUNCTIONSVIEWER_CATEGORIES;
private _listFunctions = _display displayCtrl IDC_RSCDISPLAYFUNCTIONSVIEWER_FUNCTIONS;

// Add custom category.
private _index = _listSources lbAdd "XEH PREP()";
_listSources lbSetValue [_index, 3];
_listSources lbSetData [_index, QGVAR(PREP)];

_listSources ctrlAddEventHandler ["LBSelChanged", {
    params ["_listSources"];
    private _display = ctrlParent _listSources;
    private _listAddons = _display displayCtrl IDC_RSCDISPLAYFUNCTIONSVIEWER_TAGS;

    uiNamespace setVariable [QGVAR(FV_isPREPSelected), _listSources lbValue lbCurSel _listSources isEqualTo 3];
    if (_listSources lbData lbCurSel _listSources != QGVAR(PREP)) exitWith {};

    lbClear _listAddons;

    private _addons = _display getVariable [QGVAR(addons), []];
    for "_i" from 0 to (count _addons - 1) step 2 do {
        private _addon = _addons select _i;
        _listAddons lbSetData [_listAddons lbAdd _addon, _addon];
    };

    lbSort _listAddons;
    _listAddons lbSetCurSel 0;

    // Stop BI event from running on this control.
    _this set [0, controlNull];
}];

_listAddons ctrlAddEventHandler ["LBSelChanged", {
    params ["_listAddons"];
    private _display = ctrlParent _listAddons;
    private _listSources = _display displayCtrl IDC_RSCDISPLAYFUNCTIONSVIEWER_SOURCES;
    private _listComponents = _display displayCtrl IDC_RSCDISPLAYFUNCTIONSVIEWER_CATEGORIES;

    if (_listSources lbData lbCurSel _listSources != QGVAR(PREP)) exitWith {};

    private _currentAddon = _listAddons lbData lbCurSel _listAddons;
    uiNamespace setVariable [QGVAR(FV_addon), _currentAddon];
    lbClear _listComponents;

    private _addons = _display getVariable [QGVAR(addons), []];
    private _components = _addons select ((_addons find _currentAddon) + 1);
    for "_i" from 0 to (count _components - 1) step 2 do {
        private _component = _components select _i;
        _listComponents lbSetData [_listComponents lbAdd _component, _component];
    };

    lbSort _listComponents;
    _listComponents lbSetCurSel 0;

    // Stop BI event from running on this control.
    _this set [0, controlNull];
}];

_listComponents ctrlAddEventHandler ["LBSelChanged", {
    params ["_listComponents"];
    private _display = ctrlParent _listComponents;
    private _listSources = _display displayCtrl IDC_RSCDISPLAYFUNCTIONSVIEWER_SOURCES;
    private _listAddons = _display displayCtrl IDC_RSCDISPLAYFUNCTIONSVIEWER_TAGS;
    private _listFunctions = _display displayCtrl IDC_RSCDISPLAYFUNCTIONSVIEWER_FUNCTIONS;

    if (_listSources lbData lbCurSel _listSources != QGVAR(PREP)) exitWith {};

    private _currentAddon = _listAddons lbData lbCurSel _listAddons;
    private _currentComponent = _listComponents lbData lbCurSel _listComponents;
    uiNamespace setVariable [QGVAR(FV_component), _currentComponent];
    lbClear _listFunctions;

    private _addons = _display getVariable [QGVAR(addons), []];
    private _components = _addons select ((_addons find _currentAddon) + 1);
    private _functions = _components select ((_components find _currentComponent) + 1);

    {
        _x params ["_funcName", "_funcFile"];
        _listFunctions lbSetData [_listFunctions lbAdd _funcName, [_funcName, _funcFile] joinString "$"];
    } forEach _functions;

    lbSort _listFunctions;
    _listFunctions lbSetCurSel 0;

    // Stop BI event from running on this control.
    _this set [0, controlNull];
}];

_listFunctions ctrlAddEventHandler ["LBSelChanged", {
    params ["_listFunctions"];
    private _display = ctrlParent _listFunctions;
    private _listSources = _display displayCtrl IDC_RSCDISPLAYFUNCTIONSVIEWER_SOURCES;

    if (_listSources lbData lbCurSel _listSources != QGVAR(PREP)) exitWith {};

    private _textName = _display displayCtrl IDC_RSCDISPLAYFUNCTIONSVIEWER_NAME;
    private _textPath = _display displayCtrl IDC_RSCDISPLAYFUNCTIONSVIEWER_AUTHOR;
    private _textCode = _display displayCtrl IDC_RSCDISPLAYFUNCTIONSVIEWER_CODE;

    _listFunctions lbData lbCurSel _listFunctions splitString "$" params ["_funcName", "_funcFile"];
    uiNamespace setVariable [QGVAR(FV_function), _funcName];

    _textName ctrlSetText _funcName;
    _textPath ctrlSetText _funcFile;
    _textCode ctrlSetText loadFile _funcFile;
    _textCodePos = ctrlPosition _textCode;
    _textCodePos set [3, ctrlTextHeight _textCode];
    _textCode ctrlSetPosition _textCodePos;
    _textCode ctrlCommit 0;

    // Stop BI event from running on this control.
    _this set [0, controlNull];
}];

private _addons = [];

private _functions = uiNamespace getVariable ["cba_xeh_PREP_list", false];
if !(_functions isEqualType {}) exitWith {};

{
    _x params ["_funcName", "_funcFile"];
    _funcFile splitString "\" params ["", ["_addon", ""], "", ["_component", ""]];

    private _index = _addons pushBackUnique _addon;

    if (_index isEqualTo -1) then {
        _index = _addons find _addon;
    } else {
        _addons pushBack [];
    };

    private _components = _addons select (_index + 1);
    _index = _components pushBackUnique _component;

    if (_index isEqualTo -1) then {
        _index = _components find _component;
    } else {
        _components pushBack [];
    };

    private _functions = _components select (_index + 1);

    _functions pushBack [_funcName, _funcFile];
} forEach call _functions;

_display setVariable [QGVAR(addons), _addons];

if (uiNamespace getVariable [QGVAR(FV_isPREPSelected), false]) then {
    private _currentAddon = uiNamespace getVariable [QGVAR(FV_addon), ""];
    private _currentComponent = uiNamespace getVariable [QGVAR(FV_component), ""];
    private _currentFunction = uiNamespace getVariable [QGVAR(FV_function), ""];

    _listSources lbSetCurSel 3;

    for "_i" from 0 to (lbSize _listAddons - 1) do {
        if (_listAddons lbText _i isEqualTo _currentAddon) exitWith {
            _listAddons lbSetCurSel _i;
        };
    };

    for "_i" from 0 to (lbSize _listComponents - 1) do {
        if (_listComponents lbText _i isEqualTo _currentComponent) exitWith {
            _listComponents lbSetCurSel _i;
        };
    };

    for "_i" from 0 to (lbSize _listFunctions - 1) do {
        if (_listFunctions lbText _i isEqualTo _currentFunction) exitWith {
            _listFunctions lbSetCurSel _i;
        };
    };
};

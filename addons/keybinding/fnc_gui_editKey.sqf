#include "script_component.hpp"

params ["_control"];

private _parentDisplay = ctrlParent _control;
(_control getVariable QGVAR(data)) params ["_action", "_displayName", "_keybinds", "_defaultKeybind", "_index"];

private _display = _parentDisplay createDisplay "RscDisplayConfigureAction";

// --- key lists
private _ctrlAction = _display displayCtrl IDC_CONFIGURE_ACTION_TITLE;
private _ctrlKeyList = _display displayCtrl IDC_CONFIGURE_ACTION_KEYS;
private _ctrlSpecialKeyList = _display displayCtrl IDC_CONFIGURE_ACTION_SPECIAL;

_ctrlAction ctrlSetText _displayName;

{
    _ctrlKeyList lbSetData [_ctrlKeyList lbAdd (_x call CBA_fnc_localizeKey), str _x];
} forEach _keybinds;

_ctrlKeyList setVariable [QGVAR(index), _index];
_ctrlKeyList setVariable [QGVAR(action), _action];
_ctrlKeyList setVariable [QGVAR(undoKeybinds), _keybinds];
_ctrlKeyList setVariable [QGVAR(defaultKeybind), _defaultKeybind];

// --- record keys
_display displayAddEventHandler ["KeyDown", {
    call {
        params ["_display", "_key", "_shift", "_control", "_alt"];
        private _ctrlKeyList = _display displayCtrl IDC_CONFIGURE_ACTION_KEYS;

        if (_key <= DIK_ESCAPE) exitWith {false};
        if (_key in [DIK_LSHIFT, DIK_RSHIFT, DIK_LCONTROL, DIK_RCONTROL, DIK_LMENU, DIK_RMENU]) exitWith {true};
        if (!isNil {_ctrlKeyList getVariable QGVAR(lock)}) exitWith {true};

        private _keybind = [_key, [_shift, _control, _alt]];
        private _keyName = _keybind call CBA_fnc_localizeKey;

        // if key already in list, remove instead
        private _doAdd = true;

        for "_index" from 0 to (lbSize _ctrlKeyList - 1) do {
            if (_ctrlKeyList lbData _index == str _keybind) exitWith {
                _ctrlKeyList lbDelete _index;
                _doAdd = false;
            };
        };

        if (_doAdd) then {
            private _index = _ctrlKeyList lbAdd _keyName;
            _ctrlKeyList lbSetData [_index, str _keybind];
            _ctrlKeyList lbSetCurSel _index;
        };

        _ctrlKeyList call (_ctrlKeyList getVariable QFUNC(showDuplicates));

        _ctrlKeyList setVariable [QGVAR(lock), true];
        true
    };
}];

_display displayAddEventHandler ["KeyUp", {
    params ["_display", "_key"];
    private _ctrlKeyList = _display displayCtrl IDC_CONFIGURE_ACTION_KEYS;

    if (_key in [DIK_LSHIFT, DIK_RSHIFT, DIK_LCONTROL, DIK_RCONTROL, DIK_LMENU, DIK_RMENU]) exitWith {};

    _ctrlKeyList setVariable [QGVAR(lock), nil];
}];

// --- special binds not handled by keydown
private _specialKeys = [
    [DIK_LSHIFT, [true, false, false]],
    [DIK_RSHIFT, [true, false, false]],
    [DIK_LCONTROL, [false, true, false]],
    [DIK_RCONTROL, [false, true, false]],
    [DIK_LMENU, [false, false, true]],
    [DIK_RMENU, [false, false, true]]
];

{
    for "_keyCode" from 0xF0 to 0xF9 do {
        _specialKeys pushBack [_keyCode, _x];
    };
} forEach [
    [false, false, false],
    [true, false, false],
    [false, true, false],
    [false, false, true],
    [true, true, false],
    [true, false, true],
    [false, true, true],
    [true, true, true]
];

_specialKeys append [
    [USER_1, [false, false, false]],
    [USER_2, [false, false, false]],
    [USER_3, [false, false, false]],
    [USER_4, [false, false, false]],
    [USER_5, [false, false, false]],
    [USER_6, [false, false, false]],
    [USER_7, [false, false, false]],
    [USER_8, [false, false, false]],
    [USER_9, [false, false, false]],
    [USER_10, [false, false, false]],
    [USER_11, [false, false, false]],
    [USER_12, [false, false, false]],
    [USER_13, [false, false, false]],
    [USER_14, [false, false, false]],
    [USER_15, [false, false, false]],
    [USER_16, [false, false, false]],
    [USER_17, [false, false, false]],
    [USER_18, [false, false, false]],
    [USER_19, [false, false, false]],
    [USER_20, [false, false, false]]
];

{
    _ctrlSpecialKeyList lbSetData [_ctrlSpecialKeyList lbAdd (_x call CBA_fnc_localizeKey), str _x];
} forEach _specialKeys;

// add special key if dropped on keylist
_ctrlKeyList ctrlAddEventHandler ["LBDrop", {
    params ["_ctrlKeyList", "", "", "_originIDC", "_info"];
    (_info select 0) params ["_text", "_value", "_data"];

    if (ctrlIDC _ctrlKeyList == _originIDC) exitWith {};

    // if special key already in list, remove instead
    private _doAdd = true;

    for "_index" from 0 to (lbSize _ctrlKeyList - 1) do {
        if (_ctrlKeyList lbData _index == _data) exitWith {
            _ctrlKeyList lbDelete _index;
            _doAdd = false;
        };
    };

    if (_doAdd) then {
        private _index = _ctrlKeyList lbAdd _text;
        _ctrlKeyList lbSetData [_index, _data];
        _ctrlKeyList lbSetCurSel _index;
    };

    _ctrlKeyList call (_ctrlKeyList getVariable QFUNC(showDuplicates));
}];

// remove item from keylist if dropped into special keylist
_ctrlSpecialKeyList ctrlAddEventHandler ["LBDrop", {
    params ["_ctrlSpecialKeyList", "", "", "_originIDC", "_info"];
    (_info select 0) params ["_text", "_value", "_data"];

    if (ctrlIDC _ctrlSpecialKeyList == _originIDC) exitWith {};

    private _ctrlKeyList = ctrlParent _ctrlSpecialKeyList displayCtrl _originIDC;

    for "_index" from 0 to (lbSize _ctrlKeyList - 1) do {
        if (_ctrlKeyList lbData _index == _data) exitWith {
            _ctrlKeyList lbDelete _index;
        };
    };

    _ctrlKeyList call (_ctrlKeyList getVariable QFUNC(showDuplicates));
}];

// make preview show up as green if target lb is different from origin lb
private _fnc_dragging = {
    params ["_control", "", "", "_originIDC"];
    ctrlIDC _control != _originIDC
};

_ctrlKeyList ctrlAddEventHandler ["LBDragging", _fnc_dragging];
_ctrlSpecialKeyList ctrlAddEventHandler ["LBDragging", _fnc_dragging];

// --- OK
private _ctrlButtonOK = _display displayCtrl IDC_OK;

private _fnc_save = {
    params ["_control"];
    private _display = ctrlParent _control;

    private _ctrlKeyList = _display displayCtrl IDC_CONFIGURE_ACTION_KEYS;

    private _keybinds = [];

    for "_index" from 0 to (lbSize _ctrlKeyList - 1) do {
        _keybinds pushBack parseSimpleArray (_ctrlKeyList lbData _index);
    };

    private _action = _ctrlKeyList getVariable QGVAR(action);
    private _tempNamespace = uiNamespace getVariable QGVAR(tempKeybinds);

    _tempNamespace setVariable [_action, _keybinds];
};

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_save];

// --- cancel
private _ctrlButtonCancel = _display displayCtrl IDC_CONFIGURE_ACTION_CANCEL;

_ctrlButtonCancel ctrlAddEventHandler ["ButtonClick", {
    params ["_control"];
    private _display = ctrlParent _control;

    _display closeDisplay IDC_CANCEL;
}];

// --- show previous or next button
private _ctrlButtonPrev = _display displayCtrl IDC_CONFIGURE_ACTION_PREV;
private _ctrlButtonNext = _display displayCtrl IDC_CONFIGURE_ACTION_NEXT;

_ctrlButtonPrev ctrlAddEventHandler ["ButtonClick", _fnc_save];
_ctrlButtonNext ctrlAddEventHandler ["ButtonClick", _fnc_save];

_ctrlButtonPrev ctrlAddEventHandler ["ButtonClick", {
    _this spawn {
        isNil {
            params ["_control"];
            private _display = ctrlParent _control;
            private _parentDisplay = displayParent _display;

            private _ctrlActionList = _parentDisplay displayCtrl IDC_KEY_LIST;
            private _ctrlAction = _display displayCtrl IDC_CONFIGURE_ACTION_TITLE;
            private _ctrlKeyList = _display displayCtrl IDC_CONFIGURE_ACTION_KEYS;

            private _index = (_ctrlKeyList getVariable QGVAR(index)) - 1;
            private _subcontrols = _ctrlActionList getVariable QGVAR(KeyListEditableSubcontrols);

            if (_index < 0) then {
                _index = count _subcontrols - 1
            };

            _subcontrols select _index controlsGroupCtrl IDC_KEY_EDIT getVariable QGVAR(data) params [
                "_action", "_displayName", "_keybinds", "_defaultKeybind"
            ];

            private _tempNamespace = uiNamespace getVariable QGVAR(tempKeybinds);
            _keybinds = _tempNamespace getVariable [_action, _keybinds];

            // update list with new keybinds
            _ctrlAction ctrlSetText _displayName;

            lbClear _ctrlKeyList;

            {
                _ctrlKeyList lbSetData [_ctrlKeyList lbAdd (_x call CBA_fnc_localizeKey), str _x];
            } forEach _keybinds;

            _ctrlKeyList setVariable [QGVAR(index), _index];
            _ctrlKeyList setVariable [QGVAR(action), _action];
            _ctrlKeyList setVariable [QGVAR(undoKeybinds), _keybinds];
            _ctrlKeyList setVariable [QGVAR(defaultKeybind), _defaultKeybind];

            _ctrlKeyList call (_ctrlKeyList getVariable QFUNC(showDuplicates));
        };
    };
}];

_ctrlButtonNext ctrlAddEventHandler ["ButtonClick", {
    _this spawn {
        isNil {
            params ["_control"];
            private _display = ctrlParent _control;
            private _parentDisplay = displayParent _display;

            private _ctrlActionList = _parentDisplay displayCtrl IDC_KEY_LIST;
            private _ctrlAction = _display displayCtrl IDC_CONFIGURE_ACTION_TITLE;
            private _ctrlKeyList = _display displayCtrl IDC_CONFIGURE_ACTION_KEYS;

            private _index = (_ctrlKeyList getVariable QGVAR(index)) + 1;
            private _subcontrols = _ctrlActionList getVariable QGVAR(KeyListEditableSubcontrols);

            if (_index >= count _subcontrols) then {
                _index = 0;
            };

            _subcontrols select _index controlsGroupCtrl IDC_KEY_EDIT getVariable QGVAR(data) params [
                "_action", "_displayName", "_keybinds", "_defaultKeybind"
            ];

            private _tempNamespace = uiNamespace getVariable QGVAR(tempKeybinds);
            _keybinds = _tempNamespace getVariable [_action, _keybinds];

            // update list with new keybinds
            _ctrlAction ctrlSetText _displayName;

            lbClear _ctrlKeyList;

            {
                _ctrlKeyList lbSetData [_ctrlKeyList lbAdd (_x call CBA_fnc_localizeKey), str _x];
            } forEach _keybinds;

            _ctrlKeyList setVariable [QGVAR(index), _index];
            _ctrlKeyList setVariable [QGVAR(action), _action];
            _ctrlKeyList setVariable [QGVAR(undoKeybinds), _keybinds];
            _ctrlKeyList setVariable [QGVAR(defaultKeybind), _defaultKeybind];

            _ctrlKeyList call (_ctrlKeyList getVariable QFUNC(showDuplicates));
        };
    };
}];

// --- misc. buttons
private _ctrlButtonDefault = _display displayCtrl IDC_CONFIGURE_ACTION_DEFAULT;
private _ctrlButtonDelete = _display displayCtrl IDC_CONFIGURE_ACTION_DELETE;
private _ctrlButtonUndo = _display displayCtrl IDC_CONFIGURE_ACTION_CLEAR;

// delete currenty selected and select last item
_ctrlButtonDelete ctrlAddEventHandler ["ButtonClick", {
    params ["_control"];
    private _ctrlKeyList = ctrlParent _control displayCtrl IDC_CONFIGURE_ACTION_KEYS;

    private _index = lbCurSel _ctrlKeyList;

    if (_index >= 0) then {
        _ctrlKeyList lbDelete _index;
        _ctrlKeyList lbSetCurSel (lbSize _ctrlKeyList - 1);
    };
}];

// clear lb and add default keybind
_ctrlButtonDefault ctrlAddEventHandler ["ButtonClick", {
    params ["_control"];
    private _ctrlKeyList = ctrlParent _control displayCtrl IDC_CONFIGURE_ACTION_KEYS;

    lbClear _ctrlKeyList;

    private _keybind = _ctrlKeyList getVariable QGVAR(defaultKeybind);

    if (_keybind select 0 > DIK_ESCAPE) then {
        _ctrlKeyList lbSetData [_ctrlKeyList lbAdd (_keybind call CBA_fnc_localizeKey), str _keybind];
    };

    _ctrlKeyList call (_ctrlKeyList getVariable QFUNC(showDuplicates));
}];

// clear lb and add current temporary keybinds
_ctrlButtonUndo ctrlAddEventHandler ["ButtonClick", {
    params ["_control"];
    private _ctrlKeyList = ctrlParent _control displayCtrl IDC_CONFIGURE_ACTION_KEYS;

    lbClear _ctrlKeyList;

    {
        _ctrlKeyList lbSetData [_ctrlKeyList lbAdd (_x call CBA_fnc_localizeKey), str _x];
    } forEach (_ctrlKeyList getVariable QGVAR(undoKeybinds));

    _ctrlKeyList call (_ctrlKeyList getVariable QFUNC(showDuplicates));
}];

// --- update parent display if this one is closed
_display displayAddEventHandler ["unload", {
    [] call FUNC(gui_update);
}];

// --- function to highlight duplicates
_ctrlKeyList setVariable [QFUNC(showDuplicates), {
    params ["_ctrlKeyList"];

    private _action = _ctrlKeyList getVariable QGVAR(action);
    private _addon = _action splitString "$" select 0;

    private _addonActions = GVAR(addons) getVariable [_addon, [nil, []]] select 1;
    private _tempNamespace = uiNamespace getVariable QGVAR(tempKeybinds);

    for "-" from 0 to (lbSize _ctrlKeyList - 1) do {
        private _keybind = parseSimpleArray (_ctrlKeyList lbData 0);
        private _keyName = _keybind call CBA_fnc_localizeKey;

        _ctrlKeyList lbDelete 0;

        private _isDuplicated = false;

        {
            private _duplicateAction = format ["%1$%2", _addon, _x];
            private _duplicateKeybinds = GVAR(actions) getVariable _duplicateAction select 2;
            _duplicateKeybinds = _tempNamespace getVariable [_duplicateAction, _duplicateKeybinds];

            if (_keybind in _duplicateKeybinds && {_action != _duplicateAction}) then {
                private _duplicateActionName = GVAR(actions) getVariable _duplicateAction select 0;

                if (isLocalized _duplicateActionName) then {
                    _duplicateActionName = localize _duplicateActionName;
                };

                _keyName = _keyName + format [" [%1]", _duplicateActionName];
                _isDuplicated = true;
            };
        } forEach _addonActions;

        private _index = _ctrlKeyList lbAdd _keyName;

        _ctrlKeyList lbSetData [_index, str _keybind];

        if (_isDuplicated) then {
            _ctrlKeyList lbSetColor [_index, [1,0,0,1]];
            _ctrlKeyList lbSetSelectColor [_index, [1,0,0,1]];
        };
    };
}];

_ctrlKeyList call (_ctrlKeyList getVariable QFUNC(showDuplicates));

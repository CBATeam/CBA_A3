#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_openLobbyManager

Description:
    Opens lobby manager in 3D editor.

Parameters:
    None

Returns:
    Nothing

Examples:
    (begin example)
        call (uiNamespace getVariable "CBA_fnc_openLobbyManager");
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
//xxx get3DENAttribute "name"

private _editor = uiNamespace getVariable "Display3DEN";
private _display = _editor createDisplay QGVAR(GroupManager);

// create list
private _ctrlSlots = _display displayCtrl IDC_LM_SLOTS;

{
    private _group = _x;
    private "_groupName";
    private _slots = [];

    {
        private _unit = _x;

        if (_unit == player || {_unit in playableUnits}) then {
            private _slotName = _unit get3DENAttribute "description" select 0 splitString SEPARATORS select 0;

            if (isNil "_groupName") then {
                _groupName = _unit get3DENAttribute "description" select 0 splitString SEPARATORS param [1, ""];
            };

            if (isNil "_slotName" || {_slotName isEqualTo ""}) then {
                _slotName = getText (configFile >> "CfgVehicles" >> typeOf _unit >> "displayName");
            };

            _slots pushBack [_slotName, _unit];
        };
    } forEach units _group;

    if (isNil "_groupName" || {_groupName isEqualTo ""}) then {
        _groupName = groupId _group;
    };

    if (count _slots > 0) then {
        private _index = _ctrlSlots lbAdd _groupName;
        _ctrlSlots lbSetData [_index, str _index];
        _ctrlSlots setVariable [str _index, _group];
    };

    {
        _x params ["_slotName", "_unit"];

        private _index = _ctrlSlots lbAdd format ["    %1", _slotName];
        _ctrlSlots lbSetData [_index, str _index];
        _ctrlSlots setVariable [str _index, _unit];
    } forEach _slots;
} forEach allGroups;

// change order buttons
private _ctrlButtonUp = _display displayCtrl IDC_LM_MOVE_UP;
private _ctrlButtonDown = _display displayCtrl IDC_LM_MOVE_DOWN;

private _fnc_buttonScript = {
    params ["_ctrlButton"];
    private _display = ctrlParent _ctrlButton;
    private _ctrlSlots = _display displayCtrl IDC_LM_SLOTS;
    private _isButtonUp = ctrlIDC _ctrlButton isEqualTo IDC_LM_MOVE_UP;

    private _currentIndex = lbCurSel _ctrlSlots;
    private _currentItem = _ctrlSlots getVariable (_ctrlSlots lbData _currentIndex); // OBJECT or GROUP

    // sort, array format [[groupIndex1, unitIndex1, listboxIndex1], [groupIndex2, unitIndex2, listboxIndex2], ...]
    // unitIndexN starts over at 0 for each new group.
    // This script makes use of the sort commands useful behavior with subarrays
    private _sort = [];
    private _groupCounter = 0;
    private _unitCounter = 0;

    for "_index" from 0 to (lbSize _ctrlSlots - 1) do {
        private _item = _ctrlSlots getVariable (_ctrlSlots lbData _index);

        // Button Up decrements position, Button Down increments position
        private _sortModifier = 0;
        if (_index isEqualTo _currentIndex) then {
            _sortModifier = _sortModifier + ([1.5, -1.5] select _isButtonUp);
        };

        if (_item isEqualType grpNull) then {
            INC(_groupCounter);
            _unitCounter = 0;

            _sort pushBack [_groupCounter + _sortModifier, _unitCounter, _index];
        } else {
            INC(_unitCounter);

            _sort pushBack [_groupCounter, _unitCounter + _sortModifier, _index];
        };
    };

    _sort sort true;

    // apply sort to list via value, with value being the index in the sorted array
    {
        _ctrlSlots lbSetValue [_x#2, _forEachIndex];
    } forEach _sort;

    lbSortByValue _ctrlSlots;

    // move cursor as well
    if (_isButtonUp) then {
        _currentIndex = (_currentIndex - 1) max 0;
    } else {
        _currentIndex = (_currentIndex + 1) min (lbSize _ctrlSlots - 1);
    };
    _ctrlSlots lbSetCurSel _currentIndex;
};

_ctrlButtonUp ctrlAddEventHandler ["ButtonClick", _fnc_buttonScript];
_ctrlButtonDown ctrlAddEventHandler ["ButtonClick", _fnc_buttonScript];

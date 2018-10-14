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
                _slotName = format ["%1: %2", _forEachIndex, getText (configFile >> "CfgVehicles" >> typeOf _unit >> "displayName")];
            };

            _unit setVariable [QGVAR(description), _slotName];

            _slots pushBack [_slotName, _unit];
        };
    } forEach units _group;

    if (isNil "_groupName" || {_groupName isEqualTo ""}) then {
        _groupName = groupId _group;
        _group setVariable [QGVAR(description), ""];
    } else {
        _group setVariable [QGVAR(description), _groupName];
    };

    private "_color";

    if (count _slots > 0) then {
        private _index = _ctrlSlots lbAdd _groupName;
        _ctrlSlots lbSetData [_index, str _index];
        _ctrlSlots setVariable [str _index, _group];

        private _side = side _group;
        if (_side isEqualTo west) exitWith {
            _color = call compile format ["[%1,%2,%3,1]", Map_BLUFOR_RGB];
            _ctrlSlots lbSetPicture [_index, "\a3\Ui_f\data\Map\Markers\NATO\b_unknown.paa"];
            _ctrlSlots lbSetPictureColor [_index, _color];
        };

        if (_side isEqualTo east) exitWith {
            _color = call compile format ["[%1,%2,%3,1]", Map_OPFOR_RGB];
            _ctrlSlots lbSetPicture [_index, "\a3\Ui_f\data\Map\Markers\NATO\o_unknown.paa"];
            _ctrlSlots lbSetPictureColor [_index, _color];
        };

        if (_side isEqualTo resistance) exitWith {
            _color = call compile format ["[%1,%2,%3,1]", Map_Independent_RGB];
            _ctrlSlots lbSetPicture [_index, "\a3\Ui_f\data\Map\Markers\NATO\n_unknown.paa"];
            _ctrlSlots lbSetPictureColor [_index, _color];
        };

        _color = call compile format ["[%1,%2,%3,1]", Map_Civilian_RGB];
        _ctrlSlots lbSetPicture [_index, "\a3\Ui_f\data\Map\Markers\NATO\n_unknown.paa"];
        _ctrlSlots lbSetPictureColor [_index, _color];
    };

    {
        _x params ["_slotName", "_unit"];

        private _index = _ctrlSlots lbAdd format ["    %1", _slotName];
        _ctrlSlots lbSetData [_index, str _index];
        _ctrlSlots setVariable [str _index, _unit];

        private _iconType = getText (configFile >> "CfgVehicles" >> typeOf _unit >> "icon");
        private _icon = getText (configFile >> "CfgVehicleIcons" >> _iconType);
        _ctrlSlots lbSetPicture [_index, _icon];
        _ctrlSlots lbSetPictureColor [_index, _color];
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
    private _currentEntity = _ctrlSlots getVariable (_ctrlSlots lbData _currentIndex); // OBJECT or GROUP

    // sort, array format [[groupIndex1, unitIndex1, listboxIndex1], [groupIndex2, unitIndex2, listboxIndex2], ...]
    // unitIndexN starts over at 0 for each new group.
    // This script makes use of the sort commands useful behavior with subarrays
    private _sort = [];
    private _groupCounter = 0;
    private _unitCounter = 0;
    private "_sortModifierGroup";

    for "_index" from 0 to (lbSize _ctrlSlots - 1) do {
        private _entity = _ctrlSlots getVariable (_ctrlSlots lbData _index);

        if (_entity isEqualType grpNull) then {
            _unitCounter = 0;
            INC(_groupCounter);

            // Button Up decrements position, Button Down increments position
            _sortModifierGroup = 0;
            if (_index isEqualTo _currentIndex) then {
                _sortModifierGroup = _sortModifierGroup + ([1.5, -1.5] select _isButtonUp);
            };

            _sort pushBack [_groupCounter + _sortModifierGroup, _unitCounter - 2, _index];
        } else {
            INC(_unitCounter);

            // Button Up decrements position, Button Down increments position
            private _sortModifierUnit = 0;
            if (_index isEqualTo _currentIndex) then {
                _sortModifierUnit = _sortModifierUnit + ([1.5, -1.5] select _isButtonUp);
            };

            _sort pushBack [_groupCounter + _sortModifierGroup, _unitCounter + _sortModifierUnit, _index];
        };
    };

    _sort sort true;

    // apply sort to list via value, with value being the index in the sorted array
    {
        _ctrlSlots lbSetValue [_x select 2, _forEachIndex];
    } forEach _sort;

    lbSortByValue _ctrlSlots;

    // select old entry
    for "_index" from 0 to (lbSize _ctrlSlots - 1) do {
        private _entity = _ctrlSlots getVariable (_ctrlSlots lbData _index);

        if (_entity isEqualTo _currentEntity) exitWith {
            _ctrlSlots lbSetCurSel _index;
        };
    };
};

_ctrlButtonUp ctrlAddEventHandler ["ButtonClick", _fnc_buttonScript];
_ctrlButtonDown ctrlAddEventHandler ["ButtonClick", _fnc_buttonScript];

// update edit boxes when listbox selection changes
_ctrlSlots ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlSlots", "_index"];
    private _display = ctrlParent _ctrlSlots;
    private _ctrlName = _display displayCtrl IDC_LM_NAME;

    private _entity = _ctrlSlots getVariable (_ctrlSlots lbData _index);
    private _description = _entity getVariable [QGVAR(description), ""];

    _ctrlName ctrlSetText ""; // reset cursor position
    _ctrlName ctrlSetText _description;
    ctrlSetFocus _ctrlName;
}];

private _ctrlName = _display displayCtrl IDC_LM_NAME;

_ctrlName ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlName"];
    private _display = ctrlParent _ctrlName;
    private _ctrlSlots = _display displayCtrl IDC_LM_SLOTS;

    private _description = ctrlText _ctrlName;
    private _index = lbCurSel _ctrlSlots;
    private _entity = _ctrlSlots getVariable (_ctrlSlots lbData _index);
    _entity setVariable [QGVAR(description), _description];

    if (_entity isEqualType objNull) then {
        _description = format ["    %1", _description];
    };

    _ctrlSlots lbSetText [_index, _description];
}];

// OK button - apply changes
private _ctrlButtonOK = _display displayCtrl IDC_OK;

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", {
    collect3DENHistory {
        params ["_ctrlButtonOK"];
        private _display = ctrlParent _ctrlButtonOK;
        private _ctrlSlots = _display displayCtrl IDC_LM_SLOTS;

        private _group = grpNull;
        private _leader = objNull;
        private _units = [];
        private _groups = [];

        private _dummies = [];
        private _dummyGroup = createGroup civilian;

        // adjust unit order
        for "_index" from 0 to (lbSize _ctrlSlots - 1) do {
            private _entity = _ctrlSlots getVariable (_ctrlSlots lbData _index);

            if (_entity isEqualType grpNull) then {
                _group = _entity;
                _leader = leader _group;
                _units = [];
                _groups pushBack _group;

                private _dummy = _dummyGroup createUnit ["C_man_1", [0,0,0], [], 0, "NONE"];
                [_dummy] joinSilent _group;
            } else {
                private _slotName = _entity getVariable QGVAR(description);
                private _groupName = _group getVariable [QGVAR(description), ""];

                if (_groupName != "") then {
                    _slotName = format ["%1@%2", _slotName, _groupName];
                };

                set3DENSelected [_entity];
                do3DENAction "CutUnit";
                do3DENAction "PasteUnitOrig";

                // new entity, old references ghost entity
                _entity = get3DENSelected "Object" select 0;

                _units pushBack _entity;
                add3DENConnection ["Group", _units, _group];
                _group selectLeader _leader;
                _entity set3DENAttribute ["description", _slotName];
            };
        };

        // adjust group order
        {
            diag_log [0, count allGroups];
            diag_log get3DENSelected "";
            diag_log ["units: ", _x, units _x];
            set3DENSelected ([_x] + units _x);diag_log ["select: ", _x];
            diag_log get3DENSelected "";
            do3DENAction "CutUnit";
            do3DENAction "PasteUnitOrig";
            diag_log [1, count allGroups];
            diag_log get3DENSelected "";
        } forEach _groups;

        {
            deleteVehicle _x;
        } forEach _dummies;
        deleteGroup _dummyGroup;

        set3DENSelected [];
    };
}];





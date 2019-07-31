#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_openLobbyManager

Description:
    Opens the Lobby Manager in 3DEN editor.

Parameters:
    None

Returns:
    Nothing

Examples:
    (begin example)
        call (uiNamespace getVariable "CBA_fnc_openLobbyManager");
    (end)

Author:
    commy2, mharis001
---------------------------------------------------------------------------- */

#define GET_PARENT_PATH(path) (path select [0, count path - 1])

private _display3DEN = uiNamespace getVariable "Display3DEN";
private _display = _display3DEN createDisplay QGVAR(LobbyManager);

private _ctrlSlots = _display displayCtrl IDC_LM_SLOTS;

// Add root level nodes to categorize groups by side
{
    private _index = _ctrlSlots tvAdd [[], localize _x];
    _ctrlSlots tvSetPicture [[_index], ICON_FOLDER];
} forEach ["STR_West", "STR_East", "STR_Guerrila", "STR_Civilian"];

// Add groups with playable units sorted by side
{
    private _group = _x;
    private _slots = [];

    {
        private _unit = _x;

        if (_unit == player || {_unit in playableUnits}) then {
            private _description = _unit get3DENAttribute "description" select 0;

            if (_description isEqualTo "") then {
                _description = format ["%1: %2", _forEachIndex + 1, getText (configFile >> "CfgVehicles" >> typeOf _unit >> "displayName")];
            };

            _unit setVariable [QGVAR(description), _description];
            _slots pushBack [_unit, _description];
        };
    } forEach units _group;

    if !(_slots isEqualTo []) then {
        private _side = side _group;
        private _sideIndex = [west, east, independent, civilian] find _side;
        private _color = [_side] call BIS_fnc_sideColor;
        private _icon = [ICON_BLUFOR, ICON_OPFOR, ICON_INDEPENDENT, ICON_CIVILIAN] select _sideIndex;

        private _callsign = groupId _group;
        _group setVariable [QGVAR(callsign), _callsign];

        _slots select 0 select 1 splitString SEPARATORS params ["", ["_groupName", ""]];

        if (_groupName isEqualTo "") then {
            _groupName = _callsign;
        };

        private _groupIndex = _ctrlSlots tvAdd [[_sideIndex], _groupName];
        private _groupPath  = [_sideIndex, _groupIndex];

        _ctrlSlots tvSetValue [_groupPath, _groupIndex];
        _ctrlSlots tvSetPicture [_groupPath, _icon];
        _ctrlSlots tvSetPictureColor [_groupPath, _color];

        private _dataID = _groupPath joinString SEPARATORS;
        _ctrlSlots tvSetData [_groupPath, _dataID];
        _ctrlSlots setVariable [_dataID, _group];

        {
            _x params ["_unit", "_description"];

            _description splitString SEPARATORS params [["_unitName", ""]];

            private _iconType = getText (configFile >> "CfgVehicles" >> typeOf _unit >> "icon");
            private _icon = getText (configFile >> "CfgVehicleIcons" >> _iconType);

            private _unitIndex = _ctrlSlots tvAdd [_groupPath, _unitName];
            private _unitPath  = [_sideIndex, _groupIndex, _unitIndex];

            _ctrlSlots tvSetValue [_unitPath, _unitIndex];
            _ctrlSlots tvSetPicture [_unitPath, _icon];
            _ctrlSlots tvSetPictureColor [_unitPath, _color];

            private _dataID = _unitPath joinString SEPARATORS;
            _ctrlSlots tvSetData [_unitPath, _dataID];
            _ctrlSlots setVariable [_dataID, _unit];
        } forEach _slots;
    };
} forEach allGroups;

// Remove sides that do not have any playable groups
for "_i" from ((_ctrlSlots tvCount []) - 1) to 0 step -1 do {
    if (_ctrlSlots tvCount [_i] == 0) then {
        _ctrlSlots tvDelete [_i];
    };
};

_ctrlSlots ctrlAddEventHandler ["TreeSelChanged", {
    params ["_ctrlSlots", "_path"];

    private _display = ctrlParent _ctrlSlots;
    private _pathCount = count _path;
    private _dataIndices = _ctrlSlots tvData _path splitString SEPARATORS;
    _dataIndices params ["_sideIndex", "_groupIndex", "_unitIndex"];

    private _ctrlCallsign = _display displayCtrl IDC_LM_CALLSIGN;
    _ctrlCallsign ctrlSetText ""; // reset cursor

    private _ctrlDescription = _display displayCtrl IDC_LM_DESCRIPTION;
    _ctrlDescription ctrlSetText ""; // reset cursor

    if (_pathCount >= 2) then {
        private _group = _ctrlSlots getVariable ([_sideIndex, _groupIndex] joinString SEPARATORS);
        _ctrlCallsign ctrlSetText (_group getVariable QGVAR(callsign));
        _ctrlCallsign setVariable [QGVAR(group), _group];

        _ctrlCallsign ctrlSetBackgroundColor [0, 0, 0, 0.5];
        _ctrlCallsign ctrlEnable true;
    } else {
        _ctrlCallsign ctrlSetBackgroundColor [0, 0, 0, 0.25];
        _ctrlCallsign ctrlEnable false;
    };

    if (_pathCount >= 3) then {
        private _unit = _ctrlSlots getVariable ([_sideIndex, _groupIndex, _unitIndex] joinString SEPARATORS);
        _ctrlDescription ctrlSetText (_unit getVariable QGVAR(description));
        _ctrlDescription setVariable [QGVAR(unit), _unit];

        _ctrlDescription ctrlSetBackgroundColor [0, 0, 0, 0.5];
        _ctrlDescription ctrlEnable true;
    } else {
        _ctrlDescription ctrlSetBackgroundColor [0, 0, 0, 0.25];
        _ctrlDescription ctrlEnable false;
    };

    if (_pathCount > 1) then {
        if (_pathCount > 2) then {
            ctrlSetFocus _ctrlDescription;
        } else {
            ctrlSetFocus _ctrlCallsign;
        };
    };
}];

private _ctrlCallsign = _display displayCtrl IDC_LM_CALLSIGN;
_ctrlCallsign ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlCallsign"];

    private _display = ctrlParent _ctrlCallsign;
    private _ctrlSlots = _display displayCtrl IDC_LM_SLOTS;
    private _path = tvCurSel _ctrlSlots;

    private _group = _ctrlCallsign getVariable QGVAR(group);
    private _callsign = ctrlText _ctrlCallsign;
    _group setVariable [QGVAR(callsign), _callsign];

    private _groupPath = _path select [0, 2];
    private _unit = _ctrlSlots getVariable (_ctrlSlots tvData (_groupPath + [0]));

    private _description = _unit getVariable QGVAR(description);
    _description splitString SEPARATORS params ["", ["_groupName", ""]];

    if (_groupName isEqualTo "") then {
        _ctrlSlots tvSetText [_groupPath, _callsign];
    };
}];

private _ctrlDescription = _display displayCtrl IDC_LM_DESCRIPTION;
_ctrlDescription ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlDescription"];

    private _display = ctrlParent _ctrlDescription;
    private _ctrlSlots = _display displayCtrl IDC_LM_SLOTS;
    private _path = tvCurSel _ctrlSlots;

    private _unit = _ctrlDescription getVariable QGVAR(unit);
    private _description = ctrlText _ctrlDescription;
    _unit setVariable [QGVAR(description), _description];

    _description splitString SEPARATORS params [["_unitName", ""], ["_groupName", ""]];
    _ctrlSlots tvSetText [_path, _unitName];

    if (_ctrlSlots tvValue _path == 0) then {
        if (_groupName isEqualTo "") then {
            _groupName = group _unit getVariable QGVAR(callsign);
        };

        _ctrlSlots tvSetText [GET_PARENT_PATH(_path), _groupName];
    };
}];

private _ctrlButtonUp = _display displayCtrl IDC_LM_MOVE_UP;
_ctrlButtonUp ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlButtonUp"];

    private _display = ctrlParent _ctrlButtonUp;
    private _ctrlSlots = _display displayCtrl IDC_LM_SLOTS;

    private _path = tvCurSel _ctrlSlots;
    private _pathCount = count _path;

    // Exit if the selected node is not a group or unit
    if (_pathCount < 2) exitWith {};

    private _value = _ctrlSlots tvValue _path;
    private _parentPath = GET_PARENT_PATH(_path);

    if (_value > 0) then {
        // Switch the values of the selected node and the node above it
        _ctrlSlots tvSetValue [_path, _value - 1];
        _path set [_pathCount - 1, _value - 1];
        _ctrlSlots tvSetValue [_path, _value];

        // Update displayed group name if necessary
        if (_pathCount == 3 && {_value == 1}) then {
            _path set [2, _value]; // Set back to modified node path

            private _unit = _ctrlSlots getVariable (_ctrlSlots tvData _path);
            private _description = _unit getVariable QGVAR(description);
            _description splitString SEPARATORS params ["", ["_groupName", ""]];

            if (_groupName isEqualTo "") then {
                _groupName = group _unit getVariable QGVAR(callsign);
            };

            _ctrlSlots tvSetText [_parentPath, _groupName];
        };

        // Trigger sorting of sibling nodes with the new values
        _ctrlSlots tvSortByValue [_parentPath, true];
    };
}];

private _ctrlButtonDown = _display displayCtrl IDC_LM_MOVE_DOWN;
_ctrlButtonDown ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlButtonDown"];

    private _display = ctrlParent _ctrlButtonDown;
    private _ctrlSlots = _display displayCtrl IDC_LM_SLOTS;

    private _path = tvCurSel _ctrlSlots;
    private _pathCount = count _path;

    // Exit if the selected node is not a group or unit
    if (_pathCount < 2) exitWith {};

    private _value = _ctrlSlots tvValue _path;
    private _parentPath = GET_PARENT_PATH(_path);

    if (_value < (_ctrlSlots tvCount _parentPath) - 1) then {
        // Switch the values of the selected node and the node below it
        _ctrlSlots tvSetValue [_path, _value + 1];
        _path set [_pathCount - 1, _value + 1];
        _ctrlSlots tvSetValue [_path, _value];

        // Update displayed group name if necessary
        if (_pathCount == 3 && {_value == 0}) then {
            private _unit = _ctrlSlots getVariable (_ctrlSlots tvData _path);
            private _description = _unit getVariable QGVAR(description);
            _description splitString SEPARATORS params ["", ["_groupName", ""]];

            if (_groupName isEqualTo "") then {
                _groupName = group _unit getVariable QGVAR(callsign);
            };

            _ctrlSlots tvSetText [_parentPath, _groupName];
        };

        // Trigger sorting of sibling nodes with the new values
        _ctrlSlots tvSortByValue [_parentPath, true];
    };
}];

private _ctrlButtonExpand = _display displayCtrl IDC_LM_EXPAND;
_ctrlButtonExpand ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlButtonExpand"];

    private _display = ctrlParent _ctrlButtonExpand;
    private _ctrlSlots = _display displayCtrl IDC_LM_SLOTS;

    tvExpandAll _ctrlSlots;
}];

private _ctrlButtonCollapse = _display displayCtrl IDC_LM_COLLAPSE;
_ctrlButtonCollapse ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlButtonCollapse"];

    private _display = ctrlParent _ctrlButtonCollapse;
    private _ctrlSlots = _display displayCtrl IDC_LM_SLOTS;

    private _fnc_collapse = {
        // Collapsing [] path causes tree to disappear
        if !(_this isEqualTo []) then {
            _ctrlSlots tvCollapse _this;
        };

        for "_i" from 0 to ((_ctrlSlots tvCount _this) - 1) do {
            _this + [_i] call _fnc_collapse;
        };
    };

    [] call _fnc_collapse;
}];

private _ctrlButtonOK = _display displayCtrl IDC_OK;
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", {
    collect3DENHistory {
        params ["_ctrlButtonOK"];

        private _display = ctrlParent _ctrlButtonOK;
        private _ctrlSlots = _display displayCtrl IDC_LM_SLOTS;

        private _groups = [];
        private _selected = [];

        // set3DENSelected takes flattened array
        {
            _selected append _x;
        } forEach get3DENSelected "";

        for "_sideIndex" from 0 to ((_ctrlSlots tvCount []) - 1) do {
            for "_groupIndex" from 0 to ((_ctrlSlots tvCount [_sideIndex]) - 1) do {
                private _groupPath = [_sideIndex, _groupIndex];
                private _group = _ctrlSlots getVariable (_ctrlSlots tvData _groupPath);
                _groups pushBack _group;

                private _leader = leader _group;
                private _multipleUnits = count units _group > 1;

                private _units = [];

                for "_unitIndex" from 0 to ((_ctrlSlots tvCount _groupPath) - 1) do {
                    private _unitPath = [_sideIndex, _groupIndex, _unitIndex];
                    private _unit = _ctrlSlots getVariable (_ctrlSlots tvData _unitPath);
                    private _description = _unit getVariable QGVAR(description);

                    set3DENSelected [_unit];

                    if (_multipleUnits) then {
                        do3DENAction "CutUnit";
                        do3DENAction "PasteUnitOrig";
                    };

                    _unit = get3DENSelected "Object" select 0;
                    _units pushBack _unit;

                    add3DENConnection ["Group", _units, _group];
                    _group selectLeader _leader;

                    _unit set3DENAttribute ["description", _description];
                };
            };
        };

        // Need frame delaying to avoid duplication bugs
        [_groups, _selected] spawn {
            params ["_groups", "_selected"];

            private _total = count _groups;
            startLoadingScreen [localize LSTRING(AdjustingGroupOrder)];

            {
                private _group = _x;
                private _callsign = _group getVariable QGVAR(callsign);

                set3DENSelected [_group];

                private _handle = 0 spawn {do3DENAction "CutUnit"};
                waitUntil {scriptDone _handle};

                private _handle = 0 spawn {do3DENAction "PasteUnitOrig"};
                waitUntil {scriptDone _handle};

                _group = get3DENSelected "Group" select 0;
                _group set3DENAttribute ["groupID", _callsign];

                progressLoadingScreen ((_forEachIndex + 1) / _total);
            } forEach _groups;

            set3DENSelected _selected;
            endLoadingScreen;
        };
    };
}];

// Open with tree fully expanded
tvExpandAll _ctrlSlots;

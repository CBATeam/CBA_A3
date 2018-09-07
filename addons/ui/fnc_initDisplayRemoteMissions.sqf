#include "script_component.hpp"
#include "\a3\ui_f\hpp\defineResinclDesign.inc" // can't have this in config, because it redefines some entries, and that makes Mikero's shits its pants

params ["_display"];
private _ctrlMissions = _display displayCtrl IDC_SERVER_MISSION;

ctrlPosition _ctrlMissions params ["_left", "_top", "_width", "_height"];

private _ctrlSearch = _display ctrlCreate ["RscEdit", IDC_SEARCH];
_ctrlSearch ctrlSetPosition [
    _left,
    _top,
    _width - GUI_GRID_W,
    GUI_GRID_H
];
_ctrlSearch ctrlCommit 0;

private _ctrlSearchButton = _display ctrlCreate ["RscButtonSearch", IDC_SEARCH_BUTTON];
_ctrlSearchButton ctrlSetPosition [
    _left + _width - GUI_GRID_W,
    _top,
    GUI_GRID_W,
    GUI_GRID_H
];
_ctrlSearchButton ctrlCommit 0;

_ctrlMissions ctrlSetPosition [
    _left,
    _top + GUI_GRID_H,
    _width,
    _height - GUI_GRID_H
];
_ctrlMissions ctrlCommit 0;

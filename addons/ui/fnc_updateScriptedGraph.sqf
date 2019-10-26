#include "script_component.hpp"

params ["_script"];
private _display = ctrlParent _script;
private _control = ctrlParentControlsGroup _script;
ctrlPosition _control params ["_left", "_top", "_width", "_height"];

// --- background
(_control getVariable ["backgroundColor", []]) params [
    ["_r", 0],
    ["_g", 0],
    ["_b", 0],
    ["_a", 1]
];

private _background = _control controlsGroupCtrl IDC_GRAPH_BACKGROUND;
_background ctrlSetPosition [0, 0, _width, _height];
_background ctrlCommit 0;
_background ctrlSetBackgroundColor [_r,_g,_b,_a];
systemChat str _background;

// --- curves
{

} forEach (_control getVariable ["curves", []]);

// --- labels
{

} forEach (_control getVariable ["labels", []]);

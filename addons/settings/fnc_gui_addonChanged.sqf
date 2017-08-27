#include "script_component.hpp"

// get button
params ["_control", "_index"];

// get dialog
private _display = ctrlParent _control;

private _selectedAddon = _display getVariable (_control lbData _index);

#include "gui_createCategory.sqf"

if (_selectedAddon isEqualType "") then {
    uiNamespace setVariable [QGVAR(addon), _selectedAddon];
};

uiNamespace setVariable [QGVAR(addonIndex), _index];

// toggle lists
private _selectedSource = uiNamespace getVariable QGVAR(source);

{
    (_x splitString "$") params ["", "_addon", "_source"];

    private _ctrlOptionsGroup = _display getVariable _x;
    private _isSelected = _source == _selectedSource && {_addon == _selectedAddon};

    _ctrlOptionsGroup ctrlEnable _isSelected;
    _ctrlOptionsGroup ctrlShow _isSelected;
} forEach (_display getVariable QGVAR(lists));

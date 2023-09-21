#include "script_component.hpp"

// get button
params ["_control", "_index"];

// get dialog
private _display = ctrlParent _control;

private _selectedAddon = _display getVariable (_control lbData _index);

// fix error when no addons present
if (isNil "_selectedAddon") exitWith {};

if (_selectedAddon isEqualType "") then {
    uiNamespace setVariable [QGVAR(addon), _selectedAddon];
};

uiNamespace setVariable [QGVAR(addonIndex), _index];

// toggle lists
private _selectedSource = uiNamespace getVariable QGVAR(source);

if !(_display getVariable [_selectedAddon, false]) then {
    [_display, _selectedAddon] call FUNC(gui_createCategory);
    _display setVariable [_selectedAddon, true];
};

{
    (_x splitString "$") params ["", "_addon", "_source"];

    private _ctrlOptionsGroup = _display getVariable _x;
    private _isSelected = _source == _selectedSource && {_addon == _selectedAddon};

    _ctrlOptionsGroup ctrlEnable _isSelected;
    _ctrlOptionsGroup ctrlShow _isSelected;
} forEach (_display getVariable QGVAR(lists));

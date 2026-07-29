#include "script_component.hpp"

EXIT_LOCKED;

// get button
params ["_control", "_index"];

// get dialog
private _display = ctrlParent _control;

private _selectedAddon = _control lbData _index;

// fix error when no addons present
if (_selectedAddon isEqualTo "") exitWith {};

uiNamespace setVariable [QGVAR(addon), _selectedAddon];

// toggle lists
private _selectedSource = uiNamespace getVariable QGVAR(source);

private _created = [QGVAR(created), _selectedAddon] joinString "$";

if !(_display getVariable [_created, false]) then {
    [_display, _selectedAddon] call FUNC(gui_createCategory);
    _display setVariable [_created, true];
};

{
    (_x splitString "$") params ["", "_addon", "_source"];

    private _ctrlOptionsGroup = _display getVariable _x;
    private _isSelected = _source == _selectedSource && {_addon == _selectedAddon};

    _ctrlOptionsGroup ctrlEnable _isSelected;
    _ctrlOptionsGroup ctrlShow _isSelected;
} forEach (_display getVariable QGVAR(lists));

// the category may have just been created, or created while a different search was active
[_display] call FUNC(gui_filterSettings);

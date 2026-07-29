#include "script_component.hpp"

EXIT_LOCKED;

// get button
params ["_control", "_index"];

// get dialog
private _display = ctrlParent _control;

private _selectedAddon = _control lbData _index;

// fix error when no addons present
if (_selectedAddon isEqualTo "") exitWith {};

// commit anything half typed before the rows are pointed somewhere else
ctrlSetFocus _control;

uiNamespace setVariable [QGVAR(addon), _selectedAddon];

private _optionsGroups = _display getVariable QGVAR(optionsGroups);

if !(_selectedAddon in _optionsGroups) then {
    [_display, _selectedAddon] call FUNC(gui_createCategory);
};

// toggle lists
{
    private _isSelected = _x isEqualTo _selectedAddon;

    (_optionsGroups get _x) ctrlEnable _isSelected;
    (_optionsGroups get _x) ctrlShow _isSelected;
} forEach (keys _optionsGroups);

// the category was built for whichever source was shown when it was created
call FUNC(gui_refresh);

// the category may have just been created, or created while a different search was active
[_display] call FUNC(gui_filterSettings);

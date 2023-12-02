#include "script_component.hpp"

params ["_display", "_searchbar"];

private _searchString = ctrlText _searchbar;
if (_searchString != "") then {
    _searchString = _searchString regexReplace ["[.?*+^$[\]\\(){}|-]/gio", "\\$&"]; // escape any user regex characters
    _searchString = ".*?" + (_searchString splitString " " joinString ".*?") + ".*?/io";
};

private _ctrlAddonList = _display displayCtrl IDC_ADDONS_LIST;

private _selectedAddon = _ctrlAddonList lbText lbCurSel _ctrlAddonList;
if (_selectedAddon == "") then {
    _selectedAddon = _ctrlAddonList lbText 0;
};

private _lastSearchString = _display getVariable [QGVAR(addonSearchString), ""];
if (_lastSearchString != "" && {_lastSearchString isNotEqualTo _searchString}) then {
    [_display, _ctrlAddonList] call FUNC(gui_addonList_fillList);
};

_display setVariable [QGVAR(addonSearchString), _searchString];

if (_searchString == "") exitWith {
    _ctrlAddonList lbSetCurSel 0;
};

private _currentDisplayName = "";

// Go through all items in list and see if they need to be deleted or not
for "_lbIndex" from (lbSize _ctrlAddonList - 1) to 0 step -1 do {
    _currentDisplayName = _ctrlAddonList lbText _lbIndex;

    if !(_currentDisplayName regexMatch _searchString) then {
        _ctrlAddonList lbDelete _lbIndex;
    };
};

// Try to select previously selected item again
private _index = 0;
for "_lbIndex" from 0 to (lbSize _ctrlAddonList - 1) do {
    if ((_ctrlAddonList lbText _lbIndex) == _selectedAddon) exitWith {
        _index = _lbIndex;
    };
};

_ctrlAddonList lbSetCurSel _index;

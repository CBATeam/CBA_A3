#include "script_component.hpp"

params ["_display", "_ctrlAddonList"];

if (lbSize _ctrlAddonList > 0) then {
    for "_i" from (lbSize _ctrlAddonList - 1) to 0 step -1 do {
        _ctrlAddonList lbDelete _i;
    };
};

private _categories = [];
{
    (GVAR(default) getVariable _x) params ["", "", "", "", "_category"];

    if !(_category in _categories) then {
        private _categoryLocalized = _category;
        if (isLocalized _category) then {
            _categoryLocalized = localize _category;
        };

        private _index = _ctrlAddonList lbAdd _categoryLocalized;
        _ctrlAddonList lbSetData [_index, str _index];
        _display setVariable [str _index, _category];

        _categories pushBack _category;
    };
} forEach GVAR(allSettings);

lbSort _ctrlAddonList;

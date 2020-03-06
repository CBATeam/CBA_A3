#include "script_component.hpp"

params ["_display"];

private _groundItems = _display displayCtrl IDC_FG_GROUND_ITEMS;
private _containerItems = _display displayCtrl IDC_FG_CHOSEN_CONTAINER;
private _uniformItems = _display displayCtrl IDC_FG_UNIFORM_CONTAINER;
private _vestItems = _display displayCtrl IDC_FG_VEST_CONTAINER;
private _backpackItems = _display displayCtrl IDC_FG_BACKPACK_CONTAINER;

_groundItems setVariable [QGVAR(containerType), "GROUND"];
_containerItems setVariable [QGVAR(containerType), "CONTAINER"];
_uniformItems setVariable [QGVAR(containerType), "UNIFORM"];
_vestItems setVariable [QGVAR(containerType), "VEST"];
_backpackItems setVariable [QGVAR(containerType), "BACKPACK"];

private _fnc_selected = {
    params ["_control", "_index"];
    private _unit = call CBA_fnc_currentUnit;

    private _container = objNull;
    private _containerType = _control getVariable QGVAR(containerType);
    switch _containerType do {
        case "GROUND": {
            _container = GVAR(CurrentGroundItemHolder);
        };
        case "CONTAINER": {
            _container = GVAR(CurrentContainer);
        };
        case "UNIFORM": {
            _container = uniformContainer _unit;
        };
        case "VEST": {
            _container = vestContainer _unit;
        };
        case "BACKPACK": {
            _container = backpackContainer _unit;
        };
    };

    // Reports classname, but only for magazines.
    private _classname = _control lbData _index;
    if (_classname isEqualTo "") then {
        // For weapons, items and glasses, use the display name to guess the classname.
        private _displayName = _control lbText _index;

        private _items = weaponCargo _container + itemCargo _container;
        private _index = _items findIf {
            _displayName isEqualTo getText (_x call CBA_fnc_getItemConfig >> "displayName");
        };

        _classname = _items param [_index, ""];
    };

    systemChat str [_containerType, _index, _classname];
};

_groundItems ctrlAddEventHandler ["lbDblClick", _fnc_selected];
_containerItems ctrlAddEventHandler ["lbDblClick", _fnc_selected];
_uniformItems ctrlAddEventHandler ["lbDblClick", _fnc_selected];
_vestItems ctrlAddEventHandler ["lbDblClick", _fnc_selected];
_backpackItems ctrlAddEventHandler ["lbDblClick", _fnc_selected];

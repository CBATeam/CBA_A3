#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: cba_ui_fnc_getInventoryClassname

Description:
    Opens the item context menu on the inventory screen.

Parameters:
    _control - RscDisplayInventory control <CONTROL>
    _index   - Item index <NUMBER>

Returns:
    _classname, _container, _containerType

Examples:
    (begin example)
        [_groundContainer, 5] call cba_ui_fnc_getInventoryClassname;
    (end)

Author:
    commy2, SynixeBrett
---------------------------------------------------------------------------- */

params ["_control", "_index"];

private _unit = call CBA_fnc_currentUnit;

private _container = objNull;
private _containerType = _control getVariable QGVAR(containerType);
switch _containerType do {
    case "GROUND": {
        _container = GVAR(CurrentGroundItemHolder);
    };
    case "CARGO": {
        _container = GVAR(CurrentContainer);
    };
    case "UNIFORM_CONTAINER": {
        _container = uniformContainer _unit;
    };
    case "VEST_CONTAINER": {
        _container = vestContainer _unit;
    };
    case "BACKPACK_CONTAINER": {
        _container = backpackContainer _unit;
    };
};

// Reports classname, but only for magazines.
private _classname = _control lbData _index;
if (_classname isEqualTo "") then {
    // For weapons, items and glasses, use the lb index and compare with cargo item list.
    private _cargoItems = weaponCargo _container + itemCargo _container + magazineCargo _container;
    _cargoItems = _cargoItems arrayIntersect _cargoItems;

    _classname = _cargoItems param [_index, ""];
};

[_classname, _container, _containerType]

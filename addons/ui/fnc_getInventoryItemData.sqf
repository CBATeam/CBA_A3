#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: cba_ui_fnc_getInventoryItemData

Description:
    Returns item data from inventory display control

Parameters:
    _control - RscDisplayInventory control <CONTROL>
    _index   - Item index <NUMBER>

Returns:
    _classname, _container, _containerType

Examples:
    (begin example)
        [_groundContainer, 5] call cba_ui_fnc_getInventoryItemData;
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

// Reports classname for every item type except backpacks (https://feedback.bistudio.com/T183096)
private _classname = _control lbData _index;

[_classname, _container, _containerType]

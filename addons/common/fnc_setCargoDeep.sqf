#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_setCargoDeep
Description:
    Sets the full inventory of a given object.

Parameters:
    _object    - Object to set the inventory of <OBJECT>
    _inventory - Inventory data in format of getCargoDeep <ARRAY>

Returns:
    None

Examples
    (begin example)
        [cursorObject, [...]] call CBA_fnc_setCargoDeep
    (end)

Author:
    DartRuffian
---------------------------------------------------------------------------- */

params [
    ["_object", objNull, [objNull]],
    ["_inventory", [], [[]], 4]
];
TRACE_2("fnc_setCargoDeep",_object,_inventory);

if (isNull _object || _inventory isEqualTo []) exitWith {};
_inventory params ["_weapons", "_magazines", "_items", "_containers"];

clearWeaponCargoGlobal _object;
clearMagazineCargoGlobal _object;
clearItemCargoGlobal _object;
clearBackpackCargoGlobal _object;

{
    _object addWeaponWithAttachmentsCargoGlobal _x;
} forEach _weapons;

{
    // Global effect, despite not being in the name
    _object addMagazineAmmoCargo _x;
} forEach _magazines;

{
    // Global effect, despite not being in the name
    _object addMagazineAmmoCargo _x;
} forEach _magazines;

{
    _object addItemCargoGlobal _x;
} forEach _items;

// Not an easy way to get the given container object after being added
// Instead we have to track them ourselves and poll everyContainer
private _trackedContainers = [];
{
    _x params ["_class", "_type", "_containerInventory"];
    if (_type == "Backpack") then {
        _object addBackpackCargoGlobal [_class, 1];
    } else {
        _object addItemCargoGlobal [_class, 1];
    };

    private _containers = (everyContainer _object) select {
        !((_x select 1) in _trackedContainers);
    };

    if (count _containers > 1) then {
        WARNING_1("More than one counter found, assuming first container: _containers='%1'",_containers);
    };
    private _newContainer = (_containers param [0, []]) param [1, objNull];
    if (isNull _newContainer) then {
        ERROR_2("Could not find new container: _containers=%1, _trackedContainers=%2",_containers,_trackedContainers);
        continue;
    };

    _trackedContainers pushBack _newContainer;
    [_newContainer, _containerInventory] call CBA_fnc_setCargoDeep;
} forEach _containers;

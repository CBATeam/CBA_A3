/* ----------------------------------------------------------------------------
Function: CBA_fnc_addItemCargo

Description:
    Add item(s) to vehicle cargo.

    Function which verifies existence of _item and _container, returns false in case
    of trouble, or when able to add _item to _container true in case of success.

Parameters:
    _container - the vehicle <OBJECT>
    _item      - name of item <STRING>
    _count     - number of weapons to add <NUMBER> (Default: 1)
    _verify    - if true, then put item on the ground if it can't be added <BOOLEAN>

Returns:
    true on success, false otherwise <BOOLEAN>

Examples:
    (begin example)
        // Add one laser designator to the cargo of SomeTruck
        _result = [SomeTruck, "FirstAidKit"] call CBA_fnc_addItemCargo

        // Add two MXC rifles to MyAPC. If the inventory is full, then put the rest on the ground
        _result = [MyAPC, "LaserDesignator", 2, true] call CBA_fnc_addItemCargo
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(addItemCargo);

params [["_container", objNull, [objNull]], ["_item", "", [""]], ["_count", 1, [0]], ["_verify", false, [false]]];

private _return = false;

if (isNull _container) exitWith {
    TRACE_2("Container not Object or null",_container,_item);
    _return
};

if (_item isEqualTo "") exitWith {
    TRACE_2("Item not String or empty",_container,_item);
    _return
};

private _config = _item call CBA_fnc_getItemConfig;

if (isNull _config || {getNumber (_config >> "scope") < 1}) exitWith {
    TRACE_2("Item not exist in Config",_container,_item);
    _return
};

if (_verify) then {
    if (_container canAdd [_item, _count]) then {
        _container addItemCargoGlobal [_item, _count];
        _return = true;
    } else {
        while {_container canAdd _item && {_count > 0}} do {
            _container addItemCargoGlobal [_item, 1];
            _count = _count - 1;
        };

        private _weaponHolder = nearestObject [_container, "WeaponHolder"];

        if (isNull _weaponHolder || {_container distance _weaponHolder > 2}) then {
            _weaponHolder = createVehicle ["GroundWeaponHolder", [0, 0, 0], [], 0, "NONE"];
            _weaponHolder setPosATL (getPosATL _container vectorAdd [random 2 - 1, random 2 - 1, 0]);
        };

        _weaponHolder addItemCargoGlobal [_item, _count];
    };
} else {
    _container addItemCargoGlobal [_item, _count];
    _return = true;
};

_return

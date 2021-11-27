#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_addMagazine

Description:
    Add magazine to a vehicle/unit.

    The function also verifies existence of _item and _unit, returns false in
    case of trouble, or true when able to add _item to _unit.

Parameters:
    _unit   - the unit or vehicle <OBJECT>
    _item   - name of the magazine to add <STRING>
    _ammo   - ammo count <NUMBER>
    _verify - if true, then put item on the ground if it can't be added <BOOLEAN>

Returns:
    true on success, false otherwise <BOOLEAN>

Examples:
    (begin example)
        _result = [player, "SmokeShell"] call CBA_fnc_addMagazine
    (end)

Author:

---------------------------------------------------------------------------- */
SCRIPT(addMagazine);

params [["_unit", objNull, [objNull]], ["_item", "", [""]], ["_ammo", -1, [0]], ["_verify", false, [false]]];

private _return = false;

if (isNull _unit) exitWith {
    TRACE_2("Unit not Object or null",_unit,_item);
    _return
};

if (_item isEqualTo "") exitWith {
    TRACE_2("Item not String or empty",_unit,_item);
    _return
};

private _config = configFile >> "CfgMagazines" >> _item;

if (!isClass _config || {getNumber (_config >> "scope") < 2}) exitWith {
    TRACE_2("Item does not exist in Config",_unit,_item);
    _return
};

if (_verify) then {
    if (_unit canAdd _item || {[_unit, _item, 1, true, true, true] call CBA_fnc_canAddItem}) then { // canAdd works for vehicles and units, CBA_fnc_canAddItem is more precise for units, but only try if canAdd fails for them
        if (_ammo < 0) then {
            _unit addMagazine [_item, 1E6]; // addMagazine STRING is not synched when used on remote units. addMagazine ARRAY is.
        } else {
            _unit addMagazine [_item, _ammo];
        };

        _return = true;
    } else {
        private _vehicleUnit = vehicle _unit;
        if (_vehicleUnit isEqualTo _unit) then {
            _unit switchMove "ainvpknlmstpslaywrfldnon_1";

            private _weaponHolder = nearestObject [_unit, "WeaponHolder"];

            if (isNull _weaponHolder || {_unit distance _weaponHolder > 2}) then {
                _weaponHolder = createVehicle ["GroundWeaponHolder", [0,0,0], [], 0, "NONE"];
                _weaponHolder setPosASL getPosASL _unit;
            };

            _return = [_weaponHolder, _item, 1, _verify, _ammo] call CBA_fnc_addMagazineCargo;
        } else {
            _return = [_vehicleUnit, _item, 1, _verify, _ammo] call CBA_fnc_addMagazineCargo;
        };
    };
} else {
    if (_ammo < 0) then {
        _unit addMagazine [_item, 1E6]; // addMagazine STRING is not synched when used on remote units. addMagazine ARRAY is.
    } else {
        _unit addMagazine [_item, _ammo];
    };

    _return = true;
};

_return

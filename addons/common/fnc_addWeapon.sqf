/* ----------------------------------------------------------------------------
Function: CBA_fnc_addWeapon

Description:
    Add a weapon to a unit. Unit has to be local.

    Function which verifies existence of _item and _unit, returns false in
    case of trouble, or when able to add _item to _unit true in case of success.

Parameters:
    _unit   - the unit <OBJECT>
    _item   - name of the weapon to add <STRING>
    _verify - if true, then put item on the ground if it can't be added <BOOLEAN>

Returns:
    true on success, false otherwise <BOOLEAN>

Examples:
    (begin example)
        _result = [player, "Binocular"] call CBA_fnc_addWeapon
    (end)

Author:

---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(addWeapon);

#define TYPE_RIFLE 1
#define TYPE_PISTOL 2
#define TYPE_LAUNCHER 4
#define TYPE_BINOCULAR 4096

params [["_unit", objNull, [objNull]], ["_item", "", [""]], ["_verify", false, [false]]];

private _return = false;

if (isNull _unit) exitWith {
    TRACE_2("Unit not Object or null",_unit,_item);
    _return
};

if (_item isEqualTo "") exitWith {
    TRACE_2("Item not String or empty",_unit,_item);
    _return
};

private _config = configFile >> "CfgWeapons" >> _item;

if (!isClass _config || {getNumber (_config >> "scope") < 1}) exitWith {
    TRACE_2("Item does not exist in Config",_unit,_item);
    _return
};

if (_verify) then {
    private _canAdd = false;

    switch (getNumber (_config >> "type")) do {
        case (TYPE_RIFLE): {
            _canAdd = primaryWeapon _unit isEqualTo "";
        };
        case (TYPE_PISTOL): {
            _canAdd = handgunWeapon _unit isEqualTo "";
        };
        case (TYPE_LAUNCHER): {
            _canAdd = secondaryWeapon _unit isEqualTo "";
        };
        case (TYPE_BINOCULAR): {
            _canAdd = binocular _unit isEqualTo "";
        };
    };

    if (_canAdd) then {
        _unit addWeapon _item;
        _return = true;
    } else {
        _unit switchMove "ainvpknlmstpslaywrfldnon_1";

        private _weaponHolder = nearestObject [_unit, "WeaponHolder"];

        if (isNull _weaponHolder || {_unit distance _weaponHolder > 2}) then {
            _weaponHolder = createVehicle ["GroundWeaponHolder", [0,0,0], [], 0, "NONE"];
            _weaponHolder setPosASL getPosASL _unit;
        };

        [_weaponHolder, _item] call CBA_fnc_addWeaponCargo;
    };
} else {
    _unit addWeapon _item;
    _return = true;
};

_return

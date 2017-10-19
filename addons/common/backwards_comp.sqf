["CBA_fnc_createCenter", {
    WARNING('Deprecated function used: CBA_fnc_createCenter');
    params ["_side"];
    _side
}] call CBA_fnc_compileFinal;

["CBA_fnc_locked", {
    WARNING('Deprecated function used: CBA_fnc_locked (new: locked)');
    locked _this > 1
}] call CBA_fnc_compileFinal;

["CBA_fnc_getPistol", {
    WARNING('Deprecated function used: CBA_fnc_getPistol (new: handgunWeapon)');
    params [["_unit", objNull, [objNull]]];
    handgunWeapon _unit
}] call CBA_fnc_compileFinal;

["CBA_fnc_systemChat", {
    WARNING('Deprecated function used: CBA_fnc_systemChat (new: systemChat)');
    params [["_message", "", [""]]];
    systemChat _message;
}] call CBA_fnc_compileFinal;

["CBA_fnc_defaultParam", {
    WARNING('Deprecated function used: CBA_fnc_defaultParam (new: param)');
    params [["_params", []], ["_index", -1, [0]], "_defaultValue"];
    if (_index < 0) exitWith {_defaultValue};
    _params param [_index, _defaultValue]
}] call CBA_fnc_compileFinal;

["CBA_fnc_addWeaponCargoGlobal", {
    WARNING('Deprecated function used: CBA_fnc_addWeaponCargoGlobal (new: CBA_fnc_addWeaponCargo)');
    _this call CBA_fnc_addWeaponCargo;
}] call CBA_fnc_compileFinal;

["CBA_fnc_addMagazineCargoGlobal", {
    WARNING('Deprecated function used: CBA_fnc_addMagazineCargoGlobal (new: CBA_fnc_addMagazineCargo)');
    _this call CBA_fnc_addMagazineCargo;
}] call CBA_fnc_compileFinal;

["CBA_fnc_removeWeaponCargoGlobal", {
    WARNING('Deprecated function used: CBA_fnc_removeWeaponCargoGlobal (new: CBA_fnc_removeWeaponCargo)');
    _this call CBA_fnc_removeWeaponCargo;
}] call CBA_fnc_compileFinal;

["CBA_fnc_removeMagazineCargoGlobal", {
    WARNING('Deprecated function used: CBA_fnc_removeMagazineCargoGlobal (new: CBA_fnc_removeMagazineCargo)');
    _this call CBA_fnc_removeMagazineCargo;
}] call CBA_fnc_compileFinal;

["CBA_fnc_removeItemCargoGlobal", {
    WARNING('Deprecated function used: CBA_fnc_removeItemCargoGlobal (new: CBA_fnc_removeItemCargo)');
    _this call CBA_fnc_removeItemCargo;
}] call CBA_fnc_compileFinal;

["CBA_fnc_removeBackpackCargoGlobal", {
    WARNING('Deprecated function used: CBA_fnc_removeBackpackCargoGlobal (new: CBA_fnc_removeBackpackCargo)');
    _this call CBA_fnc_removeBackpackCargo;
}] call CBA_fnc_compileFinal;

[QFUNC(directCall), {
    WARNING('Deprecated function used: FUNC(directCall) (new: CBA_fnc_directCall)');
    params ["_params", "_code"];
    [_code, _params] call CBA_fnc_directCall;
}] call CBA_fnc_compileFinal;

["CBA_fnc_intToString", {
    WARNING('Deprecated function used: CBA_fnc_intToString (new: str)');
    params [["_int", nil, [0]]];
    if (isNil "_int") exitWith {""};
    str _int
}] call CBA_fnc_compileFinal;

["CBA_fnc_inArea", {
    WARNING('Deprecated function used: CBA_fnc_inArea (new: inArea)');
    params ["_position", ["_zRef", objNull, ["", objNull, locationNull, []], 5]];

    _position = _position call CBA_fnc_getPos;
    _position inArea _zRef;
}] call CBA_fnc_compileFinal;

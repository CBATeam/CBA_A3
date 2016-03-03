
CBA_fnc_createCenter = {_this};
CBA_fnc_players = {allPlayers};
CBA_fnc_locked = {locked _this > 1};

CBA_fnc_getPistol = {
    params [["_unit", objNull, [objNull]]];
    handgunWeapon _unit
};

CBA_fnc_systemChat = {
    params [["_message", "", [""]]];
    systemChat _message;
};

CBA_fnc_defaultParam = {
    params [["_params", []], ["_index", -2, [0]], "_defaultValue"];
    _params param [_index, _defaultValue]
};

CBA_fnc_determineMuzzles = CBA_fnc_getMuzzles;

CBA_fnc_addWeaponCargoGlobal = CBA_fnc_addWeaponCargo;
CBA_fnc_addMagazineCargoGlobal = CBA_fnc_addMagazineCargo;
CBA_fnc_removeWeaponCargoGlobal = CBA_fnc_removeWeaponCargo;
CBA_fnc_removeMagazineCargoGlobal = CBA_fnc_removeMagazineCargo;
CBA_fnc_removeItemCargoGlobal = CBA_fnc_removeItemCargo;
CBA_fnc_removeBackpackCargoGlobal = CBA_fnc_removeBackpackCargo;

FUNC(directCall) = CBA_fnc_directCall;

CBA_fnc_intToString = {
    params [["_int", nil, [0]]];
    if (isNil "_int") exitWith {""};
    str _int
};

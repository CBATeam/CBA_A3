//#define DEBUG_MODE_FULL
#include "script_component.hpp"
LOG(MSG_INIT);
// Why would we send __SERVER__ to an on PLAYER connected event,
// [["__SERVER__","0",objNull,true]] call CBA_fnc_globalEvent;

addMissionEventHandler ["PlayerConnected", {
    params ["_id", "_uid", "_name", "_jip", "_owner"];

    if (_name == "__SERVER__") exitWith {};

    private _object = objNull;
    {
        if (name _x == _name) exitWith { _object = _x; };
    } forEach playableUnits;

    if (!isNull _object) then {
        [_name, _uid, _object] call FUNC(opc);
    };
}];

// Announce the completion of the initialization of the script
ADDON = true;

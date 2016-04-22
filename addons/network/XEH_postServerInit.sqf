//#define DEBUG_MODE_FULL
#include "script_component.hpp"
LOG(MSG_INIT);
// Why would we send __SERVER__ to an on PLAYER connected event,
// [["__SERVER__","0",objNull,true]] call CBA_fnc_globalEvent;

if (isNil {canSuspend}) then {
    // pre v1.58
    // OPC gets _id, _uid, _name
    [QUOTE(GVAR(opc)), "onPlayerConnected", {
        if (_name=="__SERVER__") exitWith {};
        _obj=objNull;
        {
            if (_name == name _x) then
            {
                _obj=_x;
            };
        } forEach playableUnits;
        if (!isNull _obj) then {[_name, _uid, _obj] call FUNC(opc);};
    }] call BIS_fnc_addStackedEventhandler;
} else {
    // v1.58 and later
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
};

// Announce the completion of the initialization of the script
ADDON = true;

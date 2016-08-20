//#define DEBUG_MODE_FULL
#include "script_component.hpp"
LOG(MSG_INIT);
// Why would we send __SERVER__ to an on PLAYER connected event,
// [["__SERVER__","0",objNull,true]] call CBA_fnc_globalEvent;

addMissionEventHandler ["PlayerConnected", { // @todo check if this runs for already connected players
    params ["_id", "_uid", "_name", "_jip", "_owner"];

    if (_name == "__SERVER__") exitWith {};

    private _object = objNull;
    {
        if (name _x == _name) exitWith { _object = _x; };
    } forEach playableUnits;

    if (!isNull _object) then {
        // @todo this is supposed to run on the client ? function broken since 2009 ?
        private _plName = "";

        if (!isNull player) then {
            _plName = name player;
        };

        if ((_name!= "__SERVER__") && {(_name!= format["%1", _plName])}) then {
            if (time > 0) then {
                [_obj] call FUNC(sync); { _x setMarkerPos (getMarkerPos _x) } forEach GVAR(markers);
            };
        };
    };
}];

// Announce the completion of the initialization of the script
ADDON = true;

#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_deleteEntity

Description:
    A function used to delete entities

Parameters:
    _entity to delete. Can be array of entites. <ARRAY, OBJECT, GROUP, LOCATION, MARKER>

Example:
    (begin example)
    [car1,car2,car3] call CBA_fnc_deleteEntity
    (end)

Returns:
    Nothing

Author:
    Rommel
---------------------------------------------------------------------------- */
SCRIPT(deleteEntity);

[_this] params [["_entity", objNull, [objNull, grpNull, locationNull, "", []]]];

switch (typeName _entity) do {
    case "ARRAY" : {
        {
            _x call CBA_fnc_deleteEntity;
        } forEach _entity;
    };
    case "OBJECT" : {
        if (vehicle _entity != _entity) then {
            unassignVehicle _entity;
            _entity setPosASL [0,0,0];
        } else {
            if ({_x != _entity} count (crew _entity) > 0) then {
                (crew _entity) call CBA_fnc_deleteEntity;
            };
        };
        deleteVehicle _entity;
    };
    case "GROUP" : {
        (units _entity) call CBA_fnc_deleteEntity;
        {deleteWaypoint _x} forEach (wayPoints _entity);
        if (isNull _entity) exitWith {};
        if (local _entity) then {
            deleteGroup _entity;
        } else {
            if (isServer) then {
                private _groupOwner = groupOwner _entity;
                if (_groupOwner isEqualTo 0) then {
                    [{groupOwner _this != 0 || isNull _this}, {
                        _this call CBA_fnc_deleteEntity;
                    }, _entity] call CBA_fnc_waitUntilAndExecute;
                } else {
                   _entity remoteExecCall ["CBA_fnc_deleteEntity", _groupOwner];
                };
            } else {
                _entity remoteExecCall ["CBA_fnc_deleteEntity", 2];
            };
        };
    };
    case "LOCATION" : {
        deleteLocation _entity;
    };
    case "STRING" : {
        deleteMarker _entity;
    };
    default {};
};

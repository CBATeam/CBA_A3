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
#include "script_component.hpp"
SCRIPT(deleteEntity);

[_this] params [["_entity", objNull, [objNull, grpNull, locationNull, "", []]]];

switch (typeName _entity) do {
    case "ARRAY" : {
        {
            _x call CBA_fnc_deleteEntity;
        } foreach _entity;
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
        {deleteWaypoint _x} foreach (wayPoints _entity);
        deleteGroup _entity;
    };
    case "LOCATION" : {
        deleteLocation _entity;
    };
    case "STRING" : {
        deleteMarker _entity
    };
    default {};
};

/* ----------------------------------------------------------------------------
Function: CBA_fnc_deleteEntity

Description:
    A function used to delete entities

Parameters:
    Array, Object, Group or Marker

Example:
    (begin example)
    [car1,car2,car3] call CBA_fnc_deleteEntity
    (end)

Returns:
    Nothing

Author:
    Rommel

---------------------------------------------------------------------------- */

switch (typeName _this) do {
    case "ARRAY" : {
        {
            _x call CBA_fnc_deleteEntity;
        } foreach _this;
    };
    case "OBJECT" : {
        if (vehicle _this != _this) then {
            unassignVehicle _this;
            _this setPosASL [0,0,0];
        } else {
            if (count ((crew _this) - [_this]) > 0) then {
                (crew _this) call CBA_fnc_deleteEntity;
            };
        };
        deleteVehicle _this;
    };
    case "GROUP" : {
        (units _this) call CBA_fnc_deleteEntity;
        {deleteWaypoint _x} foreach (wayPoints _this);
        deleteGroup _this;
    };
    case "LOCATION" : {
        deleteLocation _this;
    };
    case "STRING" : {
        deleteMarker _this
    };
    default {deleteVehicle _this};
};

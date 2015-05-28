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

switch (typename _this) do {
    case "ARRAY" : {
        {
            _x call CBA_fnc_deleteentity;
        } foreach _this;
    };
    case "OBJECT" : {
        if (vehicle _this != _this) then {
            unassignvehicle _this;
            _this setposasl [0,0,0];
        } else {
            if (count ((crew _this) - [_this]) > 0) then {
                (crew _this) call CBA_fnc_deleteentity;
            };
        };
        deletevehicle _this;
    };
    case "GROUP" : {
        (units _this) call CBA_fnc_deleteentity;
        {deletewaypoint _x} foreach (waypoints _this);
        deletegroup _this;
    };
    case "LOCATION" : {
        deletelocation _this;
    };
    case "STRING" : {
        deletemarker _this
    };
    default {deletevehicle _this};
};

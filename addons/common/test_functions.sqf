#include "script_component.hpp"
SCRIPT(test_functions);

// 0 spawn compile preprocessFileLineNumbers "\x\cba\addons\common\test_functions.sqf";

////////////////////////////////////////////////////////////////////////////////////////////////////

private _funcName = "CBA_fnc_isAttenuated";
LOG("Testing " + _funcName);

TEST_DEFINED(_funcName,"");

/*
    Creating the test array

    private _result = [];
    private _delete = [];
    {
        private _veh = createVehicle [_x, [0,0,0], [], 0, "CAN_COLLIDE"];
        _delete pushBack _veh;
        private _array = [_x];
        private _grp = createGroup [blufor, true];
        
        for "_i" from 1 to count (fullCrew [_veh, "", true]) do
        {
            private _unit = _grp createUnit ["B_Soldier_F", [0,0,0], [], 0, "CAN_COLLIDE"];
            
            _delete pushBack _unit;
            if (_unit moveInAny _veh) then
            {
                _array pushBack ([_unit] call CBA_fnc_isAttenuated);
            };
        };
        
        _delete call CBA_fnc_deleteEntity;
        _result pushBack _array;
    }
    forEach [
            "B_Heli_Transport_03_F",
            "B_Boat_Armed_01_minigun_F",
            "B_Boat_Transport_01_F",
            "C_Hatchback_01_F",
            "C_Van_01_transport_F",
            "B_Truck_01_transport_F",
            "B_MRAP_01_F",
            "B_MBT_01_TUSK_F",
            "C_Offroad_01_F",
            "C_Offroad_02_unarmed_F",
            "C_Van_02_transport_F",
            "B_Quadbike_01_F",
            "B_MRAP_01_hmg_F",
            "B_LSV_01_armed_F",
            "B_Heli_Light_01_F"
        ];
    _result
*/

private _delete = [];
{
    private _veh = createVehicle [_x select 0, [0,0,0], [], 0, "CAN_COLLIDE"];
    
    _delete pushBack _veh;
    private _array = [_x select 0];
    private _grp = createGroup [blufor, true];
    
    for "_i" from 1 to count (fullCrew [_veh, "", true]) do
    {
        private _unit = _grp createUnit ["B_Survivor_F", [0,0,0], [], 0, "CAN_COLLIDE"];
        _delete pushBack _unit;
        if (_unit moveInAny _veh) then
        {
            _array pushBack ([_unit] call CBA_fnc_isAttenuated);
        };
    };
    
    _delete call CBA_fnc_deleteEntity;
    
    // LOG_SYS("Check",_x select 0);
    TEST_TRUE(_array isEqualTo _x,_funcName +" "+ str (_x select 0));
}
forEach [
        ["B_Heli_Transport_03_F",true,false,false,false,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true],
        ["B_Boat_Armed_01_minigun_F",false,false,false,false,false,false,false,false,false,false,false],
        ["B_Boat_Transport_01_F",false,false,false,false,false],
        ["C_Hatchback_01_F",true,true,true,true],
        ["C_Van_01_transport_F",true,false,false,false,false,false,false,false,false,false,false,true,false],
        ["B_Truck_01_transport_F",true,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false],
        ["B_MRAP_01_F",true,true,true,true],
        ["B_MBT_01_TUSK_F",true,true,true,true,true,true,true,true,true],
        ["C_Offroad_01_F",true,false,false,false,false,true],
        ["C_Offroad_02_unarmed_F",false,false,false,false],
        ["C_Van_02_transport_F",true,true,true,true,true,true,true,true,true,true,true,true],
        ["B_Quadbike_01_F",false,false],
        ["B_MRAP_01_hmg_F",true,true,true,true],
        ["B_LSV_01_armed_F",false,false,false,false,false],
        ["B_Heli_Light_01_F",false,false,false,false,false,false,false,false]
    ];

////////////////////////////////////////////////////////////////////////////////////////////////////

private _funcName = "CBA_fnc_isTurnedOut";
LOG("Testing " + _funcName);

TEST_DEFINED(_funcName,"");

/*
    Creating the test array

    private _result = [];
    private _delete = [];
    {
        private _veh = createVehicle [_x, [0,0,0], [], 0, "CAN_COLLIDE"];
        _delete pushBack _veh;
        private _array = [_x];
        private _grp = createGroup [blufor, true];
        
        for "_i" from 1 to count (fullCrew [_veh, "", true]) do
        {
            private _unit = _grp createUnit ["B_Soldier_F", [0,0,0], [], 0, "CAN_COLLIDE"];
            
            _delete pushBack _unit;
            if (_unit moveInAny _veh) then
            {
                _array pushBack ([_unit] call CBA_fnc_isTurnedOut);
            };
        };
        
        _delete call CBA_fnc_deleteEntity;
        _result pushBack _array;
    }
    forEach [
            "B_Heli_Transport_03_F",
            "B_Boat_Armed_01_minigun_F",
            "B_Boat_Transport_01_F",
            "C_Hatchback_01_F",
            "C_Van_01_transport_F",
            "B_Truck_01_transport_F",
            "B_MRAP_01_F",
            "B_MBT_01_TUSK_F",
            "C_Offroad_01_F",
            "C_Offroad_02_unarmed_F",
            "C_Van_02_transport_F",
            "B_Quadbike_01_F",
            "B_MRAP_01_hmg_F",
            "B_LSV_01_armed_F",
            "B_Heli_Light_01_F"
        ];
    _result
*/

private _delete = [];
{
    private _veh = createVehicle [_x select 0, [0,0,0], [], 0, "CAN_COLLIDE"];
    
    _delete pushBack _veh;
    private _array = [_x select 0];
    private _grp = createGroup [blufor, true];
    
    for "_i" from 1 to count (fullCrew [_veh, "", true]) do
    {
        private _unit = _grp createUnit ["B_Survivor_F", [0,0,0], [], 0, "CAN_COLLIDE"];
        _delete pushBack _unit;
        if (_unit moveInAny _veh) then
        {
            _array pushBack ([_unit] call CBA_fnc_isTurnedOut);
        };
    };
    
    _delete call CBA_fnc_deleteEntity;
    
    // LOG_SYS("Check",_x select 0);
    TEST_TRUE(_array isEqualTo _x,_funcName +" "+ str (_x select 0));
}
forEach [
        ["B_Heli_Transport_03_F",false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false],
        ["B_Boat_Armed_01_minigun_F",false,false,false,false,false,false,false,false,false,false,false],
        ["B_Boat_Transport_01_F",false,false,false,false,false],
        ["C_Hatchback_01_F",false,false,false,false],
        ["C_Van_01_transport_F",false,false,false,false,false,false,false,false,false,false,false,false,false],
        ["B_Truck_01_transport_F",false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false],
        ["B_MRAP_01_F",false,false,false,false],
        ["B_MBT_01_TUSK_F",false,false,false,false,false,false,false,false,false],
        ["C_Offroad_01_F",false,false,false,false,false,false],
        ["C_Offroad_02_unarmed_F",false,false,false,false],
        ["C_Van_02_transport_F",false,false,false,false,false,false,false,false,false,false,false,false],
        ["B_Quadbike_01_F",false,false],
        ["B_MRAP_01_hmg_F",false,false,false,false],
        ["B_LSV_01_armed_F",false,false,false,false,false],
        ["B_Heli_Light_01_F",false,false,false,false,false,false,false,false]
    ];

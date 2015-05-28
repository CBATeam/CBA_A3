//#define DEBUG_MODE_FULL
#include "script_component.hpp"
LOG(MSG_INIT);
// Why would we send __SERVER__ to an on PLAYER connected event,
// [["__SERVER__","0",objNull,true]] call CBA_fnc_globalEvent;

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

// Use Function that can be called using BIS_fnc_MP so that even non CBA clients will announce
//[nil, QGVAR(sendPlayerID),true, true] spawn BIS_fnc_MP;
//TRACE_2("",cba_network_joinN,cba_network_sendPlayerID);

//CBA_logic setVehicleInit QUOTE(if(!isDedicated)then{[]spawn{waitUntil{player == player};GVAR(joinN) = DATA;publicVariable 'GVAR(joinN)'}});
//processInitCommands;

// Announce the completion of the initialization of the script
ADDON = true;
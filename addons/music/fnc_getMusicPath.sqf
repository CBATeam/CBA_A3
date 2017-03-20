/* ----------------------------------------------------------------------------
Function: CBA_fnc_getMusicPath

Description:
    A function used to return the config path of a music file
    
Parameters:
    STRING- name of track
    
Returns:
    config entry of given track
    
Example:
    (begin example)
        _configPath = ["LeadTrack01_F_Bootcamp"] call CBA_fnc_getMusicPath
    (end example)

Authors:
    Fishy, Dorbedo
---------------------------------------------------------------------------- */
#include "script_component.hpp"

if (!params [["_className","",["",configFile]]]) exitWith {WARNING('No classname was provided'); nil};

if (IS_CONFIG(_className)) exitWith {_className};

private _config = missionConfigFile >> "CfgMusic" >> _className;
private _duration = getNumber (_config >> "duration");

if (_duration isEqualTo 0) then {
    _config = configFile >> "CfgMusic" >> _className;
    _duration = getNumber (_config >> "duration");
    if (_duration isEqualTo 0) exitWith {WARNING_1("No path found for class",_className); nil};
};

_config 

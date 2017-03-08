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

if (!params [["_className","",[""]]]) exitWith {WARNING('No classname was provided');};

private "_config";
_config = configFile >> 'CfgMusic' >> _className;
private "_duration";
_duration = getNumber (_config >> "duration");

if (_duration == 0) then {
    _config = missionConfigFile >> "CfgMusic" >> _className;
    _duration = getNumber (_config >> "name");
    if (_duration == 0) exitWith {WARNING_1("No path found for class",_className);nil};
};

_config 

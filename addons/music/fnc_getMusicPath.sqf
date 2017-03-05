/* ----------------------------------------------------------------------------
Function: CBA_fnc_getMusicPath
Description:
    A function used to return the config path of a music file
Parameters:
    one string
Example:
    (begin example)
    _configPath = ["LeadTrack01_F_Bootcamp"] call CBA_fnc_getMusicPath
    (end example)
Returns:
    config
Author:
    Fishy
---------------------------------------------------------------------------- */
#include "script_component.hpp"

private ['_vars','_config','_duration'];
if (!params [["_className",'']]) exitWith {WARNING('No Class name given');};
if (typeName _className != 'STRING') exitWith {WARNING_1('Class not a string',_className);};
_config = configFile >> 'CfgMusic' >> _className;
_duration = getNumber (_config >> 'duration');
if (_duration == 0) then {
    _config = missionConfigFile >> 'CfgMusic' >> _className;
    _duration = getNumber (_config >> 'name');
    if (_duration == 0) exitWith {WARNING_1('No path found for class',_className);nil};
};
_config 

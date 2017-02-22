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

private ['_vars','_cfg','_dur'];
if (!params [["_className",'']]) exitWith {WARNING('No Class name given');};
if (typeName _className != 'STRING') exitWith {WARNING_1('Class not a string',_className);};
_cfg = configFile >> 'CfgMusic' >> _className;
_dur = getNumber (_cfg >> 'duration');
if (_dur == 0) then {
	_cfg = missionConfigFile >> 'CfgMusic' >> _className;
	_dur = getNumber (_cfg >> 'name');
	if (_dur == 0) exitWith {WARNING_1('No path found for class',_className);nil};
};
_cfg 

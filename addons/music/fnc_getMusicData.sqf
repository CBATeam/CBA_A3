/* ----------------------------------------------------------------------------
Function: CBA_fnc_getMusicData
Description:
    A function used to return data from the given music class
Parameters:
    one string OR one config path, and a data type (eg 'name')
Example:
    (begin example)
    _musicName = ["LeadTrack01_F_Bootcamp","Duration"] call CBA_fnc_getMusicData;
    (end example)
Returns:
    String
Author:
    Fishy
---------------------------------------------------------------------------- */
#include "script_component.hpp"
private ["_cfg","_data"];
params [["_className",''],["_dataType",'name']];
LOG(_className);
if (typeName _className == 'STRING') then {
    //Is a string, get config
    _cfg = [_className] call CBA_fnc_getMusicPath;
} else {
    if (IS_CONFIG(_className)) then {
        _cfg = _className;
    };
};
if (typeName _cfg != 'CONFIG') exitWith {ERROR_1('Config not found',_className);};

//Now we have a config, grab the data
_data = [_cfg,_dataType,nil] call BIS_fnc_returnConfigEntry;
_data 

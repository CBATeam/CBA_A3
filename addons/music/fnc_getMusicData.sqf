/* ----------------------------------------------------------------------------
Function: CBA_fnc_getMusicData

Description:
    A function used to return data from the given music class
    
Parameters:
    one string OR one config path, and a data type (eg 'name')
    
Returns:
    data entry for requested music class
    
Example:
    (begin example)
        _musicName = ["LeadTrack01_F_Bootcamp","Duration"] call CBA_fnc_getMusicData;
    (end example)

Author:
    Fishy
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_className",""],["_dataType","name"]];
private "_config";

if (IS_STRING(_classname)) then {
    //Is a string, get config
    _config = [_className] call CBA_fnc_getMusicPath;
} else {
    if (IS_CONFIG(_className)) then {
        _config = _className;
    };
};

if (!IS_CONFIG(_config)) exitWith {ERROR_1("Config not found",_className);};

//Now we have a config, grab the data
[_config,_dataType,nil] call BIS_fnc_returnConfigEntry

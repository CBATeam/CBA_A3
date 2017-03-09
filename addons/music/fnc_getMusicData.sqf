/* ----------------------------------------------------------------------------
Function: CBA_fnc_getMusicData

Description:
    A function used to return data from the given music class
    
Parameters:
    CONFIG or CLASS- music path or class name
    DATA- the desired config entry
Returns:
    data entry for requested music class
    
Example:
    (begin example)
        _musicName = ["LeadTrack01_F_Bootcamp","Duration"] call CBA_fnc_getMusicData;
    (end example)

Author:
    Fishy, Dedmen
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_config","",["",configFile]],["_dataType","name"]];

if (IS_STRING(_config)) then {_config = [_config] call CBA_fnc_getMusicPath;};

If ((isNil "_config") || {!IS_CONFIG(_config)}) exitWith {ERROR_1("Config not found", _config); nil};

//Now we have a config, grab the data
[_config, _dataType, nil] call BIS_fnc_returnConfigEntry

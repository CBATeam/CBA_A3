/* ----------------------------------------------------------------------------
Function: CBA_fnc_getMusicData

Description:
    A function used to return data from the given music class

Parameters:
    CONFIG or CLASS- music path or class name
    DATA- the desired config entry
    Default- what to return if nothing found

Returns:
    data entry for requested music class (or default if nothing found)

Example:
    (begin example)
        _duration = ["LeadTrack01_F_Bootcamp", "duration"] call CBA_fnc_getMusicData;
    (end example)

Author:
    Fishy, Dedmen
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [
    ["_config", "", ["", configFile]],
    ["_dataType", "name", [""]],
    ["_default", nil]
];

if (_config isEqualTo "") exitWith {ERROR("Config not given"); _default};
if (IS_STRING(_config)) then {_config = [_config] call CBA_fnc_getMusicPath;};

if ((isNil "_config") || {!IS_CONFIG(_config)}) exitWith {ERROR_1("Config not found for %1", _config); nil};

//Now we have a config, grab the data
private _return = [_config, _dataType, nil] call BIS_fnc_returnConfigEntry;

if (!(isNil "_return")) exitWith {_return};
if (!(isNil "_default")) exitWith {_default};

//Got nothing from config and a default value was not provided so see if a hard coded default exists
switch (toLower _dataType) do {
    case "type": {_return = DEFAULT_SONG_TYPE;};
    case "theme": {_return = DEFAULT_SONG_THEME;};
    case "tags": {_return = DEFAULT_SONG_TAGS;};
};

_return
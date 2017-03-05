/* ----------------------------------------------------------------------------
Function: CBA_fnc_compileMusic
Description:
A function used to gather a list of all usable music.
Parameters:
none
Example:
(begin example)
_allmusic = [] call CBA_fnc_compileMusic
(end example)
Returns:
config
Author:
Fishy
---------------------------------------------------------------------------- */
#include "script_component.hpp"
if (isNil QGVARMAIN(compiledMusic)) then {
_config = configFile >> 'CfgMusic';
_missionConfig = missionConfigFile >> 'CfgMusic';
_unsortedSongs = [];
for [{_i=0}, {_i < (count _config)}, {INC(_i)}] do {
_song = _config select _i;
_songDuration = getNumber (_song >> 'duration');
if (_songDuration !=0) then {
_songClassName = configName _song;
_unsortedSongs pushBack _songClassName;
};
};
for [{_i=0}, {_i < (count _missionConfig)}, {INC(_i)}] do {
_song = _missionConfig select _i;
_songDuration = getNumber (_song >> 'duration');
if (_songDuration !=0) then {
_songClassName = configName _song;
_unsortedSongs pushBack _songClassName;
};
};
GVARMAIN(compiledMusic) = _unsortedSongs;
_unsortedSongs 
};
GVARMAIN(compiledMusic)

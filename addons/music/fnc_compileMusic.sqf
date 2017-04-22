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
_cfg = configFile >> 'CfgMusic';
_mission_cfg = missionConfigFile >> 'CfgMusic';
_songs_unsorted = [];
for [{_i=0}, {_i < (count _cfg)}, {INC(_i)}] do {
_song = _cfg select _i;
_s_dur = getNumber (_song >> 'duration');
if (_s_dur !=0) then {
_song_cName = configName _song;
_songs_unsorted pushBack _song_cName;
};
};
for [{_i=0}, {_i < (count _mission_cfg)}, {INC(_i)}] do {
_song = _mission_cfg select _i;
_s_dur = getNumber (_song >> 'duration');
if (_s_dur !=0) then {
_song_cName = configName _song;
_songs_unsorted pushBack _song_cName;
};
};
GVARMAIN(compiledMusic) = _songs_unsorted;
_songs_unsorted 
};
GVARMAIN(compiledMusic)

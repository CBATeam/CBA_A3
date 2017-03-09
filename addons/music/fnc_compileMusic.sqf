/* ----------------------------------------------------------------------------
Function: CBA_fnc_compileMusic

Description:
    A function used to gather a list of all usable music.
    
Parameters:
    none

Returns:
    Array of compiled music
    
Example:
    (begin example)
        _allMusic = [] call CBA_fnc_compileMusic
    (end example)

Author:
    Fishy, Dedmen
---------------------------------------------------------------------------- */
#include "script_component.hpp"

if (isNil QGVARMAIN(compiledMusic)) then {
    private _config = configFile >> 'CfgMusic';
    private _missionConfig = missionConfigFile >> 'CfgMusic';
    private _unsortedSongs = [];
    
    for [{_i=0}, {_i < (count _config)}, {INC(_i)}] do {
        private _song = _config select _i;
        private _songDuration = getNumber (_song >> 'duration');
        if (_songDuration > 0) then {
            _unsortedSongs pushBack (configName _song);
        };
    };
    
    for [{_i=0}, {_i < (count _missionConfig)}, {INC(_i)}] do {
        private _song = _missionConfig select _i;
        private _songDuration = getNumber (_song >> 'duration');
        if (_songDuration > 0) then {
            _unsortedSongs pushBack (configName _song);
        };
    };
    
    GVARMAIN(compiledMusic) = _unsortedSongs;
};

GVARMAIN(compiledMusic)

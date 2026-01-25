#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_compileMusic

Description:
    A function used to gather a list of all music classes

Parameters:
    none

Returns:
    Array of compiled music (in CLASS format)

Example:
    (begin example)
        _allMusic = [] call CBA_fnc_compileMusic
    (end example)

Author:
    Fishy, Dorbedo, Dedmen
---------------------------------------------------------------------------- */

if (isNil QGVARMAIN(compiledMusic)) then {
    private _allMusic = configProperties [missionConfigFile >> "CfgMusic", "(getNumber (_x >> 'duration')) > 0", true];
    _allMusic append configProperties [configFile >> "CfgMusic", "(getNumber (_x >> 'duration')) > 0", true];
    private _unsortedSongs = [];
    {
        _unsortedSongs pushBackUnique (configName _x);
    } forEach _allMusic;

    GVARMAIN(compiledMusic) = +_unsortedSongs;
};

GVARMAIN(compiledMusic)

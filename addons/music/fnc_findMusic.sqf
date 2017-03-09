/* ----------------------------------------------------------------------------
Function: CBA_fnc_findMusic

Description:
    A function used to return songs with given type and tags
    
Parameters:
    1: A string or array of strings, defining music "type".
    2: A string or array of strings, defining tags/themes to look for.
    3: Array (optional) of song classes to search. Uses full list by default
    
Returns:
    array or results
    
Example:
    (begin example)
        _results = ["song","stealth"] call CBA_fnc_searchMusic
    (end example)
    
Author:
    Fishy, Dedmen, Dorbedo
---------------------------------------------------------------------------- */
#include "script_component.hpp"


params [["_searchType","any",["",[]]],["_searchTags","any",["",[]]],["_searchTracks",([] call CBA_fnc_compileMusic),[[]]]];

if (IS_STRING(_searchType)) then {_searchType = [_searchType];};
if (IS_STRING(_searchTags)) then {_searchTags = [_searchTags];};

if (_searchType select 0 == "any") then {_searchType = [];};
if (_searchTags select 0 == "any") then {_searchTags = [];};

_searchType = _searchType apply {If (IS_STRING(_x)) then {toLower _x} else {""};};
_searchTags = _searchTags apply {If (IS_STRING(_x)) then {toLower _x} else {""};};

_searchType = _searchType - [""];
_searchTags = _searchTags - [""];

private _results = [];

{
    private _track = _x;
    private _config = [_track] call CBA_fnc_getMusicPath;
    if (IS_CONFIG(_config)) then {
        private _type = getText (_config >> 'type');
        if (_type == "") then {_type = DEFAULT_SONG_TYPE};
        
        if (count _searchType == 0 || {(toLower _type) in _searchType}) then {
            if (count _searchTags > 0) then {
                private _tags = getArray (_config >> 'tags');
                private _theme = getText (_config >> 'theme');
                _tags pushBack _theme;    //BIS sounds dont have tags so use their theme instead
                for [{_i=0}, {_i < (count _tags)}, {_i = _i + 1}] do {
                    _tag = toLower (_tags select _i);
                    if (count _searchTags == 0 || {_tag in _searchTags}) then {
                        _i = count _tags;
                        _results pushBack _track;
                    };
                };
            } else {
                //No tags required so add it
                _results pushBack _track;
            };
        }
    };
} forEach _searchTracks;

_results 

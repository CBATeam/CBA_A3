/* ----------------------------------------------------------------------------
Function: CBA_fnc_searchMusic
Description:
    A function used to return sogns with given type and tags
Parameters:
    1: A string or array of strings, defining music "type".
    2: A string or array of strings, defining tags/themes to look for.
    3: Array (optional) of song classes to search. Uses full list by default
Example:
    (begin example)
    _results = ["song","stealth"] call CBA_fnc_searchMusic
    (end example)
Returns:
    array
Author:
    Fishy
---------------------------------------------------------------------------- */
#include "script_component.hpp"

private ['_vars','_config','_duration'];
if (!params [["_className",'']]) exitWith {ERROR('No Class name given');};

_searchType = [_this,0,'any',['',[]]] call BIS_fnc_param;
_searchTags = [_this,1,'any',['',[]]] call BIS_fnc_param;
_searchTracks = [_this,2,[] call CBA_fnc_compileMusic,[[]]] call BIS_fnc_param;
if (typeName _searchType == 'STRING') then {_searchType = [_searchType];};
if (typeName _searchTags == 'STRING') then {_searchTags = [_searchTags];};
if (_searchType select 0 == 'any') then {_searchType = [];};
if (_searchTags select 0 == 'any') then {_searchTags = [];};

for [{_i=0}, {_i < (count _searchType)}, {INC(_i)}] do {
    _entry = _searchType select _i;
    if (typeName _entry != 'STRING') then {
        _searchType set [_i, ''];
    } else {
        _searchType set [_i, toLower (_entry)];
    };
};
for [{_i=0}, {_i < (count _searchTags)}, {INC(_i)}] do {
    _entry = _searchTags select _i;
    if (typeName _entry != 'STRING') then {
        _searchTags set [_i, ''];
    } else {
        _searchTags set [_i, toLower (_entry)];
    };
};

_searchType = _searchType - [''];
_searchTags = _searchTags - [''];
_results = [];

{
    _track = _x;
    _config = [_track] call CBA_fnc_getMusicPath;
    if (typeName _config == 'CONFIG') then {
        _type = getText (_config >> 'type');
        if (_type == '') then {_type = DEFAULT_SONG_TYPE};
        if ((toLower _type) in _searchType || count _searchType == 0) then {
            if (count _searchTags > 0) then {
                _tags = getArray (_config >> 'tags');
                _theme = getText (_config >> 'theme');
                _tags pushBack _theme;    //BIS sounds dont have tags so use their theme instead
                for [{_i=0}, {_i < (count _tags)}, {_i = _i + 1}] do {
                    _tag = toLower (_tags select _i);
                    if (_tag in _searchTags || count _searchTags == 0) then {
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

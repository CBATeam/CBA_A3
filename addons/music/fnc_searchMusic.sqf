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

private ['_vars','_cfg','_dur'];
if (!params [["_className",'']]) exitWith {ERROR('No Class name given');};

_search_type = [_this,0,'any',['',[]]] call BIS_fnc_param;
_search_tags = [_this,1,'any',['',[]]] call BIS_fnc_param;
_search_tracks = [_this,2,[] call fsh_fnc_compileMusic,[[]]] call BIS_fnc_param;
if (typeName _search_type == 'STRING') then {_search_type = [_search_type];};
if (typeName _search_tags == 'STRING') then {_search_tags = [_search_tags];};
if (_search_type select 0 == 'any') then {_search_type = [];};
if (_search_tags select 0 == 'any') then {_search_tags = [];};

for [{_i=0}, {_i < (count _search_type)}, {INC(_i)}] do {
    _entry = _search_type select _i;
    if (typeName _entry != 'STRING') then {
        _search_type set [_i, ''];
    } else {
        _search_type set [_i, toLower (_entry)];
    };
};
for [{_i=0}, {_i < (count _search_tags)}, {INC(_i)}] do {
    _entry = _search_tags select _i;
    if (typeName _entry != 'STRING') then {
        _search_tags set [_i, ''];
    } else {
        _search_tags set [_i, toLower (_entry)];
    };
};

_search_type = _search_type - [''];
_search_tags = _search_tags - [''];
_results = [];

{
    _track = _x;
    _cfg = [_track] call CBA_fnc_getMusicPath;
    if (typeName _cfg == 'CONFIG') then {
        _type = getText (_cfg >> 'type');
        if (_type == '') then {_type = DEFAULT_SONG_TYPE};
        if ((toLower _type) in _search_type || count _search_type == 0) then {
            if (count _search_tags > 0) then {
                _tags = getArray (_cfg >> 'tags');
                _theme = getText (_cfg >> 'theme');
                _tags pushBack _theme;    //BIS sounds dont have tags so use their theme instead
                for [{_i=0}, {_i < (count _tags)}, {_i = _i + 1}] do {
                    _tag = toLower (_tags select _i);
                    if (_tag in _search_tags || count _search_tags == 0) then {
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
} forEach _search_tracks;

_results 

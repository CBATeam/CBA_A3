/* ----------------------------------------------------------------------------
Function: CBA_fnc_mapGridToPos

Description:
    Converts a 2, 4, 6, 8, or 10 digit grid reference into a Position.

Parameters:
    _pos - The position, either an array of strings for the northing & easting or a string.
    _doOffSet - If true, return the center of the gridsquare, if false return upper left. Default false.

Returns:
    Position in internal gridspace.

Examples:
    (begin example)
        _pos = ["024", "015"] call CBA_fnc_mapGridToPos;
    (end)
    (begin example)
        _pos = [["024", "015"], true] call CBA_fnc_mapGridToPos;
    (end)
    (begin example)
        _pos = "024015" call CBA_fnc_mapGridToPos;
    (end)

Author:
    Nou
---------------------------------------------------------------------------- */
#include "script_component.hpp"

SCRIPT(mapGridToPos);

private ["_pos", "_doOffset", "_posArray", "_ea", "_na", "_start", "_check", "_minus", "_digits", "_maxNorthing", "_height", "_easting", "_northing", "_eastingSize", "_northingSize", "_eastingMultiple", "_northingMultiple", "_posX", "_posY", "_offset", "_return", "_reversed"];


_doOffSet = false;
_reversed = [] call CBA_fnc_northingReversed;
_pos = [];

if (IS_ARRAY(_this)) then {
    if (count _this > 1) then {
        if (IS_BOOL(_this select 1)) then {
            _pos = _this select 0;
            _doOffSet = _this select 1;
        } else {
            _pos = _this;
        };
    } else {
        if (IS_ARRAY(_this select 0)) then {
            _pos = _this select 0;
        } else {
            _pos = _this;
        };
    };
} else {
    _pos = _this;
};

if (IS_STRING(_pos)) then {
    _posArray = toArray _pos;
    _pos = [];
    _ea = [];
    for "_i" from 0 to (((count _posArray) / 2) - 1) do {
        _ea pushBack (_posArray select _i);
    };
    _na = [];
    for "_i" from (((count _posArray)/2)) to (((count _posArray))-1) do {
        _na pushBack (_posArray select _i);
    };
    _pos set [0, toString _ea];
    _pos set [1, toString _na];
};

/**
 * Get extents of the Y Northing column for the map.
 * This uses mapGridPosition to get the 6 digit coordinate
 * at the bottom internal grid position, then it adds 1
 * meter to the internal Y coordinate till mapGridPosition
 * changes. This reveals the correct height in meters of the
 * map.
 */
 if (_reversed) then {
    _start = format ["%1", mapGridPosition [0, 0]];
    _check = _start;
    _minus = 0;

    while {_check == _start} do {
        _check = format["%1", mapGridPosition [0, _minus]];
        _minus = _minus - 1;
    };

    _digits = toArray _start;
    _maxNorthing = parseNumber (toString [_digits select 3, _digits select 4, _digits select 5]);
    _height = (_maxNorthing * 100) - abs (_minus) + 1;
} else {
    if (isNil QGVAR(rvOriginX) || {isNil QGVAR(rvOriginY)}) then {
        _start = format["%1", mapGridPosition [0, 0]];
        _size = toArray _start;
        _rvOriginY = 0;
        _rvOriginX = 0;
        _ignore = false;
        switch (count _size) do {
            case 2: {
                _rvOriginY = (parseNumber (toString [(_size select 1)])) * 10000;
                _rvOriginX = (parseNumber (toString [(_size select 0)])) * 10000;
            };
            case 4: {
                _rvOriginY = (parseNumber (toString [(_size select 2), (_size select 3)])) * 1000;
                _rvOriginX = (parseNumber (toString [(_size select 0), (_size select 1)])) * 1000;
            };
            case 6: {
                _rvOriginY = (parseNumber (toString [(_size select 3), (_size select 4), (_size select 5)])) * 100;
                _rvOriginX = (parseNumber (toString [(_size select 0), (_size select 1), (_size select 2)])) * 100;
            };
            case 8: {
                _rvOriginY = (parseNumber (toString [(_size select 4), (_size select 5), (_size select 6), (_size select 7)])) * 10;
                _rvOriginX = (parseNumber (toString [(_size select 0), (_size select 1), (_size select 2), (_size select 3)])) * 10;
            };
            case 10: {
                _rvOriginY = (parseNumber (toString [(_size select 5), (_size select 6), (_size select 7), (_size select 8), (_size select 9)]));
                _rvOriginX = (parseNumber (toString [(_size select 0), (_size select 1), (_size select 2), (_size select 3), (_size select 4)]));
                _ignore = true;
            };
        };
        if (!_ignore) then {
            _check = _start;
            _minus = 0;

            while {_check == _start} do {
                _check = format ["%1", mapGridPosition [0, _minus]];
                _minus = _minus - 1;
            };

            _rvOriginY = _rvOriginY + (abs _minus) - 1;
            _minus = 0;
            _check = _start;

            while {_check == _start} do {
                _check = format ["%1", mapGridPosition [_minus, 0]];
                _minus = _minus - 1;
            };
            _rvOriginX = _rvOriginX + (abs _minus)-1;
        };
        GVAR(rvOriginX) = _rvOriginX;
        GVAR(rvOriginY) = _rvOriginY;
    };
};

// Do the math to get the right internal grid.
_easting = _pos select 0;
_northing = _pos select 1;

if (IS_NUMBER(_easting)) then {
    _easting = format ["%1", _easting];
};
if (IS_NUMBER(_northing)) then {
    _northing = format ["%1", _northing];
};

_eastingSize = (count (toArray _easting)) min 5;
_northingSize = (count (toArray _northing)) min 5;
_eastingMultiple = (10 ^ ((10 - (_eastingSize * 2)) / 2));
_northingMultiple = (10 ^ ((10 - (_northingSize * 2)) / 2));
_posY = 0;

if (_reversed) then {
    _posY = (_height - ((parseNumber _northing) * _northingMultiple)) + 100;
} else {
    _posY = ((parseNumber _northing) * _northingMultiple);
};
_posX = ((parseNumber _easting) * _eastingMultiple);

// Do we want the upper left corner of the grid square, or the center?
_offset = 0;
if (_doOffSet && {(_northingMultiple max _eastingMultiple) > 1}) then {
    _offset = (_northingMultiple max _eastingMultiple) / 2;
};

// Return position.
_return = if (_reversed) then {
    [_posX + _offset, _posY - _offset, 0]
} else {
    [_posX + _offset - GVAR(rvOriginX), _posY + _offset - GVAR(rvOriginY), 0]
};

_return

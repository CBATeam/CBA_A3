/*
This simply performs the equivalent of:
        _caption =
            ([_caption, _index, _index+_offset] call KRON_StrLeft)+
            format["<t color='%1'>%2</t>", GVAR(hotKeyColor), [_caption, _index+_offset, 1] call KRON_StrMid]+
            ([_caption, _index+_offset+1] call KRON_StrMid);

in order to avoid the millions of Deprecated function warnings:
    WARNING: Deprecated function used: KRON_StrToArray (new: cba_fnc_split) in cba_common
*/

private ['_array', '_index', '_offset', '_hotKeyColor_ST',
    '_captionArray', '_i', '_len', '_array2'];

_array = _this select 0;
_index = _this select 1;
_offset = _this select 2;
_hotKeyColor_ST = _this select 3; // (ST=structured text) "<t color='#f07EB27E'>"

_captionArray = [];

_len = 0;

// ([_caption, _index] call KRON_StrLeft)+
for "_i" from 0 to (_index - 1) do {
    _captionArray set [_len, _array select _i];
    _len = _len + 1;
};

// format["<t color='%1'>%2</t>", _hotKeyColor_ST, [_caption, _index+_offset, 1] call KRON_StrMid]+
_array2 = toArray _hotKeyColor_ST;
for "_i" from 0 to (count _array2 - 1) do {
    _captionArray set [_len, _array2 select _i];
    _len = _len + 1;
};

for "_i" from (_index + _offset) to (_index + _offset) do {
    _captionArray set [_len, _array select _i];
    _len = _len + 1;
};

_array2 = toArray "</t>";
for "_i" from 0 to (count _array2 - 1) do {
    _captionArray set [_len, _array2 select _i];
    _len = _len + 1;
};

// ([_caption, _index+_offset+1] call KRON_StrMid);
for "_i" from (_index + _offset + 1) to (count _array - 1) do {
    _captionArray set [_len, _array select _i];
    _len = _len + 1;
};

(toString _captionArray)

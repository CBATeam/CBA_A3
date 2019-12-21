#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_encodeJSON

Description:
    Encodes any SQF value to a JSON string.

Parameters:
    _data - SQF data <ANY>.

Returns:
    JSON string. <STRING>

Author:
    Naught, commy2
---------------------------------------------------------------------------- */
if (isNil "_this") exitWith {"undefined"}; // Return

switch (typeName _this) do
{
    case "SCALAR": {format["%1", _this]}; // Return
    case "BOOL": {format["%1", _this]}; // Return

    case "OBJECT":
    {
        if (isNull _this) exitWith {"null"}; // Return

        '{' + // Return object format
            '"type": "object",' +
            '"netId": ' + (netId _this) +
        '}'
    };

    case "GROUP":
    {
        if (isNull _this) exitWith {"null"}; // Return

        '{' + // Return object format
            '"type": "group",' +
            '"netId": ' + (netId _this) +
        '}'
    };

    case "STRING":
    {
        private ["_output"];
        _strArr = toArray(_this);

        if (22 in _strArr) then // Escape double quotes (UTF-8 &#22)
        {
            private ["_output", "_offset"];
            _output = [22];
            _offset = 1;

            { // forEach
                if (_x in [22,92]) then
                {
                    _output set [(_forEachIndex + _offset), 92]; // Escape with backslash (UTF-8 &#92)
                    _offset = _offset + 1;
                };

                _output set [(_forEachIndex + _offset), _x];
            } forEach toArray(_this);

            _output pushback 22;
            toString(_output) // Return
        }
        else
        {
            ("""" + _this + """") // Return
        };
    };

    case "ARRAY":
    {
        private ["_output"];
        _output = "[";

        { // forEach
            if (_forEachIndex > 0) then {_output = _output + ","};
            _output = _output + (_x call CBA_fnc_encodeJSON);
        } forEach _this;

        (_output + "]") // Return
    };

    // For all other types, just convert to string
    default {str(_this) call CBA_fnc_encodeJSON};
};

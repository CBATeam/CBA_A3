/* ----------------------------------------------------------------------------
Function: CBA_fnc_unicodeToChar

Description:
    Gets the unicode char of the given unicode number
    For more information to unicodes visit: https://unicode-table.com/

Parameters:
    _unicodeNumber : the unicode number : <NUMBER>
    _returnArray : type of the result : true for array | false for string : <BOOL>

Returns:
    Either an array or string:
    The result from the unicode char related to the given unicode number (see _unicodeNumber)

Examples:
    (begin example)
        _unicodeNumber = 49;
        _unicodeChar = "";
        _unicodeChar = ([_unicodeNumber] call CBA_fnc_unicodeToChar);
        //_unicodeChar will return "1"
    (end)
    (begin example)
        _unicodeNumber = 49;
        _unicodeCharArray = [];
        _unicodeCharArray = ([_unicodeNumber, true] call CBA_fnc_unicodeToChar);
        //_uniocdeChar will return ["1"]
    (end)
    (begin example)
        _unicodeNumberArray = [49, 50];
        _unicodeCharArray = [];
        _unicodeCharArray = ([_unicodeNumberArray, true] call CBA_fnc_unicodeToChar);
        //_unicodeCharArray will return ["1", "2"]
    (end)
    (begin example)
        _unicodeNumberArray = [49, 50];
        _unicodeChars = "";
        _unicodeChars = ([_unicodeNumberArray] call CBA_fnc_unicodeToChar);
        //_unicodeChars will return "12"
    (end)
Author:
    Vincent Heins
---------------------------------------------------------------------------- */

params [
    ["_unicodeNumber", 0, [0, []]],
    ["_returnArray", false, [false]]
];

if (_unicodeNumber isEqualType 0) then
{
    _unicodeNumber = [_unicodeNumber];
};

if (_returnArray) then
{
    (toString _unicodeNumber);
}
else
{
    ((toString _unicodeNumber) splitString "");
};

//old thought: (str parseText format["&#%1;", _unicodeNumber]);

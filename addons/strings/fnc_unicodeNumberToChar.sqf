/* ----------------------------------------------------------------------------
Function: CBA_fnc_unicodeToChar

Description:
    Gets the unicode char of the given unicode number
    For more information to unicodes visit: https://unicode-table.com/

Parameters:
    _unicodeNumber: the unicode number <NUMBER>

Returns:
    given unicode char <STRING>

Examples:
    (begin example)
        _unicodeNumber = 49;
        _unicodeChar = "";
        _unicodeChar = ([_unicodeNumber] call CBA_fnc_unicodeToChar);
        //_unicodeChar will return "1"
    (end)

Author:
    Vincent Heins
---------------------------------------------------------------------------- */

params [["_unicodeNumber", 0, [0, []]]];

if (_unicodeNumber isEqualType 0) then
{
    _unicodeNumber = [_unicodeNumber];
};

(toString _unicodeNumber);
//old thought: (str parseText format["&#%1;", _unicodeNumber]);

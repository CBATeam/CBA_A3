/* ----------------------------------------------------------------------------
Function: CBA_fnc_unicodeNumberToChar
Description:
    Gets the unicode char of the given unicode number
    For more information to unicodes visit: https://unicode-table.com/
Parameters:
    (number/integer/scalar) _unicodeNumber = the unicode number
Returns:
    (string) given unicode char
Examples:
    (begin example)
        _unicodeNumber = 49;
        _unicodeChar = "";
        _unicodeChar = ([_unicodeNumber] call CBA_fnc_unicodeNumberToChar);
        //_unicodeChar will return "1"
    (end)
Author:
    Vincent Heins
---------------------------------------------------------------------------- */

params [["_unicodeNumber", 0, [0]]];

(str parseText format["&#%1;", _unicodeNumber]);

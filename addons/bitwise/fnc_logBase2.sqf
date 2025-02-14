/* ----------------------------------------------------------------------------
Function: CBA_fnc_logBase2

Description:
    Returns the Base-2 (binary) logarithm of the specified number.

    * This function converts all inputs into positive numbers. 
    * This function returns a non-negative number (with the exception of negative infinity for an input of 0).

Parameters:
    _num   -   a number <NUMBER>

Returns:
    Binary logarithm of _num <NUMBER>

Examples:
    (begin example)
        8 call CBA_fnc_logBase2; // returns 3

        -7.62 call CBA_fnc_logBase2; // returns 2.93
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
private _num = _this param [0,1,[0]];
(ln (abs _num))*1.44269502162933349609
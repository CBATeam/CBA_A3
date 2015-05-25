/* -----------------------------------------------------------------------------
Function: CBA_fnc_floatToString

Description:
	Returns a higher precision string representation of a IEEE 754 floating point
    number than the str function. This function is as barebones as possible. Inline 
    macro version of this function can be used with FLOAT_TO_STRING(num).
    
Limitations:
	

Parameters:
	_number - Number to format [Number]

Returns:
	The number formatted into a string.

Examples:
	(begin example)
		_str = 100.12345678 call CBA_fnc_floatToString; // _str = "100.123459", using (str 100.12345678) results in "100.123"
        _str = 2000.1236 call CBA_fnc_floatToString; // _str = "2000.1236570", using (str 2000.1236) results in "2000.12"
	(end)

Author:
	Nou
---------------------------------------------------------------------------- */

str parseNumber (str (_this%_this) + str floor abs _this) + "." + (str (abs _this-floor abs _this) select [2]) + "0";
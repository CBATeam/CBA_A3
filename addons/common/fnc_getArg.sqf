/* ----------------------------------------------------------------------------
Function: CBA_fnc_getArg

Description:
    Get default named argument from list.

Parameters:

Returns:

Examples:
    (begin example)

    (end)

Author:
    Kronzky (www.kronzky.info)
---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(getArg);

private["_cLC", "_cUC", "_arg", "_list", "_a", "_v"];
_cLC = _this select 0; 
_cUC = _this select 1; 
_arg = _this select 2; 
_list = _this select 3; 

_a = -1;
{
    _a = _a + 1; 
    _v = format["%1", _list select _a]; 
    if (_v == _cLC || {_v == _cUC}) then { 
        _arg = (_list select _a+1);
    };
} forEach _list;
_arg

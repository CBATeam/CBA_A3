#include "script_component.hpp"
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
SCRIPT(getArg);

params ["_cLC", "_cUC", "_arg", "_list"]

private _a = -1;
{
    _a = _a + 1; 
    private _v = format["%1", _list select _a]; 
    if (_v == _cLC || {_v == _cUC}) then { 
        _arg = (_list select _a+1);
    };
} forEach _list;
_arg

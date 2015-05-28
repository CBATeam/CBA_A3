/*
Function: CBA_fnc_globalExecute

Description:
    Executes code on given destinations

Parameters:
    _channel - All: -2, ClientsOnly: -1, ServerOnly: 0 [Integer]
    _code - Code to execute [Code]
    _parameter - OPTIONAL. Parameter to pass to the code in the _this variables [Any]

Returns:

Example:
    (begin example)
        [-1, {player globalChat _this}, "TEST"] call CBA_fnc_globalExecute;
    (end)

Author:
    Sickboy
*/
#include "script_component.hpp"
TRACE_1("",_this);
[QGVAR(cmd), [call FUNC(id), _this]] call CBA_fnc_globalEvent;

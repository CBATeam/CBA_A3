/*
Function: CBA_fnc_globalExecute

Description:
    Executes code on given destinations. DEPRECATED. Use remoteExec instead.

Parameters:
    _channel    - All: -2, ClientsOnly: -1, ServerOnly: 0 [Integer]
    _code       - Code to execute [Code]
    _parameters - OPTIONAL. Parameter to pass to the code in the _this variables [Any]

Returns:

Example:
    (begin example)
        [-1, {player globalChat _this}, "TEST"] call CBA_fnc_globalExecute;
    (end)

Author:
    Sickboy, commy2
*/
#include "script_component.hpp"

#define CBA_SEND_TO_ALL -2
#define CBA_SEND_TO_CLIENTS_ONLY -1
#define CBA_SEND_TO_SERVER_ONLY 0

#define BI_SEND_TO_ALL 0
#define BI_SEND_TO_CLIENTS_ONLY -2
#define BI_SEND_TO_SERVER_ONLY 2

params [["_channel", CBA_SEND_TO_ALL, [CBA_SEND_TO_ALL]], ["_code", {}, [{}]], ["_parameters", []]];

// translate CBA channel to BI channel
_channel = [
    BI_SEND_TO_ALL,
    BI_SEND_TO_CLIENTS_ONLY,
    BI_SEND_TO_SERVER_ONLY
] param [[
    CBA_SEND_TO_ALL,
    CBA_SEND_TO_CLIENTS_ONLY,
    CBA_SEND_TO_SERVER_ONLY
] find _channel];

// we want to execute ClientsOnly on dedicated clients and SP clients too
if (_channel isEqualTo BI_SEND_TO_CLIENTS_ONLY) then {
    _channel = BI_SEND_TO_ALL;
    _parameters = [_parameters, _code];
    _code = {if (!isDedicated) then {(_this select 0) call (_this select 1)}};
};

[_parameters, _code] remoteExec ["BIS_fnc_Call", _channel];

nil

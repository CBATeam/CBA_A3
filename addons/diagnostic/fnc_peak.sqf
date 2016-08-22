/* ----------------------------------------------------------------------------
Function: CBA_fnc_peak

Description:
    Peak at variable on the server.

    To receive the variable content back, you will have to:
    ["cba_diagnostic_receivePeak", {_this call myFunction}] call CBA_fnc_addEventHandler;

Parameters:
    _varName - Variable name <STRING>

Returns:
    nil

Author:
    Sickboy
-----------------------------------------------------------------------------*/
#include "script_component.hpp"
SCRIPT(peak);

params ["_varName"];

[QGVAR(peak), [_varName, CBA_clientID]] call CBA_fnc_serverEvent;

nil

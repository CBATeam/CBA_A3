/* ----------------------------------------------------------------------------
Function: CBA_fnc_diagLogGlobalWriter

Description:
    Writes supplied message to diag_log on every connected client and server.

    This is intended to be used in combination with CBA_fnc_logDynamic.

Parameters:
    _message - Log message [String]

Returns:
    nil

Author:
    MikeMatrix
---------------------------------------------------------------------------- */
#include "script_component.hpp"

SCRIPT(diagLogGlobalWriter);

params ["_message"];

[-2, {diag_log text _this}, _message] call CBA_fnc_globalExecute;

nil

/* ----------------------------------------------------------------------------
Function: CBA_fnc_hintGlobalWriter

Description:
    Writes supplied message with hint on every connected client and server.

    This is intended to be used in combination with CBA_fnc_logDynamic.

Parameters:
    _message - Log message [String]

Returns:
    nil

Author:
    MikeMatrix
---------------------------------------------------------------------------- */
#include "script_component.hpp"

SCRIPT(hintGlobalWriter);

params ["_message"];

[-2, {hint _this}, _message] call CBA_fnc_globalExecute;

nil

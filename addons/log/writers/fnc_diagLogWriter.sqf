/* ----------------------------------------------------------------------------
Function: CBA_fnc_diagLogWriter

Description:
    Writes supplied message to diag_log.

    This is intended to be used in combination with CBA_fnc_logDynamic.

Parameters:
    _message - Log message [String]

Returns:
    nil

Author:
    MikeMatrix
---------------------------------------------------------------------------- */
#include "script_component.hpp"

SCRIPT(diagLogWriter);

params ["_message"];

diag_log text _message;

nil

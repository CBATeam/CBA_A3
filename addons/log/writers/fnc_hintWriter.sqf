/* ----------------------------------------------------------------------------
Function: CBA_fnc_hintWriter

Description:
    Writes supplied message with hint.

    This is intended to be used in combination with CBA_fnc_logDynamic.

Parameters:
    _message - Log message [String]

Returns:
    nil

Author:
    MikeMatrix
---------------------------------------------------------------------------- */
#include "script_component.hpp"

SCRIPT(hintWriter);

params ["_message"];

hint _message;

nil

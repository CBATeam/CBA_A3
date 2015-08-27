/* ----------------------------------------------------------------------------
Function: CBA_fnc_systemChatLogWriter

Description:
    Writes supplied message to systemChat.

    This is intended to be used in combination with CBA_fnc_logDynamic.

Parameters:
    _message - Log message [String]

Returns:
    nil

Author:
    MikeMatrix
---------------------------------------------------------------------------- */
#include "script_component.hpp"

SCRIPT(systemChatLogWriter);

params ["_message"];

systemChat _message;

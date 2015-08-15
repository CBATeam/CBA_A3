/* ----------------------------------------------------------------------------
Function: CBA_fnc_systemChat

Description:
    Display a message in the global chat channel.

Parameters:
    _message - the message to display [String]

Returns:
    nothing

Examples:
    (begin example)
    "Hello, world!" call CBA_fnc_systemChat
    (end)

Author:
    Killswitch
---------------------------------------------------------------------------- */

#include <script_component.hpp>

params ["_message"];

CBA_logic globalChat _message;


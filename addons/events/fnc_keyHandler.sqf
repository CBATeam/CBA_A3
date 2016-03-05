/* ----------------------------------------------------------------------------
Internal Function: CBA_events_fnc_keyHandler
Description:
    Executes the key's handler, bwc for ace interaction menu
Author:
    commy2
---------------------------------------------------------------------------- */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"
SCRIPT(keyHandler);

params ["_args", "_type"];

_args call ([FUNC(keyHandlerDown), FUNC(keyHandlerUp)] select (_type == "keyUp"));

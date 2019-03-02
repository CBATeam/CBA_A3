#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_actionArgument

Description:
    Used to call the code parsed in the addaction argument.

Parameters:

Returns:

Examples:
    (begin example)
        captive addaction ["rescue",CBA_fnc_actionargument_path,[[],{[_target] join (group _caller)},true]] //captive joins action callers group, action is removed (true)
    (end)

Author:
    Rommel
---------------------------------------------------------------------------- */
SCRIPT(actionArgument);

params ["_target", "_caller", "_id", "_arguments"];

(_arguments select 0) call (_arguments select 1);

if (_arguments param [2, false]) then {
    _target removeAction _id;
};

#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_fnc_initWaitAndExecPFH

Description:
    Initialises a PFH observing a queue of a certain command type

Parameters:
    _command - Array that defines the action, as used in addAction command [Array]
    _inverse - Whether to inverse the conditions and sorting order. [Boolean]

Returns:
    Created PFH handle [Number]

Example:
    (begin example)
        _handle = ["diag_tickTime",false] call CBA_fnc_initWaitAndExecPFH;
    (end)

Author:
    Freddo

---------------------------------------------------------------------------- */

params [["_command","diag_tickTime",[""]],["_inverse",false,[true]]];

LOG_2("Registering waitAndExecPFH for command", _command, _inverse);

private _handle = [compile format [QUOTE(                                                      \
    if (!GVAR(TRIPLES(waitAndExec,%1,ArrayIsSorted))) then {                                   \
        GVAR(TRIPLES(waitAndExec,%1,Array)) sort %3;                                           \
        GVAR(TRIPLES(waitAndExec,%1,ArrayIsSorted)) = true;                                    \
    };                                                                                         \
    private _delete = false;                                                                   \
    {                                                                                          \
        if (_x select 0 %2 %1) exitWith {};                                                    \
                                                                                               \
        (_x select 2) call (_x select 1);                                                      \
                                                                                               \
        GVAR(TRIPLES(waitAndExec,%1,Array)) set [ARR_2(_forEachIndex, objNull)];               \
        _delete = true;                                                                        \
    } forEach GVAR(TRIPLES(waitAndExec,%1,Array));                                             \
    if (_delete) then {                                                                        \
        GVAR(TRIPLES(waitAndExec,%1,Array)) = GVAR(TRIPLES(waitAndExec,%1,Array)) - [objNull]; \
        _delete = false;                                                                       \
    };                                                                                         \
),_command, [">","<"] select _inverse, !_inverse]] call CBA_fnc_addPerFrameHandler;

_handle

#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_fnc_initWaitAndExecPFH

Description:
    Initialises a PFH observing a queue of a certain command type

Parameters:
    _queue   - Which queue this function will be assigned to [String]
    _command - Command evaluated to get the current value [String]
    _inverse - Whether to inverse the conditions and sorting order. [Boolean]

Returns:
    Created PFH handle [Number]

Example:
    (begin example)
        _handle = ["_queue","diag_tickTime",false] call CBA_fnc_initWaitAndExecPFH;
    (end)

Author:
    Freddo

---------------------------------------------------------------------------- */

params [["_queue","diag_tickTime",[""]],["_command","diag_tickTime",[""]],["_inverse",false,[true]]];

LOG_2("Registering waitAndExecPFH for command", _command, _inverse);

private _handle = [compile format [QUOTE(                                                      \
    if (!GVAR(TRIPLES(waitAndExec,%1,ArrayIsSorted))) then {                                   \
        GVAR(TRIPLES(waitAndExec,%1,Array)) sort %4;                                           \
        GVAR(TRIPLES(waitAndExec,%1,ArrayIsSorted)) = true;                                    \
    };                                                                                         \
    private _delete = false;                                                                   \
    {                                                                                          \
        if (_x select 0 %3 (%2)) exitWith {};                                                  \
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
),_queue,_command, [">","<"] select _inverse, !_inverse]] call CBA_fnc_addPerFrameHandler;

_handle

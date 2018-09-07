#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_deleteNamespace

Description:
    Deletes a namespace created with CBA_fnc_createNamespace.

Parameters:
    _namespace - a namespace <LOCATION>

Returns:
    None

Examples:
    (begin example)
        _namespace call CBA_fnc_deleteNamespace;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(deleteNamespace);

params [["_namespace", locationNull, [locationNull, objNull]]];

_namespace call CBA_fnc_deleteEntity;

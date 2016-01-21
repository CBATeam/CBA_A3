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
#include "script_component.hpp"

params [["_namespace", locationNull, [locationNull]]];

deleteLocation _namespace;

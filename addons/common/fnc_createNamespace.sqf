/* ----------------------------------------------------------------------------
Function: CBA_fnc_createNamespace

Description:
    Creates a namespace. Used to store and read variables via setVariable and getVariable.
    The Namespace is destroyed after the mission ends. getVariable ARRAY is not supported.

Parameters:
    None

Returns:
    _namespace - a namespace <LOCATION>

Examples:
    (begin example)
        _namespace = call CBA_fnc_createNamespace;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

createLocation ["CBA_NamespaceDummy", [-1000, -1000, 0], 0, 0]

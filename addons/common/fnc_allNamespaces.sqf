/* ----------------------------------------------------------------------------
Function: CBA_fnc_allNamespaces

Description:
    Reports namespaces created with CBA_fnc_createNamespace.

Parameters:
    None

Returns:
    _namespaces - all custom namespaces <ARRAY of LOCATION, OBJECT>

Examples:
    (begin example)
        _namespaces = call CBA_fnc_allNamespaces;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(allNamespaces);

nearestLocations [DUMMY_POSITION, ["CBA_NamespaceDummy"], 1] + (nearestObjects [ASLToAGL DUMMY_POSITION, [], 1] select {typeOf _x isEqualTo "CBA_NamespaceDummy"})

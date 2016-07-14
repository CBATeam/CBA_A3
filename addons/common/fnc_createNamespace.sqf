/* ----------------------------------------------------------------------------
Function: CBA_fnc_createNamespace

Description:
    Creates a namespace. Used to store and read variables via setVariable and getVariable.

    The Namespace is destroyed after the mission ends. getVariable ARRAY is not supported.

Parameters:
    _isGlobal - create a global namespace (optional, default: false) <BOOLEAN>

Returns:
    _namespace - a namespace <LOCATION, OBJECT>

Examples:
    (begin example)
        _namespace = call CBA_fnc_createNamespace;

        My_GlobalNamespace = true call CBA_fnc_createNamespace;
        publicVariable "My_GlobalNamespace";
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(createNamespace);

#define DUMMY_POSITION [-1000, -1000, 0]

params [["_isGlobal", false]];

if (_isGlobal isEqualTo true) then {
    createVehicle ["CBA_NamespaceDummy", DUMMY_POSITION, [], 0, "NONE"]
} else {
    createLocation ["CBA_NamespaceDummy", DUMMY_POSITION, 0, 0]
};

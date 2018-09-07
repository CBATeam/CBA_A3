#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_deserializeNamespace

Description:
    Creates namespace containing all variables stored in a CBA hash.

Parameters:
    _hash     - a hash <ARRAY>
    _isGlobal - create a global namespace (optional, default: false) <BOOLEAN>

Returns:
    _namespace - a namespace <LOCATION, OBJECT>

Examples:
    (begin example)
        private _hash = profileNamespace getVariable "My_serializedNamespace";
        My_namespace = [_hash] call CBA_fnc_deserializeNamespace;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(deserializeNamespace);

params [["_hash", [], [[]]], ["_isGlobal", false, [false]]];

private _namespace = _isGlobal call CBA_fnc_createNamespace;

if (_isGlobal) then {
    [_hash, {
        _namespace setVariable [_key, _value, true];
    }] call CBA_fnc_hashEachPair;
} else {
    [_hash, {
        _namespace setVariable [_key, _value];
    }] call CBA_fnc_hashEachPair;
};

_namespace

#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_serializeNamespace

Description:
    Creates CBA hash containing all variables stored in a namespace.

Parameters:
    _namespace - a namespace <LOCATION, OBJECT>
    _defaultValue - Default value. Used when key doesn't exist. A key is also removed from the hash if the value is set to this default [Any, defaults to nil]

Returns:
    _hash - a hash <ARRAY>

Examples:
    (begin example)
        private _hash = _namespace call CBA_fnc_serializeNamespace;
        profileNamespace setVariable ["My_serializedNamespace", _hash];
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(serializeNamespace);

params [["_namespace", locationNull, [locationNull, objNull]], "_defaultValue"];

private _hash = [[], RETNIL(_defaultValue)] call CBA_fnc_hashCreate;

{
    [_hash, _x, _namespace getVariable _x] call CBA_fnc_hashSet;
} forEach allVariables _namespace;

_hash

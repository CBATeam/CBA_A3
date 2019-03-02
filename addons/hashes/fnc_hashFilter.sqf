#include "script_component.hpp"
#include "script_hashes.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_hashFilter

Description:
    Iterate through all keys and values in a Hash.
    If function returns false, the key is removed from the hash (just like `[] select {}`)

    Data passed to the function on each iteration,
    * _key - Key from the Hash.
    * _value - The value from the Hash corresponding to _key.

    See <CBA_fnc_hashCreate>.

Parameters:
    _hash - Hash to iterate [Array which is a Hash structure]
    _code - Function to call with each pair which returns a bool (false will remove key from hash) [Code]

Returns:
    Number of removed entrys [Number]

Example:
    (begin example)
    _hash = [[["A1", 1], ["A2", 1], ["B", 2], ["C", 3], ["D1", 4], ["D2", 4], ["E1", 5], ["E2", 5]]] call CBA_fnc_hashCreate;
    _removeOddValues = {
        diag_log format ["Key: %1, Value: %2", _key, _value];
        ((_value % 2) == 0)
    };
    _removedCount = [_hash, _removeOddValues] call CBA_fnc_hashFilter;
    (end)

Author:
    PabstMirror
---------------------------------------------------------------------------- */

SCRIPT(hashFilter);

// -----------------------------------------------------------------------------
params [["_hash", [], [[]]], ["_code", {}, [{}]]];

_hash params ["", "_keys", "_values"];

private _removedKeys = 0;

{
    private _key = _x;
    private _index = _forEachIndex - _removedKeys;
    private _value = _values select _index;
    if (!(call _code)) then { // If code returns false, delete the key/value from hash
        _keys deleteAt _index;
        _values deleteAt _index;
        _removedKeys = _removedKeys + 1;
    };
    nil
} forEach +_keys; // Create copy of _keys as the original can be modified during iteration

_removedKeys // Return.

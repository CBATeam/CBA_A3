/* ----------------------------------------------------------------------------
Function: CBA_fnc_hashFilter

Description:
    Iterate through all keys and values in a Hash.
    If function returns true, the key is removed from the hash.

    Data passed to the function on each iteration,
    * _key - Key from the Hash.
    * _value - The value from the Hash corresponding to _key.

    See <CBA_fnc_hashCreate>.

Parameters:
    _hash - Hash to iterate [Array which is a Hash structure]
    _code - Function to call with each pair which returns a bool (true will remove key from hash) [Code]

Returns:
    Number of removed entrys [Number]

Example:
    (begin example)
    _hash = [[["A1", 1], ["A2", 1], ["B", 2], ["C", 3], ["D1", 4], ["D2", 4], ["E1", 5], ["E2", 5]]] call CBA_fnc_hashCreate;
    _removeOddValues = {
        diag_log format ["Key: %1, Value: %2", _key, _value];
        ((_value % 2) == 1)
    };
    _removedCount = [_hash, _removeOddValues] call CBA_fnc_hashFilter;
    (end)

Author:
    PabstMirror
---------------------------------------------------------------------------- */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
#include "script_hashes.hpp"

SCRIPT(hashFilter);

// -----------------------------------------------------------------------------
params [["_hash", [], [[]]], ["_code", {}, [{}]]];

_hash params ["", "_keys", "_values"];

private _removedKeys = 0;

{
    private _key = _x;
    private _index = _forEachIndex - _removedKeys;
    private _value = _values select _index;
    if (call _code) then { // If code returns true, delete the key/value from hash
        _keys deleteAt _index;
        _values deleteAt _index;
        _removedKeys = _removedKeys + 1;
    };
    nil
} forEach +_keys; // Create copy of _keys as the original can be modified during iteration

_removedKeys // Return.

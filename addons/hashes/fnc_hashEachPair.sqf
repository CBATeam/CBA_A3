/* ----------------------------------------------------------------------------
Function: CBA_fnc_hashEachPair

Description:
    Iterate through all keys and values in a Hash.

    Data passed to the function on each iteration,
    * _key - Key from the Hash.
    * _value - The value from the Hash corresponding to _key.

    See <CBA_fnc_hashCreate>.

Parameters:
    _hash - Hash to iterate [Array which is a Hash structure]
    _code - Function to call with each pair [Any]

Returns:
    nil

Example:
    (begin example)
    _dumpHash = {
        diag_log format ["Key: %1, Value: %2", _key, _value];
    };

    [_hash, _dumpHash] call CBA_fnc_hashEachPair;
    (end)

Author:
    Spooner
---------------------------------------------------------------------------- */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
#include "script_hashes.hpp"

SCRIPT(hashEachPair);

// -----------------------------------------------------------------------------

params ["_hash","_code"];

_hash params ["", "_keys", "_values"];

{
    private _key = _x;
    private _value = _values select _forEachIndex;
    TRACE_2("VM CHECK",_key,_value);
    call _code;
} forEach _keys;

nil; // Return.

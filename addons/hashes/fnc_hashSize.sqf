#include "script_component.hpp"
#include "script_hashes.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_hashSize

Description:
   Get number of elements in a Hash.

Parameters:
    _hash - Hash to check size of <ARRAY>(CBA HASH)

Returns:
    Size of the Hash or -1 if the argument is not a Hash <NUMBER>

Examples:
(begin code)
    _emptyHash = [] call CBA_fnc_hashCreate;
    [_emptyHash] call CBA_fnc_hashSize; // => 0

    _animalCounts = [[["frog", 12], ["fish", 9]]] call CBA_fnc_hashCreate;
    [_animalCounts] call CBA_fnc_hashSize; // => 2
(end code)

Author:
    Killswitch
---------------------------------------------------------------------------- */

SCRIPT(hashSize);

params ["_hash"];

if ([_hash] call CBA_fnc_isHash) then {
    count (_hash select HASH_KEYS)
} else {
    -1
};

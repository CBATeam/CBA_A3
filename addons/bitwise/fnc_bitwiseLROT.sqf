/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitwiseLROT

Description:
    Performs a bitwise LEFT-ROTATE-NO-CARRY operation on a given number. Bits that are both 1 are summed.

    * This function returns a non-negative integer.
    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will cause unexpected behavior.
    
Parameters:
    _num    -   the number to rotate <NUMBER>
    _numRot -   the number of rotations to perform <NUMBER>

Returns:
    Rotated number on success, false otherwise. <NUMBER or BOOLEAN>

Examples:
    (begin example)
        25 call CBA_fnc_bitwiseLROT; // returns 19
        // 25's set bits                                = 11001 (16+8+1) 
        // shift left by 1, move leftmost bit to back   = 10011 (16+2+1)
        // sum of rotated bits = 19

        [25,2] call CBA_fnc_bitwiseLROT; // returns 7
        // rotates once to  10011 (19)
        // rotates twice to 00111 (7)
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
#define BITREP(num,pow) ((floor (num / pow)) mod 2)
#define BASE2LOG(num) ((ln num)*1.44269502162933349609)
params [["_num",1,[0]],["_numRot",1,[0]]];
_num = floor abs _num;
_numRot = floor abs _numRot;
private _exp = floor BASE2LOG(_num);
private _power = 2^_exp;
private _power1 = _power * 2; // 2^_exp+1
private _bit = 0;
if (_numRot > _exp) then {_numRot = _numRot % _exp};
for "_i" from 1 to _numRot do {
	_bit = BITREP(_num,_power);
	_num = (2*_num) - (_bit * _power1) + _bit;
};
_num
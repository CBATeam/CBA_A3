/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitwiseLROT

Description:
    Performs a bitwise LEFT-ROTATE-NO-CARRY operation on a given number. Bits that are both 1 are summed.

Parameters:
    _num    -   the number to rotate <NUMBER>
    _numRot -   the number of rotations to perform <NUMBER>

Returns:
    Rotated number on success, false otherwise. <NUMBER or BOOLEAN>

Examples:
    (begin example)
        25 call CBA_fnc_bitwiseLROT; // returns 19
        // 25's set bits = 16+8+1 
        // 25's set bits (binary) = 11001
        // shift left by 1, move leftmost bit to back = 10011
        // new bits = (2^4)+(2^1)+(2^0) OR 16+2+1
        // sum of rotated bits = 19

        [25,2] call CBA_fnc_bitwiseLROT; // returns 7
        // rotates once to 10011 (19)
        // rotates again to 00111 (7)
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
params [["_num",1,[0]],["_numRot",1,[0]]];
_num = floor abs _num;
_numRot = floor abs _numRot;
private _exp = floor((ln _num)*1.44269502162933349609);
if (_numRot > _exp) then {
    // modulo vs clamp??? 
    // how much of a performace hit would it take i wonder
    _numRot = _numRot % _exp;
    // _numRot = _exp;
    };
private _bit = 0;
for "_i" from 1 to _numRot do {
	_bit = (floor(_num / 2^_exp)) % 2;
	_num = (2*_num) - (_bit * 2^(_exp+1)) + _bit;
};
_num
// bitwiseLSROT
params [["_num",1,[0]],["_numRot",1,[0]]];
_num = floor abs _num;
_numRot = floor abs _numRot;
private _power = 2^(floor((ln _num)*1.44269502162933349609));
private _bit = 0;
for "_i" from 1 to _numRot do {
	_bit = (floor(_num / _power)) % 2;
	_num = (2*_num) - (_bit * _power * 2) + _bit;
};
_num
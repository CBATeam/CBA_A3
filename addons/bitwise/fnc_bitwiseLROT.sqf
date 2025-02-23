/* ----------------------------------------------------------------------------
Function: CBA_fnc_bitwiseLROT

Description:
    Performs a bitwise LEFT-ROTATE-NO-CARRY operation on a given number. Bits that are both 1 are summed.
    
    * This function converts all inputs into positive integers.
    * Values above 2^24 suffer inaccuracy at the hands of the Virtual Reality Engine. Inputs exceeding this value will error.
    
Parameters:
    _num        -   the number to rotate <NUMBER>
    _numRot     -   the number of rotations to perform <NUMBER>
    _numBits    -   the number of bits this number should occupy (optional) <NUMBER>

Returns:
    Rotated number on success, -1 otherwise. <NUMBER>

Examples:
    (begin example)
        25 call CBA_fnc_bitwiseLROT; // returns 19
        // 25's set bits                =   11001 (16,8,1) 
        // shift left by 1              =  11001_
        // move leftmost bit to back    =   10011 (16,2,1)
        // sum of rotated bits = 19

        [25,2] call CBA_fnc_bitwiseLROT; // returns 7
        // rotates once to      10011 (19)
        // rotates twice to     00111 (7)

        [25,2,6] call CBA_fnc_bitwiseLROT; // returns 37
        // 25's set bits       011001
        // rotates once to     110010 (50)
        // rotates twice to    100101 (37)
    (end)

Author:
    Daisy
---------------------------------------------------------------------------- */
#define BITGRAB(num,pow) ((floor (num / pow)) mod 2)
#define BASE2LOG(num) ((ln num)*1.44269502162933349609)
#define BITQUANT(num) floor BASE2LOG(num) + 1

params [["_num",0,[0]],["_numRot",0,[0]],"_numBits"];

_num = floor abs _num;
_numRot = floor abs _numRot;

private _bitCount = BITQUANT(_num);
if (!isNil "_numBits" && {_numBits isEqualType 0 && {_numBits > _bitCount}}) then {_bitCount = (floor abs _numBits)};
if (_bitCount > 24) exitWith {-1};
if (_numRot > _bitCount) then {_numRot = _numRot % _bitCount;}; // trim excess rotations

private _power = 0;
private _amend = 0;

if (_numRot > (_bitCount / 2)) exitWith {
	_numRot = _numRot - (floor (_bitCount / 2));

	for "_i" from 0 to _numRot-1 do {
        _power = 2^_i;
        _amend = _amend + (BITGRAB(_num,_power) * (_power * 2^_numBits)); // _pow * 2^_numBits == 2^(_i + _numBits)
    };

    floor ((_num + _amend) / 2^_numRot) // sum and bitshift right
};

_num = 2^_numRot * _num; // bitshift left by numRot
for "_i" from _bitCount to (_bitCount + _numRot) do { // check bits over limit
	_power = 2^_i;
	_amend = _amend + (BITGRAB(_num,_power) * (_power - 2^(_i - _bitCount)));
};

_num - _amend
//bitwiseOR; #####################################################
_this = _this apply {floor abs _x};
_this sort true;
params [["_min",0,[0]],["_max",1,[0]]];
private _end = floor ((ln _max)*1.44269502162933349609); //1/ln(2) = 1.44269502162933349609
if (_end >= 24) exitWith {false}; // precision drop after 2^24 (16777216)
private _power = 0;
private _return = 0;
private _maxBit = 0;
private _minBit = 0;
for "_i" from 0 to _end do { 
	_power = 2^_i;
	_maxBit = (floor (_max / _power)) % 2;
	_minBit = (floor (_min / _power)) % 2;
	_return = _return + (_power * ((_maxBit + _minBit) - (_maxBit * _minBit)));
};
_return
// bitwiseNOT ####################################################
params [["_num",1,[0]]];
_num = floor abs _num;
(2^((floor((ln _num)*1.44269502162933349609))+1))-1-_num;
// bitwiseAND
_this = _this apply {floor abs _x};
_this sort true;
params [["_min",0,[0]],["_max",1,[0]]];
private _end = floor ((ln _min)*1.44269502162933349609); //1/ln(2) = 1.44269502162933349609
if (_end >= 24) exitWith {false}; // precision drop after 2^24 (16777216)
private _power = 0;
private _return = 0;
for "_i" from 0 to _end do {
	_power = 2^_i;
	_return = _return + (_power * (((floor (_max / _power))%2)*((floor (_min / _power)))%2));
};
_return
//bitwiseXOR #####################################################
_this sort true;
params [["_min",0,[0]],["_max",1,[0]]];
_min = floor abs _min;
_max = floor abs _max;
private _end = floor ((ln _max)*1.44269502162933349609); //1/ln(2) = 1.44269502162933349609
if (_end >= 24) exitWith {false}; // precision drop after 2^24 (16777216)
private _power = 0;
private _return = 0;
for "_i" from 0 to _end do {
	_power = 2^_i;
	_return = _return + (_power * ((((floor (_max / _power)) % 2) + ((floor (_min / _power)) % 2)) % 2));
};  
_return
// bitwiseRSHIFT #################################################
params [["_num",1,[0]],["_numShift",0,[0]]];
_num = floor _num;
_numShift = floor _numShift;
floor (_num / 2^_numShift)
// bitwiseLSHIFT #################################################
params [["_num",1,[0]],["_numShift",0,[0]]];
_num = floor _num;
_numShift = floor _numShift;
_num * 2^_numShift

// bitwiseLSROT ##################################################
params [["_num",1,[0]],["_numRot",1,[0]]];
_num = floor abs _num;
_numRot = floor abs _numRot;
private _exp = floor((ln _num)*1.44269502162933349609);
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

// bitwiseRSROT ##################################################
params [["_num",1,[0]],["_numRot",1,[0]]];
_num = floor abs _num;
_numRot = floor abs _numRot;
private _exp = floor((ln _num)*1.44269502162933349609);
for "_i" from 1 to _numRot do {
	_num = (floor (_num / 2)) + ((_num % 2) * 2^_exp);
};
_num
// bitwiseRSROT
params [["_num",1,[0]],["_numRot",1,[0]]];
_num = floor abs _num;
_numRot = floor abs _numRot;
private _power = 2^(floor((ln _num)*1.44269502162933349609));
for "_i" from 1 to _numRot do {
	_num = (floor (_num / 2)) + ((_num % 2) * _power);
};
_num

//bitflagsSet ####################################################
params [["_flagset",1,[0]],["_flags",0,[0]]];
[_flagset,_flags] call CBA_fnc_bitwiseOR;

//bitflagsUnset ##################################################
params [["_flagset",1,[0]],["_flags",0,[0]]];
[_flagset,_flags call CBA_fnc_bitwiseNOT] call CBA_fnc_bitwiseAND;

//bitflagsFlip ###################################################
params [["_flagset",1,[0]],["_flags",0,[0]]];
[_flagset,_flags] call CBA_fnc_bitwiseXOR;

//bitflagsCheck ##################################################
params [["_flagset",1,[0]],["_flags",0,[0]]];
[_flagset,_flags] call CBA_fnc_bitwiseAND;

//bitflagsCheckBool ##############################################
params [["_flagset",1,[0]],["_flags",0,[0]]];
[_flagset,_flags] call CBA_fnc_bitwiseAND > 0

//bitflagsCheckToArray ###########################################
params [["_flagset",1,[0]],["_flags",0,[0]]];
private _end = floor ((ln _flags)*1.44269502162933349609); //1/ln(2) = 1.44269502162933349609
if (_end >= 24) exitWith {false}; // precision drop after 2^24 (16777216)
private _power = 0;
private _return = [];
for "_i" from 0 to _end do {
	_power = 2^_i;
	_return pushBack (_power * (((floor (_flagset / _power))%2)*((floor (_flags / _power))%2)));
};
_return
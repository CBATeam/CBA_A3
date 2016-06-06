
#define LOGF diag_log text format
#define TESTEXP if (!isNil "_result" && {_result isEqualTo _expected}) then {LOGF ["TEST: OK - %1 result", _result]} else {LOGF ["TEST: FAIL - %1 result; %2 expected", _result, _expected]}

////////////////////////////////////////////////////////////////////////////////////////////////////

_fnc_name = "CBA_fnc_weaponComponents";
_fnc = call compile _fnc_name;

LOGF ["========== TEST ========== - %1 -", _fnc_name];
if (!isNil "_fnc") then {LOGF ["TEST: OK - %1 defined", _fnc_name]} else {LOGF ["TEST: FAIL - %1 undefined"]};

_result = "" call _fnc;
_expected = [];
TESTEXP;

_result = "arifle_MX_F" call _fnc;
_expected = ["arifle_mx_f"];
TESTEXP;

_result = "arifle_MXC_Holo_pointer_snds_F" call _fnc;
_expected = ["arifle_mxc_f","optic_holosight","muzzle_snds_h","acc_pointer_ir"];
TESTEXP;

_result = ["arifle_MXM_DMS_LP_BI_snds_F"] call _fnc;
_expected = ["arifle_mxm_f","optic_dms","acc_pointer_ir","bipod_01_f_snd","muzzle_snds_h"];
TESTEXP;

_result = "arifle_MXC_Black_F" call _fnc;
_expected = ["arifle_mxc_black_f"];
TESTEXP;

_result = "Laserdesignator_02" call _fnc;
_expected = ["laserdesignator_02"];
TESTEXP;

_result = ["FirstAidKit"] call _fnc;
_expected = ["firstaidkit"];
TESTEXP;

_result = "H_Cap_marshal" call _fnc;
_expected = ["h_cap_marshal"];
TESTEXP;

_result = ["B_Soldier_F"] call _fnc;
_expected = [];
TESTEXP;

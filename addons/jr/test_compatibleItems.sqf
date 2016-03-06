// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL
#include "script_component.hpp"

SCRIPT(test_compatibleItems);

// ----------------------------------------------------------------------------

LOG('Testing JR Compatible Items');

// UNIT TESTS (polar2vect)
private _fn = "CBA_fnc_compatibleItems";
TEST_DEFINED("CBA_fnc_compatibleItems","");

private _result = [] call CBA_fnc_compatibleItems;
private _expected = [];
TEST_DEFINED_AND_OP(_result,isEqualTo,_expected,_fn);

_result = ["aGunThatDoesNotExist"] call CBA_fnc_compatibleItems;
_expected = [];
TEST_DEFINED_AND_OP(_result,isEqualTo,_expected,_fn);

_result = [-1] call CBA_fnc_compatibleItems;
_expected = [];
TEST_DEFINED_AND_OP(_result,isEqualTo,_expected,_fn);

_result = [-1] call CBA_fnc_compatibleItems;
_expected = [];
TEST_DEFINED_AND_OP(_result,isEqualTo,_expected,_fn);

private _firstResult = ["LMG_Mk200_F"] call CBA_fnc_compatibleItems;
private _cachedResult = ["LMG_Mk200_F"] call CBA_fnc_compatibleItems;
TEST_DEFINED_AND_OP(_firstResult,isEqualTo,_cachedResult,_fn);

_result = ["LMG_Mk200_F", 99999] call CBA_fnc_compatibleItems; //invalid accesory type
_expected = [];
TEST_DEFINED_AND_OP(_result,isEqualTo,_expected,_fn);

_result = ["LMG_Mk200_F", 201] call CBA_fnc_compatibleItems; //201 should filter optics
TEST_TRUE("optic_tws_mg" in _result,_fn);
TEST_FALSE("muzzle_snds_h" in _result,_fn);

nil;

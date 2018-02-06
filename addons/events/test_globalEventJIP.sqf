// ----------------------------------------------------------------------------
#define DEBUG_SYNCHRONOUS
#include "script_component.hpp"

SCRIPT(test_globalEventJIP);

// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL

LOG("Testing globalEventJIP");

 // UNIT TESTS
TEST_DEFINED("CBA_fnc_globalEventJIP","");
TEST_DEFINED("CBA_fnc_removeGlobalEventJIP","");

// Add basic testing event handler:
GVAR(test_A) = 0;
[QGVAR(test_globalEventJIP), {GVAR(test_A) = _this}] call CBA_fnc_addEventHandler;

// Test adding globalEventJIP
private _ret = [QGVAR(test_globalEventJIP), 1] call CBA_fnc_globalEventJIP;
private _expected = 1;
TEST_DEFINED_AND_OP(GVAR(test_A),==,_expected,"Verify EH ran");
TEST_FALSE(isNil {GVAR(eventNamespaceJIP) getVariable _ret},"Verify in global event namespace");

// Test removing globalEventJIP
[_ret] call CBA_fnc_removeGlobalEventJIP;
TEST_TRUE(isNil {GVAR(eventNamespaceJIP) getVariable _ret},"Verify removed from global event namespace");

// Test removing on objNull
private _ret = [QGVAR(test_globalEventJIP), 2] call CBA_fnc_globalEventJIP;
[_ret, objNull] call CBA_fnc_removeGlobalEventJIP;
TEST_TRUE(isNil {GVAR(eventNamespaceJIP) getVariable _ret},"Verify deleted on null object");

// Test removing on non-null object
private _dummyObject = "Land_bakedBeans_F" createVehicle [0,0,0];
private _ret = [QGVAR(test_globalEventJIP), 3] call CBA_fnc_globalEventJIP;
[_ret, _dummyObject] call CBA_fnc_removeGlobalEventJIP;
TEST_FALSE(isNil {GVAR(eventNamespaceJIP) getVariable _ret},"Verify not removed");
deleteVehicle _dummyObject;
sleep 0.05;
TEST_TRUE(isNull _dummyObject,"Verify Object Deleted");
TEST_TRUE(isNil {GVAR(eventNamespaceJIP) getVariable _ret},"Verify removed when deleted");


nil;

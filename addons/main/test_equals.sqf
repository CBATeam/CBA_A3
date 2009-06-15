#define THIS_FILE CBA\main\test_equals
scriptName 'THIS_FILE';
// -----------------------------------------------------------------------------

#include "script_component.hpp"

// -----------------------------------------------------------------------------

#define TEST_EQ(A,B) \
_result = [A, B] call equals; \
ASSERT_DEFINED("_result",_msg); \
_msg = '[A, B] call equals'; \
ASSERT(_result,_msg); \
_result = [B, A] call equals; \
ASSERT_DEFINED("_result",_msg); \
_msg = '[B, A] call equals'; \
ASSERT(_result,_msg);

#define TEST_NEQ(A,B) \
_result = [A, B] call equals; \
ASSERT_DEFINED("_result",_msg); \
_msg = 'not [A, B] call equals'; \
ASSERT_FALSE(_result,_msg); \
_result = [B, A] call equals; \
ASSERT_DEFINED("_result",_msg); \
_msg = 'not [B, A] call equals'; \
ASSERT_FALSE(_result,_msg);

private ["_a", "_b", "_result", "_msg"];

// Simple numbers.
TEST_EQ(1,1);
TEST_NEQ(2,1);

// Strings.
TEST_EQ("fish","fish");
TEST_NEQ("frog","fish");

// nil.
TEST_EQ(nil,nil);
TEST_NEQ(1,nil);

// Nulls.
TEST_EQ(objNull,objNull);
TEST_NEQ(1,objNull);

// Different nulls.
TEST_NEQ(objNull,controlNull);
TEST_NEQ(displayNull,objNull);

// Objects.
TEST_EQ(player,player);
TEST_NEQ(player,objNull);
TEST_NEQ(player,1);

// Config.
TEST_EQ(configFile >> "CfgWeapons",configFile >> "CfgWeapons");
TEST_NEQ(configFile >> "CfgWeapons",configFile >> "CfgVehicles");
TEST_NEQ(configFile >> "CfgWeapons",configFile >> "Frog");
TEST_NEQ(configFile >> "CfgWeapons",configNull);
TEST_EQ(configFile >> "Frog",configFile >> "Fish"); // Both configNull
TEST_NEQ(configFile >> "CfgWeapons", 1);

// // Empty arrays.
TEST_EQ([],[]);
TEST_NEQ([],1);

// 1-D arrays.
_a = [1, 2];
TEST_EQ(_a,_a);

_b = [1, 2];
TEST_EQ(_a,_b);

_b = [1, 2, 3];
TEST_NEQ(_a,_b);

_b = [1];
TEST_NEQ(_a,_b);

// // Multi-D arrays.
_a = [[1, 2], 3];
TEST_EQ(_a,_a);

_b = [1, [2, 3]];
TEST_NEQ(_a,_b);

_b = [1, 2, 3];
TEST_NEQ(_a,_b);

_b = [1, 2];
TEST_NEQ(_a,_b);

// Everything at once.
_a = [1, [nil, 4, objNull, ["frogs", player]], []];
TEST_EQ(_a,_a);

_b = [1, [nil, 4, objNull, ["frog", player]], []];
TEST_NEQ(_a,_b);

// Code
_a = { _x = 5 };
TEST_EQ(_a,_a);
TEST_EQ(_a,{ _x = 5 });
TEST_NEQ(_a,{ _x = 7 });
TEST_NEQ(_a,12);

// -----------------------------------------------------------------------------
LOG("Tests complete");
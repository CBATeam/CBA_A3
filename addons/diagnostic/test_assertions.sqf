// ----------------------------------------------------------------------------

#include "script_component.hpp"

SCRIPT(test_assertions);

// ----------------------------------------------------------------------------

LOG("Testing assertions");

private ["_a", "_b"];

ERROR("Testing that ERROR() is output correctly");
_a = false;
ASSERT_TRUE(_a,"Checking ASSERT_TRUE(" + str(_a) + ") outputs an error correctly");
_a = true;
ASSERT_FALSE(_a,"Checking ASSERT_FALSE(" + str(_a) + ")outputs an error correctly");
_a = 1; _b = 2;
ASSERT_OP(_a,>,_b,"Checking ASSERT_OP(1>2) outputs an error correctly");
ASSERT_DEFINED("_imaginaryFox","Checking ASSERT_DEFINED() is output correctly");


nil;

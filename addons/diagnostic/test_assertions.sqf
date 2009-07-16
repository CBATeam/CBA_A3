// ----------------------------------------------------------------------------

#include "script_component.hpp"

SCRIPT(test_assertions);

// ----------------------------------------------------------------------------

LOG("Testing assertions");

private ["_a", "_b"];

ERROR("Testing that ERROR() is output correctly");
_a = false;
ASSERT_TRUE(_a,"Checking ASSERT_TRUE() is output correctly");
_a = true;
ASSERT_FALSE(_a,"Checking ASSERT_FALSE() is output correctly");
_a = 1; _b = 2;
ASSERT_OP(_a,>,_b,"Checking ASSERT_OP() is output correctly");
ASSERT_DEFINED("_imaginaryFox","Checking ASSERT_DEFINED() is output correctly");


nil;

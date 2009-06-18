/* ----------------------------------------------------------------------------

@description Tests CBA main functions.

Parameters:
  None.

Returns:
  nil

---------------------------------------------------------------------------- */

#include "script_component.hpp"

// ----------------------------------------------------------------------------

LOG('----- STARTING PREFIX\COMPONENT TESTS -----');

private ["_a", "_b"];
ERROR("Error-check!","Testing that ERROR() is output correctly");
_a = false;
ASSERT_TRUE(_a,"Checking ASSERT_TRUE() is output correctly");
_a = true;
ASSERT_FALSE(_a,"Checking ASSERT_FALSE() is output correctly");
_a = 1; _b = 2;
ASSERT_OP(_a,>,_b,"Checking ASSERT_OP() is output correctly");
ASSERT_DEFINED("_imaginaryFox","Checking ASSERT_DEFINED() is output correctly");

CALLFS(PREFIX,COMPONENT,arrays_test);
CALLFS(PREFIX,COMPONENT,hash_test);
CALLFS(PREFIX,COMPONENT,misc_test);
CALLFS(PREFIX,COMPONENT,strings_test);
CALLFS(PREFIX,COMPONENT,yaml_test);

LOG('----- COMPLETED PREFIX\COMPONENT TESTS -----');

nil;
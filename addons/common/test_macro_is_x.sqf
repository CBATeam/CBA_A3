// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL
#include "script_component.hpp"

SCRIPT(test_Makro_IS_x);

// ----------------------------------------------------------------------------

private ["_test","_result"];

LOG("Testing MACRO_IS_x");

_test = [];
_result = IS_ARRAY(_test);
TEST_TRUE(_result,"MACRO_IS_ARRAY");

_test = "";
_result = IS_ARRAY(_test);
TEST_FALSE(_result,"MACRO_IS_ARRAY");

_test = nil;
_result = IS_ARRAY(_test);
TEST_FALSE(_result,"MACRO_IS_ARRAY");

_test = false;
_result = IS_BOOL(_test);
TEST_TRUE(_result,"MACRO_IS_BOOL");

_test = "";
_result = IS_BOOL(_test);
TEST_FALSE(_result,"MACRO_IS_BOOL");

_test = nil;
_result = IS_BOOL(_test);
TEST_FALSE(_result,"MACRO_IS_BOOL");

_test = {false;};
_result = IS_CODE(_test);
TEST_TRUE(_result,"MACRO_IS_CODE");

_test = "";
_result = IS_CODE(_test);
TEST_FALSE(_result,"MACRO_IS_CODE");

_test = nil;
_result = IS_CODE(_test);
TEST_FALSE(_result,"MACRO_IS_CODE");

_test = missionconfigfile;
_result = IS_CONFIG(_test);
TEST_TRUE(_result,"MACRO_IS_CONFIG");

_test = "";
_result = IS_CONFIG(_test);
TEST_FALSE(_result,"MACRO_IS_CONFIG");

_test = nil;
_result = IS_CONFIG(_test);
TEST_FALSE(_result,"MACRO_IS_CONFIG");

_test = grpNull;
_result = IS_GROUP(_test);
TEST_TRUE(_result,"MACRO_IS_GROUP");

_test = "";
_result = IS_GROUP(_test);
TEST_FALSE(_result,"MACRO_IS_GROUP");

_test = nil;
_result = IS_GROUP(_test);
TEST_FALSE(_result,"MACRO_IS_GROUP");

_test = 42.42;
_result = IS_SCALAR(_test);
TEST_TRUE(_result,"MACRO_IS_SCALAR");

_test = "";
_result = IS_SCALAR(_test);
TEST_FALSE(_result,"MACRO_IS_SCALAR");

_test = nil;
_result = IS_SCALAR(_test);
TEST_FALSE(_result,"MACRO_IS_SCALAR");

_test = [] spawn {uisleep 15;};
_result = IS_SCRIPT(_test);
TEST_TRUE(_result,"MACRO_IS_SCRIPT");

_test = "";
_result = IS_SCRIPT(_test);
TEST_FALSE(_result,"MACRO_IS_SCRIPT");

_test = nil;
_result = IS_SCRIPT(_test);
TEST_FALSE(_result,"MACRO_IS_SCRIPT");

_test = civilian;
_result = IS_SIDE(_test);
TEST_TRUE(_result,"MACRO_IS_SIDE");

_test = "";
_result = IS_SIDE(_test);
TEST_FALSE(_result,"MACRO_IS_SIDE");

_test = nil;
_result = IS_SIDE(_test);
TEST_FALSE(_result,"MACRO_IS_SIDE");

_test = "I LOVE TESTING";
_result = IS_STRING(_test);
TEST_TRUE(_result,"MACRO_IS_STRING");

_test = 11;
_result = IS_STRING(_test);
TEST_FALSE(_result,"MACRO_IS_STRING");

_test = nil;
_result = IS_STRING(_test);
TEST_FALSE(_result,"MACRO_IS_STRING");

_test = parseText "<a href='https://github.com/CBATeam/CBA_A3'>CBA_A3</a>";
_result = IS_TEXT(_test);
TEST_TRUE(_result,"MACRO_IS_TEXT");

_test = "A STRING";
_result = IS_TEXT(_test);
TEST_FALSE(_result,"MACRO_IS_TEXT");

_test = 11;
_result = IS_TEXT(_test);
TEST_FALSE(_result,"MACRO_IS_TEXT");

_test = nil;
_result = IS_TEXT(_test);
TEST_FALSE(_result,"MACRO_IS_TEXT");

_test = locationNull;
_result = IS_LOCATION(_test);
TEST_TRUE(_result,"MACRO_IS_LOCATION");

_test = 11;
_result = IS_LOCATION(_test);
TEST_FALSE(_result,"MACRO_IS_LOCATION");

_test = nil;
_result = IS_LOCATION(_test);
TEST_FALSE(_result,"MACRO_IS_LOCATION");

_test = true;
_result = IS_BOOLEAN(_test);
TEST_TRUE(_result,"MACRO_IS_BOOLEAN");

_test = 11;
_result = IS_BOOLEAN(_test);
TEST_FALSE(_result,"MACRO_IS_BOOLEAN");

_test = nil;
_result = IS_BOOLEAN(_test);
TEST_FALSE(_result,"MACRO_IS_BOOLEAN");

_test = {true;};
_result = IS_FUNCTION(_test);
TEST_TRUE(_result,"MACRO_IS_FUNCTION");

_test = 11;
_result = IS_FUNCTION(_test);
TEST_FALSE(_result,"MACRO_IS_FUNCTION");

_test = nil;
_result = IS_FUNCTION(_test);
TEST_FALSE(_result,"MACRO_IS_FUNCTION");

_test = 42;
_result = IS_INTEGER(_test);
TEST_TRUE(_result,"MACRO_IS_INTEGER");

_test = 11.11;
_result = IS_INTEGER(_test);
TEST_FALSE(_result,"MACRO_IS_INTEGER");

_test = "";
_result = IS_INTEGER(_test);
TEST_FALSE(_result,"MACRO_IS_INTEGER");

_test = nil;
_result = IS_INTEGER(_test);
TEST_FALSE(_result,"MACRO_IS_INTEGER");

_test = 11.11;
_result = IS_NUMBER(_test);
TEST_TRUE(_result,"MACRO_IS_NUMBER");

_test = "";
_result = IS_NUMBER(_test);
TEST_FALSE(_result,"MACRO_IS_NUMBER");

_test = nil;
_result = IS_NUMBER(_test);
TEST_FALSE(_result,"MACRO_IS_NUMBER");

disableSerialization;
_test = displayNull;
_result = IS_DISPLAY(_test);
TEST_TRUE(_result,"MACRO_IS_DISPLAY");

_test = "";
_result = IS_DISPLAY(_test);
TEST_FALSE(_result,"MACRO_IS_DISPLAY");

_test = nil;
_result = IS_DISPLAY(_test);
TEST_FALSE(_result,"MACRO_IS_DISPLAY");

_test = controlNull;
_result = IS_CONTROL(_test);
TEST_TRUE(_result,"MACRO_IS_CONTROL");

_test = "";
_result = IS_CONTROL(_test);
TEST_FALSE(_result,"MACRO_IS_CONTROL");

_test = nil;
_result = IS_CONTROL(_test);
TEST_FALSE(_result,"MACRO_IS_CONTROL");

nil;

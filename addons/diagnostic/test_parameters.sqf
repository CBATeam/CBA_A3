// ----------------------------------------------------------------------------

#include "script_component.hpp"

SCRIPT(test_parameters);

// ----------------------------------------------------------------------------

LOG("Testing parameters");

private ["_expected","_result","_this"];

// Test default params.
_this = [5];
DEFAULT_PARAM(0,_result,12);
_expected = 5;
TEST_OP(_result,==,_expected,"DEFAULT_PARAM");

_result = nil;

_this = [];
DEFAULT_PARAM(0,_result,12);
_expected = 12;
TEST_OP(_result,==,_expected,"DEFAULT_PARAM");

_result = nil;

_this = [nil];
DEFAULT_PARAM(0,_result,12);
_expected = 12;
TEST_OP(_result,==,_expected,"DEFAULT_PARAM");

_result = nil;

_this = nil;
DEFAULT_PARAM(0,_result,12);
_expected = 12;
TEST_OP(_result,==,_expected,"DEFAULT_PARAM");

nil;

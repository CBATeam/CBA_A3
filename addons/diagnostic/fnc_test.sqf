/* ----------------------------------------------------------------------------
Function: CBA_fnc_test

Description:
    Runs unit tests for an addon or component.

Parameters:
    _addon - Prefix of addon to test [String, defaulting to "cba"].
    _component - Name of component to test. If "main", will
        test the whole addon [String, defaulting to "main"].

Returns:
    nil

Examples:
    (begin example)
        [] call CBA_fnc_test; // Test whole of CBA addon.
    (end)

    (begin example)
        [nil, "arrays"] call CBA_fnc_test; // Test Arrays component of CBA addon.
    (end)

    (begin example)
        ["SPON_Map"] call CBA_fnc_test; // Test whole of SPON_Map addon.
    (end)

    (begin example)
        ["SPON_Map", "drawing"] call CBA_fnc_test; // Test Drawing component of SPON_Map addon.
    (end)

Author:
    Spooner

---------------------------------------------------------------------------- */

#include "script_component.hpp"

// ----------------------------------------------------------------------------

DEFAULT_PARAM(0,_addon,"cba");
DEFAULT_PARAM(1,_component,"main");

LOG('===== STARTING TESTS =====');

call compile preprocessFileLineNumbers format ["\x\%1\addons\%2\test.sqf", _addon, _component];

LOG('===== COMPLETED TESTS =====');

nil;

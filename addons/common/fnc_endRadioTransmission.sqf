#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_endRadioTransmission

Description:
    End radio transmissions of addons TFAR and ACRE2. TFAR v0.9.x, ACRE Public Beta 2.0.3.571, TFAR v1.0.-1.x

Parameters:
    None

Returns:
    None

Examples:
    (begin example)
        [] call CBA_fnc_endRadioTransmission
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(endRadioTransmission);

["CBA_endRadioTransmissions"] call CBA_fnc_localEvent;
["ace_endRadioTransmissions"] call CBA_fnc_localEvent; // Ported from ACE

// ACRE
if ("acre_main" call CBA_fnc_isModLoaded) then {
    [-1] call acre_sys_core_fnc_handleMultiPttKeyPressUp;
    [0] call acre_sys_core_fnc_handleMultiPttKeyPressUp;
    [1] call acre_sys_core_fnc_handleMultiPttKeyPressUp;
    [2] call acre_sys_core_fnc_handleMultiPttKeyPressUp;
};

// TFAR
if ("task_force_radio" call CBA_fnc_isModLoaded) then {
    if ("tfar_core" call CBA_fnc_isModLoaded) exitWith { // Beta TFAR, exit to avoid script errors from legacy functions not existing
        ([] call CBA_fnc_currentUnit) call TFAR_fnc_releaseAllTangents;
    };
    [] call TFAR_fnc_onSwTangentReleased;
    [] call TFAR_fnc_onAdditionalSwTangentReleased;
    [] call TFAR_fnc_onLRTangentReleased;
    [] call TFAR_fnc_onAdditionalLRTangentReleased;
    [] call TFAR_fnc_onDDTangentReleased;
};

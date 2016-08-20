/* ----------------------------------------------------------------------------
Function: CBA_fnc_publicVariable

Description:
    Broadcast a variables value to all machines. Used to reduce network traffic.

    Does only broadcast the new value if it doesn't exist in missionNamespace or
    if the new value is different to the one in missionNamespace.
    Nil as value gets always broadcasted.

Parameters:
    _varName - Name of the public variable <STRING>
    _value   - Value to broadcast <ANY>

Returns:
    True if if broadcasted, otherwise false <BOOLEAN>

Example:
    (begin example)
        // This will only broadcast "somefish" if it either doesn't exist yet in the missionNamespace or the value is not 50
        _broadcasted = ["somefish", 50] call CBA_fnc_publicVariable;
    (end)

Author:
    Xeno, commy2
---------------------------------------------------------------------------- */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_varName", "", [""]], "_value"];

if (_varName isEqualTo "") exitWith {
    WARNING("Variable name is wrong type or undefined");
    false
};

private _currentValue = missionNamespace getVariable _varName;

if (isNil "_currentValue" || {!(_value isEqualTo _currentValue)}) then {
    TRACE_2("Broadcasting",_varName,_value);
    missionNamespace setVariable [_varName, _value];
    publicVariable _varName;
    true // return
} else {
    TRACE_2("Not broadcasting. Current and new value are equal",_currentValue,_value);
    false // return
};

#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_setVarNet

Description:
    Broadcast a object variable value to all machines. Used to reduce network traffic.

    Does only broadcast the new value if it doesn't exist in the object namespace or
    if the new value is different to the one in object namespace.
    Nil as value gets always broadcasted.

Parameters:
    _object  - Object namespace <OBJECT, GROUP>
    _varName - Name of the public variable <STRING>
    _value   - Value to broadcast <ANY>

Returns:
    True if if broadcasted, otherwise false <BOOLEAN>

Example:
    (begin example)
        // This will only broadcast "somefish" if it either doesn't exist yet in the variable space or the value is not 50
        _broadcasted = [player, "somefish", 50] call CBA_fnc_setVarNet;
    (end)

Author:
    Xeno, commy2
---------------------------------------------------------------------------- */

params [["_object", objNull, [objNull, grpNull]], ["_varName", "", [""]], "_value"];

if (isNull _object) exitWith {
    WARNING("Object wrong type, undefined or null");
    false
};

if (_varName isEqualTo "") exitWith {
    WARNING("Variable name is wrong type or undefined");

    false
};

private _currentValue = _object getVariable _varName;

if (isNil "_currentValue") then {
    if (isNil "_value") then {
        TRACE_2("Not broadcasting. Current and new value are undefined",_object,_varName);

        false // return
    } else {
        TRACE_3("Broadcasting previously undefined value",_object,_varName,_value);

        _object setVariable [_varName, _value, true];
        true // return
    };
} else {
    if (isNil "_value") then {
        TRACE_2("Broadcasting nil",_object,_varName);

        _object setVariable [_varName, nil, true];
        true // return
    } else {
        if (_value isEqualTo _currentValue) then {
            TRACE_4("Not broadcasting. Current and new value are equal",_object,_varName,_currentValue,_value);

            false // return
        } else {
            TRACE_3("Broadcasting",_object,_varName,_value);

            _object setVariable [_varName, _value, true];
            true // return
        };
    };
};

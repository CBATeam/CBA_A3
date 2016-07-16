/* ----------------------------------------------------------------------------
Function: CBA_fnc_createPerFrameHandlerLogic

Description:
    Creates a PFH object, that will execute code every frame, or every x number of seconds.

Parameters:
    _function      - The function you wish to execute. <CODE>
    _delay         - The amount of time in seconds between executions, 0 for every frame. (optional, default: 0) <NUMBER>
    _args          - Parameters passed to the function executing. (optional) <ANY>
    _start         - Function that is executed when the PFH is added. (optional) <CODE>
    _end           - Function that is executed when the PFH is removed. (optional) <CODE>
    _runCondition  - Condition that has to return true for the PFH to be executed. (optional, default {true}) <CODE>
    _exitCondition - Condition that has to return true to delete the PFH object. (optional, default {false}) <CODE>
    _private       - List of local variables that are serialized between executions. (optional) <CODE>

Passed Arguments:
    _this          - The PFH logic. <LOCATION>

    More variables are attached to this PFH logic than can be retrieved via 'getVariable'. (_this getVariable "params")
    It is not advised to overwrite these variables with 'setVariable'!

    "params"         - Parameters passed by this function. Same as _args from above. <ANY>
    "handle"         - A number representing the handle of the PFH. <NUMBER>
    "private"        - List of local variables that are serialized between executions. Same as _private from above. <ARRAY>
    "start"          - Same as _start from above. <CODE>
    "end"            - Same as _end from above. <CODE>
    "run"            - Same as _function from above. <CODE>
    "run_condition"  - Same as _runCondition from above. <CODE>
    "exit_condition" - Same as _exitCondition from above. <CODE>
    "serialize"      - Internal reserved variable.
    "deserialize"    - Internal reserved variable.

    The PFH logic can be used to store additional custom variables.

Returns:
    _logic - The PFH logic. <LOCATION>

Examples:
    (begin example)
        [
            { systemChat format ["frame! params: %1", _this getVariable "params"]; },
            0,
            ["some_params", [1,2,3]],
            { systemChat format ["start! params: %1", _this getVariable "params"]; _test = 127; },
            { systemChat format ["end! params: %1",   _this getVariable "params"]; systemChat str [_test] },
            { random 1 > 0.5 },
            { random 1 > 0.8 },
            "_test"
        ] call CBA_fnc_createPerFrameHandlerLogic;
    (end)

Author:
    Nou & Jaynus, donated from ACRE project code for use by the community; commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [
    ["_function", {}, [{}]],
    ["_delay", 0, [0]],
    ["_args", [], [[]]],
    ["_start", {}, [{}]],
    ["_end", {}, [{}]],
    ["_runCondition", {true}, [{}]],
    ["_exitCondition", {false}, [{}]],
    ["_private", [], ["", []]]
];

if (_private isEqualType "") then {
    _private = [_private];
};

private _logic = call CBA_fnc_createNamespace;

_logic setVariable ["start", _start];
_logic setVariable ["run_condition", _runCondition];
_logic setVariable ["exit_condition", _exitCondition];
_logic setVariable ["run", _function];
_logic setVariable ["end", _end];
_logic setVariable ["params", _args];
_logic setVariable ["private", _private];

// prepare serialization and deserialization code
private _serialize = [];

{
    _serialize pushBack compile format ["_logic setVariable ['%1', %1]", _x];
} forEach (_logic getVariable "private");

private _deserialize = [];

{
    _deserialize pushBack compile format ["%1 = _logic getVariable '%1'", _x];
} forEach (_logic getVariable "private");

_logic setVariable ["serialize", _serialize];
_logic setVariable ["deserialize", _deserialize];

// add per frame handler
private _handle = [{
    // all functions get _logic as _this param. Params inside: _logic getVariable "params";
    params ["_logic"];

    if (isNil "_logic" || {isNull _logic}) exitWith {
        (_logic getVariable "handle") call CBA_fnc_removePerFrameHandler;
    };

    // deserialize
    private (_logic getVariable "private");
    { call _x } forEach (_logic getVariable "deserialize");

    // check exit condition - exit if false
    if (_logic call (_logic getVariable "exit_condition")) exitWith {
        // execute end code
        _logic call (_logic getVariable "end");

        (_logic getVariable "handle") call CBA_fnc_removePerFrameHandler;
        _logic call CBA_fnc_deleteNamespace;
    };

    // check Run Condition - only continue if true
    if (_logic call (_logic getVariable "run_condition")) then {
        // execute code
        _logic call (_logic getVariable "run");

        // serialize
        { call _x } forEach (_logic getVariable "serialize");
    };
}, _delay, _logic] call CBA_fnc_addPerFrameHandler;

_logic setVariable ["handle", _handle];

// run start code
private (_logic getVariable "private");
_logic call (_logic getVariable "start");

// serialize
{ call _x } forEach (_logic getVariable "serialize");

_logic // returns logic because you can get the handle from it, and much more

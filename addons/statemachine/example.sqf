/*
    This is an example for a script that uses the CBA state machine system.
    In this case, we're "sharpening the senses" of AI units that got attacked before.
    Once they had contact, they stay alert.

    This would simulate units that did not expect an attack, but are now aware that
    they might come under fire again.

    You can test this example by executing the following code in the debug console:
    [] call compile preprocessFileLineNumbers "\x\cba\addons\statemachine\example.sqf"
*/

private _stateMachine = [{allGroups select {!isPlayer leader _x}}] call CBA_statemachine_fnc_create;

[_stateMachine, {}, {}, {}, "Initial"] call CBA_statemachine_fnc_addState;
[_stateMachine, {}, {}, {}, "Alert"] call CBA_statemachine_fnc_addState;

[_stateMachine, "Initial", "Alert", {combatMode _this == "YELLOW"}, {
    // Set skill once on transition
    // This could also be done in the onStateEntered function
    {
        _x setSkill ["spotDistance", ((_x skill "spotDistance") * 1.5) min 1];
        _x setSkill ["spotTime",     ((_x skill "spotTime")     * 1.5) min 1];
    } forEach (units _this);
}, "InCombat"] call CBA_statemachine_fnc_addTransition;

// This makes sure you can execute this through the debug console
_stateMachine spawn {
    sleep 0.1;
    private _output = [_this, true, true] call CBA_statemachine_fnc_toString;
    copyToClipboard _output;
    hintC _output;
};

/*
    This is an example for a CBA state machine config that can be read by the
    CBA_statemachine_fnc_createFromConfig function.
    This example would result in the same state machine as the one from
    example.sqf.
*/

class MyAddon_Statemachine {
    // Class properties have the same name as the corresponding function parameters
    // and code goes into strings.
    list = "allGroups select {!isPlayer leader _x}";

    // States are just subclasses of the state machine
    class Initial {
        onState = "";

        // Transitions are also just subclasses of states
        class InCombat {
            targetState = "Alert";
            condition = "combatMode _this == 'YELLOW'";
            onTransition = "{ \
                _x setSkill ['spotDistance', ((_x skill 'spotDistance') * 1.5) min 1]; \
                _x setSkill ['spotTime',     ((_x skill 'spotTime')     * 1.5) min 1]; \
            } forEach (units _this);";
        };
    };

    // Empty classes will also work if the state contains no transitions or onState code.
    class Alert {};
};

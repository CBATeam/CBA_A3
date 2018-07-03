if (_this == 0) exitWith {
    RETURN("test");
};

if (_this == 3) then {
    [missionNamespace getVariable _fnc_scriptName, _this - 1] call CBA_fnc_directCall;
};

(_this - 1) call (missionNamespace getVariable _fnc_scriptName);

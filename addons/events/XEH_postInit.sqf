#include "script_component.hpp"

// execute JIP events after post init to guarantee execution of events added during postInit
[{
    {
        private _event = GVAR(eventNamespaceJIP) getVariable _x;
        if (_event isEqualType []) then {
            if ((_event select 0) isEqualTo EVENT_PVAR_STR) then {
                (_event select 1) call CBA_fnc_localEvent;
            };
        };
    } forEach allVariables GVAR(eventNamespaceJIP);

    // allow new incoming jip events
    [QGVAR(eventJIP), CBA_fnc_localEvent] call CBA_fnc_addEventHandler;
}, []] call CBA_fnc_execNextFrame;

if (isServer) then {
    CBA_clientID = [0, 2] select isMultiplayer;
    addMissionEventHandler ["PlayerConnected", {
        params ["_id", "_uid", "_name", "_jip", "_owner"];
        TRACE_5("PlayerConnected eh",_id,_uid,_name,_jip,_owner);

        if (_owner != 2) then {
            CBA_clientID = _owner;
            _owner publicVariableClient "CBA_clientID";
            CBA_clientID = [0, 2] select isMultiplayer;
        };
    }];
};

// custom chat command system
[QGVAR(chatMessageSent), {
    params ["_message"];

    if (((_message select [0,1]) isEqualTo "#") && {!isNil QGVAR(customChatCommands)}) then {
        private _index = _message find " ";

        // no argument
        if (_index isEqualTo -1) then {
            _index = count _message;
        };

        private _command = _message select [1, _index - 1];
        private _argument = _message select [_index + 1];

        // check if command is available
        private _access = ["all"];

        if (IS_ADMIN || isServer) then {
            _access pushBack "admin";
        };

        if (IS_ADMIN_LOGGED || isServer) then {
            _access pushBack "adminlogged";
        };

        (GVAR(customChatCommands) getVariable _command) params ["_code", "_availableFor", "_thisArgs"];

        if (_availableFor in _access) then {
            [[_argument], _code] call {
                // prevent bad code from overwriting protected variables
                private ["_message", "_index", "_command", "_argument", "_access", "_code", "_availableFor"];
                (_this select 0) call (_this select 1);
            };
        };
    };
}] call CBA_fnc_addEventHandler;

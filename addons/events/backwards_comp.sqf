
// imitate deprecated clientToServerEvent
CBA_fnc_addClientToServerEventhandler = {
    diag_log text "[CBA]: Usage of deprecated CBA_fnc_addClientToServerEventhandler.";
    if (!isServer) exitWith {};

    private _eventsVar = format [QGVAR(CTS:%1), _this select 0];

    if (isNil _eventsVar) then {
        // store all eh ids. Needed for backwards comp, because CBA_fnc_removeClientToServerEvent removes all ehs with this name. No IDs.
        missionNamespace setVariable [_eventsVar, []];
    };

    (missionNamespace getVariable _eventsVar) pushBack ([_eventsVar, _this select 1] call CBA_fnc_addEventHandler);

    nil // no ID returned for this function
};

CBA_fnc_clientToServerEvent = {
    [format [QGVAR(CTS:%1), _this select 0], _this select 1] call CBA_fnc_serverEvent;
};

CBA_fnc_removeClientToServerEvent = {
    diag_log text "[CBA]: Usage of deprecated CBA_fnc_removeClientToServerEvent.";
    if (!isServer) exitWith {};

    private _eventsVar = format [QGVAR(CTS:%1), _this];

    if (!isNil _eventsVar) then {
        {
            [_eventsVar, _x] call CBA_fnc_removeEventHandler;
        } forEach (missionNamespace getVariable _eventsVar);

        missionNamespace setVariable [_eventsVar, nil];
    };
};

// imitate deprecated receiverOnlyEvent
CBA_fnc_addReceiverOnlyEventhandler = {
    diag_log text "[CBA]: Usage of deprecated CBA_fnc_addReceiverOnlyEventhandler.";
    private _eventsVar = format [QGVAR(TOR:%1), _this select 0];

    if (isNil _eventsVar) then {
        // store all eh ids. Needed for backwards comp, because CBA_fnc_removeReceiverOnlyEvent removes all ehs with this name. No IDs.
        missionNamespace setVariable [_eventsVar, []];
    };

    (missionNamespace getVariable _eventsVar) pushBack ([_eventsVar, _this select 1] call CBA_fnc_addEventHandler);

    nil // no ID returned for this function
};

CBA_fnc_receiverOnlyEvent = {
    (_this select 1) params ["_target"];

    // emulate bug with this event: publicVariableServer does not trigger PVEH when called on the server - publicVariable does
    if (isServer && {!local _target}) exitWith {};

    [format [QGVAR(TOR:%1), _this select 0], _this select 1, _target] call CBA_fnc_targetEvent;
};

CBA_fnc_removeReceiverOnlyEvent = {
    diag_log text "[CBA]: Usage of deprecated CBA_fnc_removeReceiverOnlyEvent.";
    private _eventsVar = format [QGVAR(TOR:%1), _this];

    if (!isNil _eventsVar) then {
        {
            [_eventsVar, _x] call CBA_fnc_removeEventHandler;
        } forEach (missionNamespace getVariable _eventsVar);

        missionNamespace setVariable [_eventsVar, nil];
    };
};

// imitate deprecated whereLocalEvent / remoteLocalEvent
CBA_fnc_addLocalEventHandler = {
    diag_log text "[CBA]: Usage of deprecated CBA_fnc_addLocalEventHandler.";
    private _eventsVar = format [QGVAR(WL:%1), _this select 0];

    if (isNil _eventsVar) then {
        // store all eh ids. Needed for backwards comp, because CBA_fnc_removeClientToServerEvent removes all ehs with this name. No IDs.
        missionNamespace setVariable [_eventsVar, []];
    };

    (missionNamespace getVariable _eventsVar) pushBack ([_eventsVar, _this select 1] call CBA_fnc_addEventHandler) // return handler id
};

CBA_fnc_whereLocalEvent = {
    (_this select 1) params ["_target"];

    [format [QGVAR(WL:%1), _this select 0], _this select 1, _target] call CBA_fnc_targetEvent;
};

// CBA_fnc_remoteLocalEvent, FUNC(remoteLocalEvent)

CBA_fnc_removeLocalEventHandler = {
    diag_log text "[CBA]: Usage of deprecated CBA_fnc_removeLocalEventHandler.";
    private _eventsVar = format [QGVAR(WL:%1), _this select 0];

    if (!isNil _eventsVar) then {
        [_eventsVar, _this select 1] call CBA_fnc_removeEventHandler;
    };
};

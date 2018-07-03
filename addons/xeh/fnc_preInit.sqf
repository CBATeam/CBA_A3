#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_preInit

Description:
    Occurs once per mission before objects are initialized.
    Internal use only.

Parameters:
    None

Returns:
    None

Author:
    commy2
---------------------------------------------------------------------------- */

if (ISPROCESSED(missionNamespace)) exitWith {
    diag_log text "[XEH]: preInit already executed. Abort preInit.";
};
SETPROCESSED(missionNamespace);

SLX_XEH_DisableLogging = uiNamespace getVariable ["SLX_XEH_DisableLogging", false]; // get from preStart

XEH_LOG("XEH: PreInit started. v" + getText (configFile >> "CfgPatches" >> "cba_common" >> "version"));

SLX_XEH_STR = ""; // does nothing, never changes, backwards compatibility
SLX_XEH_COMPILE = compileFinal "compile preprocessFileLineNumbers _this"; //backwards comps
SLX_XEH_COMPILE_NEW = CBA_fnc_compileFunction; //backwards comp
SLX_XEH_DUMMY = "Logic"; // backwards comp

SLX_XEH_MACHINE = [ // backwards compatibility, deprecated
    !isDedicated, // 0 - isClient (and thus has player)
    didJIP, // 1 - isJip
    !isServer, // 2 - isDedicatedClient (and thus not a Client-Server)
    isServer, // 3 - isServer
    isDedicated, // 4 - isDedicatedServer (and thus not a Client-Server)
    false, // 5 - Player Check finished, no longer works
    !isMultiplayer, // 6 - isSingleplayer
    false, // 7 - PreInit passed
    false, // 8 - PostInit passed
    isMultiplayer, // 9 - Multiplayer && respawn
    if (isDedicated) then {0} else {if (isServer) then {1} else {2}}, // 10 - Machine type (only 3 possible configurations)
    0, // 11 - SESSION_ID
    0, // 12 - LEVEL - Used for version determination
    false, // 13 - TIMEOUT - PostInit timedOut, always false
    productVersion, // 14 - Game
    3 // 15 - Product+Version, always Arma 3
];

CBA_isHeadlessClient = !hasInterface && !isDedicated;

// make case insensitive list of all supported events
GVAR(EventsLowercase) = [];
{
    // generate event functions
    if (_x isEqualTo "Init") then {
        FUNC(Init) = compileFinal "(_this select 0) call CBA_fnc_initEvents; (_this select 0) call CBA_fnc_init";
    } else {
        if (_x isEqualTo "HitPart") then {
            FUNC(HitPart) = compileFinal format ['{call _x; nil} count ((_this select 0 select 0) getVariable QGVAR(%1))', _x];
        } else {
            missionNamespace setVariable [
                format [QFUNC(%1), _x],
                compileFinal format ['{call _x; nil} count ((_this select 0) getVariable QGVAR(%1))', _x]
            ];
        };
    };

    GVAR(EventsLowercase) pushBack toLower _x;
} forEach [XEH_EVENTS];

// generate list of incompatible classes
GVAR(incompatible) = [] call CBA_fnc_createNamespace;

{
    private _class = configFile >> "CfgVehicles" >> _x;

    while {isClass _class && {!ISINCOMP(configName _class)}} do {
        SETINCOMP(configName _class);

        _class = inheritsFrom _class;
    };
} forEach ([false, true] call CBA_fnc_supportMonitor);

// always recompile extended event handlers
#ifdef DEBUG_MODE_FULL
    XEH_LOG("XEH: Compiling XEH START");
#endif

GVAR(allEventHandlers) = [];

{
    GVAR(allEventHandlers) append (_x call CBA_fnc_compileEventHandlers);
} forEach XEH_MAIN_CONFIGS;

#ifdef DEBUG_MODE_FULL
    XEH_LOG("XEH: Compiling XEH END");
#endif

// add extended event handlers to classes
GVAR(fallbackRunning) = false;

// call PreInit events and add event handlers to object classes
{
    if (_x select 0 == "") then {
        if (_x select 1 == "preInit") then {
            [] call (_x select 2);
        };
    } else {
        _x params ["_className", "_eventName", "_eventFunc", "_allowInheritance", "_excludedClasses"];

        // backwards comp, args in _this are already switched
        if (_eventName == "firedBis") then {
            _eventName = "fired";
        };

        private _success = [_className, _eventName, _eventFunc, _allowInheritance, _excludedClasses] call CBA_fnc_addClassEventHandler;
        TRACE_3("addClassEventHandler",_className,_eventName,_success);
    };
} forEach GVAR(allEventHandlers);

GVAR(initPostStack) = [];

#ifdef DEBUG_MODE_FULL
    diag_log text format ["isScheduled = %1", call CBA_fnc_isScheduled];
#endif

SLX_XEH_MACHINE set [7, true]; // PreInit passed

#ifdef DEBUG_MODE_FULL
    [QGVAR(LoadingScreenStarted), {diag_log [QGVAR(LoadingScreenStarted), _this]}] call CBA_fnc_addEventHandler;
    [QGVAR(LoadingScreenEnded), {diag_log [QGVAR(LoadingScreenEnded), _this]}] call CBA_fnc_addEventHandler;
#endif

// CBA_loadingScreenDone event
GVAR(expectedLoadingScreens) = ["bis_fnc_preload", "bis_fnc_initRespawn"];

if (!isServer) then { // only on client
    GVAR(expectedLoadingScreens) pushBack "bis_fnc_initFunctions";
};

// check if this was the last loading screen, if so, fire event
[QGVAR(LoadingScreenEnded), {
    params ["_loadingScreen"];

    if (!isNil QGVAR(expectedLoadingScreens)) then {
        GVAR(expectedLoadingScreens) deleteAt (GVAR(expectedLoadingScreens) find _loadingScreen);

        if (count GVAR(expectedLoadingScreens) == 0) then {
            GVAR(expectedLoadingScreens) = nil;
            ["CBA_loadingScreenDone", []] call CBA_fnc_localEvent;
        };
    };
}] call CBA_fnc_addEventHandler;

#ifdef DEBUG_MODE_FULL
    ["CBA_loadingScreenDone", {
        playSound "Beep_Target";
    }] call CBA_fnc_addEventHandler;
#endif

XEH_LOG("XEH: PreInit finished.");

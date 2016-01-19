/* ----------------------------------------------------------------------------
Function: CBA_fnc_compileEventHandlers

Description:
    Compiles all Extended EventHandlers in given config.

Parameters:
    0: _baseConfig - What config file should be used. <CONFIG>

Returns:
    Compiled code of all Extended EventHandlers <ARRAY>
        format: [event1, event2, ..., eventN] <ARRAY>
        eventX format: [_className <STRING>, _eventName <STRING>, _eventFunc <CODE>, _allowInheritance <BOOLEAN>, _excludedClasses <ARRAY>]

Examples:
    (begin example)
        configFile call CBA_fnc_compileEventHandlers;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_baseConfig", configNull, [configNull]]];

private _result = [];
private _resultNames = [];

// note: format is never used for config parsing here, because of it's 8192 character limitation.

{
    private _eventName = _x;

    {
        private _eventFunc = "";
        private _customName = configName _x;

        if (isClass _x) then {
            // events on clients and server
            private _entry = _x >> "init";

            if (isText _entry) then {
                _eventFunc = _eventFunc + getText _entry + ";";
            };

            // client only events
            private _entryClient = _x >> "clientInit";

            if ((!isDedicated) && {isText _entryClient}) then {
                _eventFunc = _eventFunc + getText _entryClient + ";";
            };

            // server only events
            private _entryServer = _x >> "serverInit";

            if ((isServer) && {isText _entryServer}) then {
                _eventFunc = _eventFunc + getText _entryServer + ";";
            };
        } else {
            // global events
            if (isText _x) then {
                _eventFunc = getText _x + ";";
            };
        };

        _result pushBack ["", _eventName, compile _eventFunc];
        _resultNames pushBack _customName;
    } forEach configProperties [_baseConfig >> XEH_FORMAT_CONFIG_NAME(_eventName)];
} forEach ["preStart", "preInit", "postInit"]; 

// object events
{
    private _eventName = _x;

    {
        private _entryName = _eventName; // how the entries are labeled, e.g. init, serverInit

        private _className = configName _x;
        private _eventFuncBase = "";

        if (_eventName == "initPost") then {
            _entryName = "init";
        };

        // backwards compatibility
        if (_eventName == "fired") then {
            // generate backwards compatible format of _this
            _eventFuncBase = "private _this = [_this select 0, _this select 1, _this select 2, _this select 3, _this select 4, _this select 6, _this select 5];";
            diag_log text "[XEH]: Usage of deprecated Extended Eventhandler ""fired"". Use ""firedBis"" instead.";
        };

        {
            private _eventFunc = _eventFuncBase;
            private _customName = configName _x;
            private _allowInheritance = true;
            private _excludedClasses = [];
            private _doesSomething = false;

            if (isClass _x) then {
                // allow inheritance of this event?
                private _scope = _x >> "scope";

                if (isNumber _scope) then {
                    _allowInheritance = getNumber _scope != 0;
                };

                // classes excluded from this event
                private _exclude = _x >> "exclude";

                if (isArray _exclude) then {
                    _excludedClasses append getArray _exclude;
                };

                if (isText _exclude) then {
                    _excludedClasses pushBack getText _exclude;
                };

                // events on clients and server
                private _entry = _x >> _entryName;

                if (isText _entry) then {
                    _eventFunc = _eventFunc + getText _entry + ";";
                    _doesSomething = true;
                };

                // client only events
                private _entryClient = _x >> format ["client%1", _entryName];

                if ((!isDedicated) && {isText _entryClient}) then {
                    _eventFunc = _eventFunc + getText _entryClient + ";";
                    _doesSomething = true;
                };

                // server only events
                private _entryServer = _x >> format ["server%1", _entryName];

                if ((isServer) && {isText _entryServer}) then {
                    _eventFunc = _eventFunc + getText _entryServer + ";";
                    _doesSomething = true;
                };

                // init event handlers that should run on respawn again, onRespawn = 1
                if (_eventName == "init" && {getNumber (_x >> "onRespawn") == 1}) then {
                    _eventFunc = _eventFunc + "(_this select 0) addEventHandler ['Respawn', " + str _eventFunc + "];";
                };
            } else {
                // global events
                if (isText _x) then {
                    _eventFunc = getText _x + ";";
                    _doesSomething = true;
                };
            };
            
            if ((!_doesSomething) && {!isMultiplayer}) then { //Print error warning for XEH with no actual code
                diag_log text format ["[XEH]: No functions found for [%1] in [%2] from config [%3] (check event name)", _eventName, _customName, _x];
            };

            // emulate oo-like inheritance by adding classnames that would redefine an event by using the same custom event name to the excluded classes
            {
                (_result select _forEachIndex) params ["_classNameX", "_eventNameX"];

                // same custom name and same event type
                if (_customName == _x && {_eventName == _eventNameX}) then {
                    // has parent already set, update parent to exclude this class
                    if (_className isKindOf _classNameX) then {
                        (_result select _forEachIndex select 4) pushBack _className;
                    };

                    // has child already set, add child to excluded classes
                    if (_classNameX isKindOf _className) then {
                        _excludedClasses pushBack _classNameX;
                    };
                };
            } forEach _resultNames;

            _result pushBack [_className, _eventName, compile _eventFunc, _allowInheritance, _excludedClasses, _doesSomething];
            _resultNames pushBack _customName;
        } forEach configProperties [_x];
    } forEach configProperties [_baseConfig >> XEH_FORMAT_CONFIG_NAME(_eventName), "isClass _x"];
} forEach [XEH_EVENTS];

_result

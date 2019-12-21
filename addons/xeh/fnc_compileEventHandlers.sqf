#include "script_component.hpp"
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

params [["_baseConfig", configNull, [configNull]]];

private _result = [];
private _resultNames = [];

private _allowRecompile = _baseConfig isEqualTo configFile;

if (_allowRecompile) then {
    if ("compile" call CBA_fnc_isRecompileEnabled || {isFilePatchingEnabled}) then {
        XEH_LOG("init function preProcessing disabled [recompile or filepatching enabled]");
        _allowRecompile = false;
    };
};

// note: format is never used for config parsing here, because of it's 8192 character limitation.

{
    private _eventName = _x;

    {
        private _funcAll = "";
        private _funcClient = "";
        private _funcServer = "";
        private _customName = configName _x;

        if (isClass _x) then {
            // events on clients and server
            private _entry = _x >> "init";

            if (isText _entry) then {
                _funcAll = getText _entry;
            };

            // client only events
            _entry = _x >> "clientInit";
            if (isText _entry) then {
                _funcClient = getText _entry;
            };

            // server only events
            _entry = _x >> "serverInit";
            if (isText _entry) then {
                _funcServer = getText _entry;
            };
        } else {
            // global events
            if (isText _x) then {
                _funcAll = getText _x;
            };
        };

        private _eventFuncs = [_funcAll, _funcClient, _funcServer] apply {
            if (_x == "") then {
                TRACE_2("does NOT do something",_customName,_eventName);
                {} // apply return
            } else {
                TRACE_2("does something",_customName,_eventName);
                private _eventFunc = _x;

                //Optimize "QUOTE(call COMPILE_FILE(XEH_preInit));" down to just the content of the EH script
                if (_allowRecompile) then {
                    if (toLower (_eventFunc select [0,40]) isEqualTo "call compile preprocessfilelinenumbers '" && {(_eventFunc select [count _eventFunc - 1]) isEqualTo "'"}) then {
                        private _funcPath = _eventFunc select [40, count _eventFunc - 41];

                        //If there is a quote mark in the path, then something went wrong and we got multiple paths, just skip optimization
                        //Example cause: "call COMPILE_FILE(XEH_preInit);call COMPILE_FILE(XEH_preClientInit)"
                        if (_funcPath find "'" == -1) then {
                            _eventFunc = preprocessFileLineNumbers _funcPath;
                            TRACE_2("eventfunction redirected",_customName,_funcPath);
                        };
                    };
                    // if (_eventFunc isEqualTo _x) then { diag_log text format ["XEH: Could not recompile [%1-%2]: %3", _eventName, _customName, _eventFunc]; };
                };

                compile _eventFunc // apply return
            };
        };

        _result pushBack ["", _eventName, _eventFuncs];
        _resultNames pushBack _customName;
    } forEach configProperties [_baseConfig >> XEH_FORMAT_CONFIG_NAME(_eventName)];
} forEach ["preInit", "postInit"];

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
            WARNING_4("Usage of deprecated Extended Event Handler ""fired"". Use ""firedBIS"" instead. Path: %1\%2\%3\%4.", configSourceMod _x, _baseConfig, XEH_FORMAT_CONFIG_NAME(_eventName), _className);
        };

        {
            private _customName = configName _x;
            private _allowInheritance = true;
            private _excludedClasses = [];
            private _funcAll = "";
            private _funcClient = "";
            private _funcServer = "";

            if (isClass _x) then {
                // allow inheritance of this event?
                private _scope = _x >> "scope";

                if (isNumber _scope) then {
                    _allowInheritance = getNumber _scope != 0;
                };

                // init event handlers that should run on respawn again, onRespawn = 1
                private _onRespawn = toLower _eventName in ["init", "initpost"] && {getNumber (_x >> "onRespawn") == 1};

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
                    _funcAll = _eventFuncBase + getText _entry + ";";

                    if (_onRespawn) then {
                        _funcAll = _funcAll + "(_this select 0) addEventHandler ['Respawn', " + str _funcAll + "];";
                    };
                };

                // client only events
                _entry = _x >> format ["client%1", _entryName];

                if (isText _entry) then {
                    _funcClient = _eventFuncBase + getText _entry + ";";

                    if (_onRespawn) then {
                        _funcClient = _funcClient + "(_this select 0) addEventHandler ['Respawn', " + str _funcClient + "];";
                    };
                };

                // server only events
                _entry = _x >> format ["server%1", _entryName];

                if (isText _entry) then {
                    _funcServer = _eventFuncBase + getText _entry + ";";

                    if (_onRespawn) then {
                        _funcServer = _funcServer + "(_this select 0) addEventHandler ['Respawn', " + str _funcServer + "];";
                    };
                };
            } else {
                // global events
                if (isText _x) then {
                    _funcAll = _eventFuncBase + getText _x + ";";
                };
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

            private _eventFuncs = [_funcAll, _funcClient, _funcServer] apply {
                // only add event on machines where it exists
                if (_x == "") then {
                    TRACE_3("does NOT do something",_customName,_className,_eventName);
                    {}
                } else {
                    TRACE_3("does something",_customName,_className,_eventName);
                    compile _x
                };
            };
            _result pushBack [_className, _eventName, _eventFuncs, _allowInheritance, _excludedClasses];
            _resultNames pushBack _customName;
        } forEach configProperties [_x];
    } forEach configProperties [_baseConfig >> XEH_FORMAT_CONFIG_NAME(_eventName), "isClass _x"];
} forEach [XEH_EVENTS];

TRACE_2("compiled",_baseConfig,count _result);

_result select {!((_x select 2) isEqualTo [{},{},{}])}

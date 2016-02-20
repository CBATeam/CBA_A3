/* ----------------------------------------------------------------------------
Internal Function: CBA_events_fnc_keyHandler

Description:
    Executes the key's handler

Author:
    Sickboy
---------------------------------------------------------------------------- */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"
SCRIPT(keyHandler);

private ["_settings", "_code", "_handled", "_result", "_handlers", "_myHandlers", "_idx", "_data", "_keyhandlers"];
#ifdef DEBUG_MODE_FULL
    private ["_ar"];
    _ar = [];
#endif

params ["_keyData","_type"];
_type = toLower _type;

_idx = _keyData select 1;
if(_idx == 0) exitWith {};

GVAR(keypressed) = time;

_handled = false; // If true, suppress the default handling of the key.
_result = false;

_keyhandlers = if(_type == "keydown") then { GVAR(keyhandlers_down) } else { GVAR(keyhandlers_up) };


if(_type == "keydown") then {
    _handlers = [GVAR(keyhandler_hash), "keydown"] call CBA_fnc_hashGet;
    if (count _handlers > _idx) then {

        _myHandlers = _handlers select _idx;
        if (isNil "_myHandlers") exitWith {};
        if (typeName _myHandlers != "ARRAY") exitWith {};
        {
            _data = [GVAR(keyhandlers_down), _x] call CBA_fnc_hashGet;
            TRACE_2("",_data,_x);
            _settings = _data select 1;
            _code = _data select 2;

            // Verify if the required modifier keys are present
            _valid = true;
            // Cannot compare booleans, so must use ! && etc.
            for "_i" from 0 to 2 do { if (((_settings select _i) && {!(_keyData select (_i + 2))}) || {(!(_settings select _i) && {(_keyData select (_i + 2))})}) exitWith { _valid = false } };
            if (_valid) then {
                #ifdef DEBUG_MODE_FULL
                    _ar pushBack _code;
                #endif

                _holdKey = _data select 3;
                _execute = true;

                _holdDelay = _data select 4;
                _holdTime = 0;
                if(_holdDelay > 0) then {
                    if(!([GVAR(keyHoldTimers), (_x + "_cbadefaultuphandler")] call cba_fnc_hashHasKey)) then {
                        [GVAR(keyHoldTimers), (_x + "_cbadefaultuphandler"), diag_tickTime + _holdDelay] call cba_fnc_hashSet;
                    };
                    _holdTime = [GVAR(keyHoldTimers), (_x + "_cbadefaultuphandler")] call cba_fnc_hashGet;
                    if(diag_tickTime < _holdTime) then {
                        _execute = false;
                    };
                };
                if(_execute) then {
                    if(!_holdKey) then {
                        if((_x + "_cbadefaultuphandler") in GVAR(keyDownList)) then {
                            _execute = false;
                        } else {
                            GVAR(keyDownList) pushBack (_x + "_cbadefaultuphandler");
                        };
                    };
                    if(_execute) then {
                        _args = +_keyData;
                        _args pushBack +_data;
                        _args pushBack _x;
                        _result = _args call _code;

                        if (isNil "_result") then {
                            TRACE_1("WARNING: Non-boolean result from handler.",_result);
                            _result = false;
                        }
                        else {
                            if (typeName _result != "BOOL") then {
                                TRACE_1("WARNING: Non-boolean result from handler.",_result);
                                _result = false;
                            };
                        };

                        // If any handler says that it has completely _handled_ the keypress,
                        // then don't allow other handlers to be tried at all.
                    };
                };
                if (_result) exitWith { _handled = true };
            };
        } forEach _myHandlers;
    };
    /*
    Too have a valid key up we first need to have a valid key down of the same combo!

    If we do, we add it to a list of pressed key up combos, then on key up we check that
    list to see if we have a valid key up.
    */
    _handlers = [GVAR(keyhandler_hash), "keyup"] call CBA_fnc_hashGet;
    if (count _handlers > _idx) then {
        _myHandlers = _handlers select _idx;
        if (isNil "_myHandlers") exitWith {};
        if (typeName _myHandlers != "ARRAY") exitWith {};
        {
            if(!(_x in GVAR(keyUpDownList))) then {
                _data = [GVAR(keyhandlers_up), _x] call CBA_fnc_hashGet;
                TRACE_2("",_data,_x);
                _settings = _data select 1;
                _code = _data select 2;
                // Verify if the required modifier keys are present
                _valid = true;
                // Cannot compare booleans, so must use ! && etc.
                for "_i" from 0 to 2 do { if (((_settings select _i) && {!(_keyData select (_i + 2))}) || {(!(_settings select _i) && {(_keyData select (_i + 2))})}) exitWith { _valid = false } };
                if (_valid) then {
                    #ifdef DEBUG_MODE_FULL
                        _ar pushBack _code;
                    #endif

                    GVAR(keyUpDownList) pushBack _x;
                };
            };
        } forEach _myHandlers;
    };
} else {
    _handlers = [GVAR(keyhandler_hash), "keyup"] call CBA_fnc_hashGet;

    _ignoredUpKeys = [];
    _remHandlers = [];
    {
        _data = [GVAR(keyhandlers_up), _x] call CBA_fnc_hashGet;
        TRACE_2("",_data,_x);
        _key = _data select 0;
        _settings = _data select 1;
        _code = _data select 2;
        // Verify if the required modifier keys are present
        if (_key == _idx ||
            {_idx == 0x2A} || {_idx == 0x36} || // shift
            {_idx == 0x1D} || {_idx == 0x9D} || // ctrl
            {_idx == 0x38} || {_idx == 0xB8}    // alt
        ) then {
            if(!(_key in _ignoredUpKeys)) then {
                _valid = false;
                // Cannot compare booleans, so must use ! && etc.
                if(_idx != _key) then {
                    if((_settings select 0) && {_idx == 0x2A} || {_idx == 0x36}) then {
                        _valid = true;
                    } else {
                        if((_settings select 1) && {_idx == 0x1D} || {_idx == 0x9D}) then {
                            _valid = true;
                        } else {
                            if((_settings select 2) && {_idx == 0x38} || {_idx == 0xB8}) then {
                                _valid = true;
                            };
                        };
                    };
                } else {
                    _valid = true;
                };
                if (_valid) then {
                    _args = +_keyData;
                    _args pushBack +_data;
                    _args pushBack _x;
                    _result = _args call _code;

                    if (isNil "_result") then {
                        WARNING("Nil result from handler.");
                        _result = false;
                    }
                    else {
                        if (typeName _result != "BOOL") then {
                            TRACE_1("WARNING: Non-boolean result from handler.",_result);
                            _result = false;
                        };
                    };
                    _remHandlers pushBack _x;
                    // If any handler says that it has completely _handled_ the keypress,
                    // then don't allow other handlers to be tried at all.
                    if (_result) then { _ignoredUpKeys pushBack _key; };
                };
            } else {
                _remHandlers pushBack _x;
            };

        };
    } forEach GVAR(keyUpDownList);
    GVAR(keyUpDownList) = GVAR(keyUpDownList) - _remHandlers;
};
TRACE_4("keyPressed",_this,_ar,_myHandlers,_handled);

_handled;

/* ----------------------------------------------------------------------------
Function: CBA_fnc_addKeyHandler

Description:
    Adds an action to a keyhandler

Parameters:
    _key - Numerical key to attach action to [Integer].
    _settings - Shift, Ctrl, Alt required [Array].
    _code - Code to execute upon event [Code].
    _type - "keydown" (default) = keyDown,  "keyup" = keyUp [String].
    _hashKey - used to identify this handler, randomly generated if not supplied [String].
    _holdKey - Will the key fire every frame while down [Bool]
    _holdDelay - How long after keydown will the key event fire, in seconds. [Float]

Returns:
    Hash key [String]

Examples:
    (begin example)
        [47, [true, false, false], { _this call myAction }] call CBA_fnc_addKeyHandler;
    (end)

Author:
    Sickboy

---------------------------------------------------------------------------- */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"
SCRIPT(addKeyHandler);

private ["_ar", "_entry", "_type", "_handlers", "_hashKey", "_holdDelay"];
params ["_key","_settings","_code"];
_type = if (count _this > 3) then { _this select 3 } else { "keydown" };
_type = toLower _type;
_hashKey = if (count _this > 4) then { _this select 4 } else { format["%1%2%3%4%5%6%7%8", floor(random 100), floor(random 100), floor(random 100), floor(random 100), floor(random 100), floor(random 100), floor(random 100), floor(random 100)] };
_hashKey = toLower(_hashKey);
_holdKey = if (count _this > 5) then { _this select 5 } else { true };
_holdDelay = if (count _this > 6) then { _this select 6 } else { 0 };

if (_type in KEYS_ARRAY_WRONG) then { _type = ("key" + _type) };
if !(_type in KEYS_ARRAY) exitWith { ERROR("Type does not exist") };

if(_type == "keydown") then {
    _upHandlerArgs = +_this;
    _upHandlerArgs set[2, FUNC(handleKeyDownUp)];
    _upHandlerArgs set[3, "keyup"];
    _upHandlerArgs set[4, _hashKey+"_cbadefaultuphandler"];
    _upHandlerArgs call cba_fnc_addKeyHandler;
};

[if (_type == "keydown") then { GVAR(keyhandlers_down) } else { GVAR(keyhandlers_up) }, _hashKey, [_key, _settings, _code, _holdKey, _holdDelay]] call CBA_fnc_hashSet;


_handlers = [GVAR(keyhandler_hash), _type] call CBA_fnc_hashGet;

if (_key > count _handlers) then {_handlers resize(_key + 1)};
_ar = _handlers select _key;
if (isNil"_ar")then{_ar=[]};
_ar pushBack _hashKey;
_handlers set [_key, _ar];

_hashKey;

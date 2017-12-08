//#define DEBUG_MODE_FULL
#include "\x\cba\addons\ui\script_component.hpp"

#define _minObjDist(_var) (if (_var isKindOf "CAManBase") then {3} else {(2 max (1.4 + (sizeOf typeOf _var) / 2))}) // minimum object interaction distance: arbitrary distance. Might not work with very long/large vehicles. TODO: Find a very fast way to determine vehicle size.

private [
    "_handled", "_target", "_menuSource", "_active", "_potentialTarget", "_isTypeTarget",
    "_potentialKeyMatch", "_potentialMenuSources", "_vehicleTarget", "_typesList",
    "_keys", "_settings"
];
params ["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt"];

_handled = false;

// prevent unneeded cpu usage due to key down causing repeated event trigger
if (time-(GVAR(lastAccessCheck) select 0) < 0.220 && {(GVAR(lastAccessCheck) select 1) == _dikCode}) exitWith {_handled};
GVAR(lastAccessCheck) = [time, _dikCode];

TRACE_1("",GVAR(lastAccessCheck));

// scan typeMenuSources key list (optimise overhead)
_potentialKeyMatch = false;
{
    // syntax of _keys: [[_dikCode1, [_shift, _ctrlKey, _alt]], [_dikCode2, [...]], ...]
    _keys = _x select 1;
    TRACE_2("",_flexiMenu_typeMenuSources_ID_DIKCodes,_x);
    {
        TRACE_5("",_x,_dikCode,_shift,_ctrlKey,_alt);
        _settings = _x select 1;
        if ((_x select 0 == _dikCode) &&
            {((!_shift && {!(_settings select 0)}) || {(_shift && {(_settings select 0)})})} &&
            {((!_ctrlKey && {!(_settings select 1)}) || {(_ctrlKey && {(_settings select 1)})})} &&
            {((!_alt && {!(_settings select 2)}) || {(_alt && {(_settings select 2)})})}
        ) exitWith {
            _potentialKeyMatch = true;
            TRACE_1("",_potentialKeyMatch);
        };
    } forEach _keys;
    TRACE_1("",_potentialKeyMatch);
    if (_potentialKeyMatch) exitWith {};
} forEach GVAR(typeMenuSources);

TRACE_1("",_potentialKeyMatch);

// check if interaction key used
if !(_potentialKeyMatch) exitWith {
    TRACE_1("No potential keymatch",nil);
    _handled
};
//-----------------------------------------------------------------------------
if (!GVAR(optionSelected) || !GVAR(holdKeyDown)) then {
    // check if menu already open
    _active = (!isNil {uiNamespace getVariable QGVAR(display)});
    if (_active) then {
        _active = (!isNull (uiNamespace getVariable QGVAR(display)));
    };
    if (_active) then {
        if (!GVAR(holdKeyDown)) then {
            closeDialog 0;
        };
    } else {
        // examine cursor object for relevant menu def variable
        _target = objNull;
        _isTypeTarget = false;

        // check for [cursorTarget or "player" or "vehicle"] types in typeMenuSources list
        _objects = nearestObjects [player, [], 1.5];
        {
            (group player) reveal _x;
        } forEach _objects;
        _potentialTarget = cursorTarget;
        if (!isNull _potentialTarget && {_potentialTarget distance player > _minObjDist(_potentialTarget)}) then {_potentialTarget = objNull};
        _vehicleTarget = vehicle player;

        if (_vehicleTarget == player) then {_vehicleTarget = objNull};

        _potentialMenuSources = [];

        { // forEach
            _potentialKeyMatch = false; // "_actualKeyMatchFound"
            _keys = _x select 1;
            {
                _settings = _x select 1;
                if ((_x select 0 == _dikCode) &&
                    {((!_shift && {!(_settings select 0)}) || {(_shift && {(_settings select 0)})})} &&
                    {((!_ctrlKey && {!(_settings select 1)}) || {(_ctrlKey && {(_settings select 1)})})} &&
                    {((!_alt && {!(_settings select 2)}) || {(_alt && {(_settings select 2)})})} ) exitWith
                {
                    _potentialKeyMatch = true;
                };
            } forEach _keys;

            if (_potentialKeyMatch) then {
                if (!alive player && {(_x select 4)}) exitWith {};
                _typesList = _x select _flexiMenu_typeMenuSources_ID_type;
                if (typeName _typesList == "String") then {_typesList = [_typesList]}; // single string type

                if (({_potentialTarget isKindOf _x} count _typesList > 0) || {({_vehicleTarget isKindOf _x} count _typesList > 0)} || {("player" in _typesList)}) then {
                    if (count _potentialMenuSources == 0) then {
                        _isTypeTarget = true;
                        _target = if ((_vehicleTarget != player) &&
                            {({_vehicleTarget isKindOf _x} count _typesList > 0)}) then {_vehicleTarget} else {_potentialTarget};
                        if ("player" in _typesList) then {
                            _target = player;
                        };
                    };
                    _potentialMenuSources pushBack (_x select _flexiMenu_typeMenuSources_ID_menuSource);
                };
            };
        } forEach GVAR(typeMenuSources);

        if (!isNull _target) then {
            private ["_menuSources", "_menuSource"]; // sometimes nil
            _menuSources = [];
            _menuSource = _target getVariable QGVAR(flexiMenu_source);
            if (isNil "_menuSource") then {_menuSource = []} else {_menuSources pushBack _menuSource};
            TRACE_2("",_menuSource,_menuSources);
            {
                _menuSources pushBack _x;
            } forEach _potentialMenuSources;

            TRACE_2("",_target, _menuSources);
            if (count _menuSources > 0) then {
                // show menu dialog and load menu data
                GVAR(target) = _target; // global variable used since passing an object as a string is too difficult.
                [_target, _menuSources] call FUNC(menu);
                _handled = true;
            };
        };
    };
} else {
    TRACE_1("xxx",nil);
};

TRACE_1("",_handled);
_handled

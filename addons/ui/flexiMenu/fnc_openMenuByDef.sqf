#include "\x\cba\addons\ui\script_component.hpp"
#include "\x\cba\addons\ui_helper\script_dikCodes.hpp"

#define _minObjDist(_var) (if (_var isKindOf "CAManBase") then {3} else {(2 max (1.4 + (sizeOf typeOf _var) / 2))}) // minimum object interaction distance: arbitrary distance. Might not work with very long/large vehicles. TODO: Find a very fast way to determine vehicle size.

private [
    "_target", "_menuSource", "_potentialTarget", "_isTypeTarget", "_potentialMenuSources",
    "_vehicleTarget", "_typesList", "_keys", "_settings"
];

// Call this function with the exact parameter set passed to fleximenu_fnc_add.
_addParameters = _this;

// Return true if menu was found, false if not.
_opened = false;

// Code reuse from fnc_keyDown below, recommented.

if (!GVAR(optionSelected) || !GVAR(holdKeyDown)) then {
    // Doing something with the menu.
    _opened = true;

    // Check if a menu is already open.
    _active = (!isNil {uiNamespace getVariable QGVAR(display)});
    if (_active) then {
        _active = (!isNull (uiNamespace getVariable QGVAR(display)));
    };

    // If a menu is open and the key isn't being held, close it and exit.
    if (_active) then {
        if (!GVAR(holdKeyDown)) then {
            closeDialog 0;
        };

    // Otherwise, see if there is a menu to open.
    } else {
        // Initialize.
        _target = objNull;
        _isTypeTarget = false;

        // Get near objects into an array.
        _objects = nearestObjects [player, [], 1.5];
        {
            (group player) reveal _x;
        } forEach _objects;

        // Get cursortarget.
        _potentialTarget = cursorTarget;

        // If the cursortarget is null and their are no object within the minObjDist,
        // there's no potential target (so _potentialTarget = objNull)
        if (!isNull _potentialTarget && {_potentialTarget distance player > _minObjDist(_potentialTarget)}) then {_potentialTarget = objNull};

        // Also check if we're in a vehicle and could interact with it internally.
        _vehicleTarget = vehicle player;
        if (_vehicleTarget == player) then {_vehicleTarget = objNull};

        // Search the defined menus to find one matching the passed parameters.
        // If one is found, see if any of our targets match its possible targets.
        _potentialMenuSources = [];
        {
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
        } forEach [_addParameters];

        // If a matching target was found, open the highest priority menu associated with it
        // by calling FUNC(menu).
        if (!isNull _target) then {
            private ["_menuSources", "_menuSource"];

            _menuSources = [];
            _menuSource = _target getVariable QGVAR(flexiMenu_source);
            if (isNil "_menuSource") then {_menuSource = []} else {_menuSources pushBack _menuSource};
            {
                _menuSources pushBack _x;
            } forEach _potentialMenuSources;

            if (count _menuSources > 0) then {
                GVAR(target) = _target;
                [_target, _menuSources] call FUNC(menu);
            };
        };
    };
};

_opened;

/* ----------------------------------------------------------------------------
Function: CBA_fnc_inArea

Description:
    A function used to determine if a position is within a zone.

    The "position" can be given as a marker name, an object,
    location, group or a position array.

    The zone is specificed either as a marker name or a trigger.

Parameters:
    A two-element array, [ position, zone], where

    - position: <MARKER, OBJECT, LOCATION, GROUP, POSITION>
    - zone:     <MARKER, TRIGGER>

Example:
    (begin example)
        // Is the marker "playermarker" inside the "safezone" marker area?
        _safe = [ "playermarker", "safezone"] call CBA_fnc_inArea;

        // is the player within the safe zone marker area?
        _pos = getPos player;
        _safe = [ _pos, "safezone" ] call CBA_fnc_inArea;

        // Deny artillery if target is inside the trigger area
        if ([_target, cityTrigger] call CBA_fnc_inArea) then
        {
            // deny fire mission
        }
        else
        {
            // fire away!
        };
    (end)

Returns:
    <BOOLEAN>

Author:
    Rommel
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(inArea);

params ["_position", ["_zRef", objNull, ["", objNull]]];

_position = _position call CBA_fnc_getPos;

private ["_zSize","_zDir","_zShape","_zPos"];

switch (typeName _zRef) do {
    case "STRING": {
        _zSize = markerSize _zRef;
        _zDir = markerDir _zRef;
        _zShape = toLower (markerShape _zRef);
        _zPos = (_zRef call CBA_fnc_getPos);
    };
    case "OBJECT": {
        _zSize = triggerArea _zRef;
        _zDir = _zSize select 2;
        _zShape = if (_zSize select 3) then {"rectangle"} else {"ellipse"};
        _zPos = getPos _zRef;
    };
};

if (isNil "_zSize") exitWith {false};

_position = [_zPos, _position, _zDir] call CBA_fnc_vectRotate2D;

_zPos params ["_x1", "_y1"];
_position params ["_x2", "_y2"];

private _dx = _x2 - _x1;
private _dy = _y2 - _y1;

_zSize params ["_zx", "_zy"];

switch (_zShape) do {
    case "ellipse": {
        ((_dx^2)/(_zx^2) + (_dy^2)/(_zy^2)) < 1
    };
    case "rectangle": {
        (abs _dx < _zx) && (abs _dy < _zy)
    };
    default {
        false
    };
};

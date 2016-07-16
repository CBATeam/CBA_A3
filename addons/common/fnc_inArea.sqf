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

params ["_position", ["_zRef", objNull, ["", objNull, locationNull, []], 5]];

_position = _position call CBA_fnc_getPos;
_position inArea _zRef;

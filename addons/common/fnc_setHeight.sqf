/* ----------------------------------------------------------------------------
Function: CBA_fnc_setHeight

Description:
    A function used to set the height of an object

Parameters:
    _object - <OBJECT, LOCATION>
    _height - Height in metres <NUMBER>
    _type   - Mode (optional, default: 1), 0 is AGL, 1 is ASL, 2 is ATL (Default: 1)

Example:
    (begin example)
        [this, 10] call CBA_fnc_setHeight
    (end)

Returns:
    Nothing

Author:
    Rommel
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(setHeight);

params [["_object", objNull, [objNull]], ["_height", 0, [0]], ["_type", 1, [0]]];

private _position = switch (_type) do {
    case 0 : {getPos _object};
    case 1 : {getPosASL _object};
    case 2 : {getPosATL _object};
};

_position set [2, _height];

switch (_type) do {
    case 0 : {_object setPos _position};
    case 1 : {_object setPosASL _position};
    case 2 : {_object setPosATL _position};
};

_object setDir (getDir _object);

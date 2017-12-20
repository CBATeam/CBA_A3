#include "script_component.hpp"

params [["_id", "catenary", [""]], ["_data", [], [[]]], ["_color", [1,0,0,1], [[]], [3,4]]];

_id = format ["cba_debug_%1", _id];

if (_data isEqualTo []) exitWith {
    [_id, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
};

if (count _color isEqualTo 3) then {
    _color = _color + [1];
};

[_id, "onEachFrame", {
    params ["_color", "_data"];
    _data params ["_points", "_posStart", "_posEnd"];

    {
        private _start = _x;
        private _end = _points param [_forEachIndex + 1, _x];

        drawLine3D [ASLToAGL _start, ASLToAGL _end, _color];
    } forEach _points;

    {
        drawIcon3D [
            "\a3\weapons_f\acc\data\collimdot_red_ca.paa",
            _color,
            ASLToAGL _x,
            1,
            1,
            45,
            "",
            0,
            0.05
        ];
    } forEach [_posStart, _posEnd];
}, [_color, _data]] call BIS_fnc_addStackedEventHandler;

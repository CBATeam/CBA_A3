#include "script_component.hpp"
#include "\A3\ui_f\hpp\defineDIKCodes.inc"

params ["_display"];

add3DENEventHandler ["OnSelectionChange", {
    private _display = findDisplay 313;
    private _selected = get3DENSelected "logic" select {typeOf _x == QGVAR(start)};

    {
        ctrlDelete _x;
    } forEach (_display getVariable [QGVAR(crosshair), []]);

    if (count _selected > 0) then {
        private _horizontal = _display ctrlCreate ["RscText", -1];
        private _vertical = _display ctrlCreate ["RscText", -1];

        _horizontal ctrlSetBackgroundColor [1,0,0,1];
        _vertical ctrlSetBackgroundColor [1,0,0,1];

        #define THICKNESS 0.001
        #define LENGTH 0.01

        _horizontal ctrlSetPosition [
            0.5 - safezoneW * LENGTH/2,
            0.5 - safezoneH * THICKNESS/2,
            safezoneW * LENGTH,
            safezoneH * THICKNESS
        ];

        _vertical ctrlSetPosition [
            0.5 - safezoneW * THICKNESS/2,
            0.5 - safezoneH * LENGTH/2 * (getResolution select 4),
            safezoneW * THICKNESS,
            safezoneH * LENGTH * (getResolution select 4)
        ];

        if !(_display getVariable [QGVAR(hintShown), false]) then {
            _display setVariable [QGVAR(hintShown), true];
            systemChat "Press P to place the catenary module at the first intersection with the crosshair.";
            systemChat "Press O to replace the catenary module with a rope.";
        };

        _horizontal ctrlCommit 0;
        _vertical ctrlCommit 0;

        _display setVariable [QGVAR(crosshair), [_horizontal, _vertical]];
    };
}];

_display displayAddEventHandler ["KeyDown", {
    params ["", "_key", "_shift", "_control", "_alt"];

    if (_key isEqualTo DIK_P) then {
        private _selected = get3DENSelected "logic" select {typeOf _x == QGVAR(start)};

        if (count _selected == 0) exitWith {};
        if (count _selected > 1) exitWith {
            "Only one logic can be moved at a time." call BIS_fnc_error;
        };

        _selected = _selected select 0;

        private _position = lineIntersectsSurfaces [
            AGLToASL positionCameraToWorld [0,0,0],
            AGLToASL positionCameraToWorld [0,0,1000],
            objNull, objNull,
            true, 1
        ] param [0, [[]]] select 0;

        if (_position isEqualTo []) exitWith {
            "No intersection found." call BIS_fnc_error;
        };

        _selected set3DENAttribute ["position", ASLToAGL _position];
    };

    if (_key isEqualTo DIK_O) then {
        private _selected = get3DENSelected "logic" select {typeOf _x == QGVAR(start)};

        {
            _x call FUNC(commit);
        } forEach _selected;
    };
}];

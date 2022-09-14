#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_addTerrainHeight

Description:
    Add terrain height to an area. 

Parameters:
    _area - argument compatible with https://community.bistudio.com/wiki/BIS_fnc_getArea 
        [TRIGGER, MARKER, LOCATION, ARRAY]
    _height - height in metres to add. Negative number lowers terrain [NUMBER]
    _adjustObjects - Adjust objects to new height [BOOL]
    _smooth - if true, add 0 height at edge of area and _height at centre with smooth interpolation between


Returns:
    Whether the terrain was succesfully changed

Examples:
    ["marker1", 20, false, true] call CBA_fnc_addTerrainHeight

Author:
    Seb
---------------------------------------------------------------------------- */
params [
    "_area",
    "_height",
    "_adjustObjects",
    "_smooth"
];
private _positionsAndHeightsCurrent = _area call CBA_fnc_getAreaTerrainGrid;
private _positionsAndHeightsNew = if (_smooth) then {
    (_area call BIS_fnc_getArea) params ["_centre", "_a", "_b", "_angle", "_isRectangle", ""];
    private _fnc_easeInOut = {
        params ["_alpha"];
        private _power = 2;
        private _raised = _alpha^_power;
        _raised/(_raised+(1-_alpha)^_power)
    };
    private _delta = abs (_a-_b);
    private _mode = _a>_b;
    _positionsAndHeightsCurrent apply {
        private _pos = _x;
        private _distance = _centre distance2D _pos;
        private _alpha = if (_isRectangle) then {
            // Direction this terrain point to centre of area
            private _dirTo = (_pos getDir _centre) - _angle;
            // Orthogonal distance in coordspace of the area.
            private _distA = abs (sin _dirTo) * _distance;
            private _distB = abs (cos _dirTo) * _distance;
            if (_mode) then {
                // Smooth off end of longest side at same ratio as shortest
                private _factorA = 0 max (_distA-_delta)/_b;
                // Smooth between edge of shortest edge and centre
                private _factorB = _distB/_b;
                1-(_factorA max _factorB)
            } else {
                // Inverse of above when side lengths are reversed
                private _factorA = _distA/_a;
                private _factorB = 0 max (_distB-_delta)/_a;
                1-(_factorA max _factorB)
            }
        } else {
            // Find point that lies on an ellipse at the angle to the curent point
            // Divide distance to current by point by to centre by distance to edge to get factor
			private _theta = (_centre getDir _pos) - _angle + 90;
			private _sinSquare = (1 - cos(2*_theta))/2;
			private _cosSquare = 1-_sinSquare;
			private _r = (_a*_b)/(sqrt (((_a^2)*_sinSquare)+((_b^2)*_cosSquare)));
			1-(_distance/_r);   
        }; 
        _alpha = _alpha call _fnc_easeInOut;
        private _add = _height * _alpha;
        _pos vectorAdd [0, 0, _add]
    }
} else {
    _positionsAndHeightsCurrent apply {_x vectorAdd [0, 0, _height]}
};
[_positionsAndHeightsNew, _adjustObjects] call CBA_fnc_setTerrainHeight

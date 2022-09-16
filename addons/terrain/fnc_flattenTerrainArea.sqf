#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_flattenTerrainArea

Description:
    Flatten the terrain by setting points within the specified area to a specified height.

Parameters:
    _area - argument compatible with https://community.bistudio.com/wiki/BIS_fnc_getArea 
        [TRIGGER, MARKER, LOCATION, ARRAY]
    _height - heightASL to set the height. Negative number lowers terrain [NUMBER]
    _adjustObjects - Adjust objects to new height [BOOL]
    _edgeSize - Number 0..1 controlling the size of the blended area between _height and the existing terrain.
        0 = No blending (Instant step between existing terrain and _height)
        0.5 = Half the distance to the centre will be _height, half will be transitional region
        1 = All blended (centre of _area will be _height, smooth transition between)
    _smoothMode - Interpolation function for _edgeSize
        0 - Linear
        1 - Smooth in
        2 - Smooth out
        3 - Smooth in & out
    [NUMBER]
    _smoothPower - How strong the smoothing mode is applied. Numbers less than 1 will result in odd behaviour.
    [NUMBER]


Returns:
    Whether the terrain was succesfully changed

Examples:
    (BEGIN EXAMPLE)
        [[player, 150], (getPosASL player)#2, true, 1, 3, 2] call CBA_fnc_flattenTerrainArea
    (END EXAMPLE)

Author:
    Seb
---------------------------------------------------------------------------- */
params [
    "_area",
    "_height",
    "_adjustObjects",
    "_edgeSize",
    "_smoothMode",
    "_smoothPower"
];
_edgeSize = 0 max (1 min _edgeSize);
private _positionsAndHeightsCurrent = _area call CBA_fnc_getAreaTerrainGrid;
private _positionsAndHeightsNew = if (_edgeSize != 0) then {
    (_area call BIS_fnc_getArea) params ["_centre", "_a", "_b", "_angle", "_isRectangle", ""];
    private _fnc_interpolate = switch (_smoothMode) do {
        // https://www.desmos.com/calculator/3lr40hyzkk
        case 0: {
            {
                // Linear interpolation
                params ["_alpha", "_power"];
                _alpha
            }
        };
        case 1: {
            {			
                // Ease in
                params ["_alpha", "_power"];
                _alpha^_power
            }
        };
        case 2: {
            {
                // Ease out
                params ["_alpha", "_power"];
                _alpha^(1/_power)
            }
        };
        case 3: {
            {
                // EaseinOut
                params ["_alpha", "_power"];
                private _raised = _alpha^_power;
                _raised/(_raised+(1-_alpha)^_power)
            }
        };
        default {
            {
                // Default to linear
                params ["_alpha", "_power"];
                _alpha
            }
        };
    };


    private _mode = _a>_b;
    private _delta = (abs (_a-_b));
    private _shortestEdge = _a min _b;
    private _flatSize = (1-_edgeSize) * _shortestEdge;
    private _blendedSize = (_edgeSize) * _shortestEdge;
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
                private _factorA = 0 max (( _distA - _delta - _flatSize )/ _blendedSize );
                // Smooth between edge of shortest edge and centre
                private _factorB = 0 max (( _distB - _flatSize )/ _blendedSize );
                1-(_factorA max _factorB)
            } else {
                // Inverse of above when side lengths are reversed
                private _factorA = 0 max (( _distA - _flatSize ) / _blendedSize );
                private _factorB = 0 max (( _distB - _delta - _flatSize ) / _blendedSize );
                1-(_factorA max _factorB)
            }
        } else {
            // Find point that lies on an ellipse at the angle to the curent point
            // Divide distance to current by point by to centre by distance to edge to get factor
            private _theta = (_centre getDir _pos) - _angle + 90;
            private _sinSquare = (1 - cos(2*_theta))/2;
            private _cosSquare = 1-_sinSquare;
            // Radius of ellipse at the current angle
            private _r = (_a*_b)/(sqrt (((_a^2)*_sinSquare)+((_b^2)*_cosSquare)));
            // Size of blended area
            private _edgeDist = _edgeSize * _r;
            // 1..0 in blended area, clamped to 1.
            1 min ((_r-_distance)/_edgeDist);
        };
        _alpha = [_alpha, _smoothPower] call _fnc_interpolate;
        private _currentZ = _pos#2;
        private _heightChange = (_height - _currentZ) * _alpha;
        _pos vectorAdd [0, 0, _heightChange]
    }
} else {
    _positionsAndHeightsCurrent apply {
        _x set [2, _height];
        _x
    }
};
[_positionsAndHeightsNew, _adjustObjects] call CBA_fnc_setTerrainHeight

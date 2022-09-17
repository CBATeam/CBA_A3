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
    _edgeSize - Number 0..1 controlling the size of the blended area between _height and the existing terrain.
        0 = No blending (Instant step between existing terrain and _height)
        0.5 = Half the distance to the centre will be _height, half will be transitional region
        1 = All blended (centre of _area will be _height, smooth transition between)
        [NUMBER]
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
        [[player, 25], -15, true, 1, 2, 2] call CBA_fnc_addTerrainHeight
    (END EXAMPLE)

Author:
    Seb
---------------------------------------------------------------------------- */
params [
    ["_areaArg", objNull, [objNull, "", locationNull, []]],
    ["_height" , 0, [0]],
    ["_adjustObjects", true, [true]],
    ["_edgeSize", 1, [1]],
    ["_smoothMode", 3, [1]],
    ["_smoothPower", 2, [1]]
];
_edgeSize = 0 max (1 min _edgeSize);
private _positionsAndHeightsCurrent = [_areaArg] call CBA_fnc_getAreaTerrainGrid;
private _positionsAndHeightsNew = if (_edgeSize != 0) then {
    private _area = (_areaArg call BIS_fnc_getArea);
    _area params ["_centre", "_a", "_b", "_angle", "_isRectangle", ""];
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
        private _alpha = [_area, _pos, _mode, _delta, _flatSize, _blendedSize, _edgeSize] call FUNC(shapePositionAlpha);
        _alpha = [_alpha, _smoothPower] call _fnc_interpolate;
        private _add = _height * _alpha;
        _pos vectorAdd [0, 0, _add]
    }
} else {
    _positionsAndHeightsCurrent apply {_x vectorAdd [0, 0, _height]}
};
[_positionsAndHeightsNew, _adjustObjects] call CBA_fnc_setTerrainHeight

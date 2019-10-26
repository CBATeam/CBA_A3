#include "script_component.hpp"

params ["_control"];
private _display = ctrlParent _control;
ctrlPosition _control params ["_left", "_top", "_width", "_height"];

// --- data
private _minX = 0;
private _maxX = 2*pi;
private _minY = -1;
private _maxY = 1;

private _lineWidth = 2*pixelW;
private _lineHeight = 2*pixelH;

private _points = 1000; //3*ceil (_width/_lineWidth);

private _deltaX = (_maxX - _minX) / _points;
private _lineColor = [1,0,0,1];

// --- curves
{
    for "_i" from 1 to _points do {
        private _x = _minX + _deltaX*(_i-1);
        private _y = sin deg _x;

        _x = linearConversion [_minX, _maxX, _x, 0, _width];
        _y = linearConversion [_minY, _maxY, _y, 0, _height];

        private _segment = _display ctrlCreate ["RscText", -1, _control];
        _segment ctrlSetPosition [
            _x-_lineWidth/2,
            _y-_lineHeight/2,
            _lineWidth, _lineHeight
        ];
        _segment ctrlCommit 0;
        _segment ctrlSetBackgroundColor _lineColor;
    };
} forEach (_control getVariable ["curves", [1]]);

// --- labels
{} forEach (_control getVariable ["labels", []]);

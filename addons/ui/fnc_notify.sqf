#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_notify

Description:
    Display a text message. Multiple incoming messages are queued.

Parameters:
    _content - ARRAY
        _line1 - ARRAY
        _line2 - ARRAY
        ...
        _lineN - ARRAY
            _text  - STRING, NUMBER: Text to display or path to .paa or .jpg image.
            _size  - NUMBER: Text or image size multiplier, optional, default: 1
            _color - ARRAY: RGB or RGBA color (range 0-1), optional, default: [1,1,1,1]

Examples:
    (begin example)
    (end)

Returns:
    Nothing

Authors:
    commy2
---------------------------------------------------------------------------- */

#define LIFE_TIME 4
#define FADE_IN_TIME 0.2
#define FADE_OUT_TIME 1

if (canSuspend) exitWith {
    [CBA_fnc_notify, _this] call CBA_fnc_directCall;
};

if (!hasInterface) exitWith {};

// compose structured text
if !(_this isEqualType []) then {
    _this = [_this];
};

if !(_this select 0 isEqualType []) then {
    _this = [_this];
};

private _composition = [];

{
    _composition pushBack lineBreak;
    _x params [["_text", "", ["", 0]], ["_size", 1, [0]], ["_color", [], [[]], [3,4]]];

    _size = _size * 0.55 / (getResolution select 5);

    _color params [
        ["_r", 1, [0]],
        ["_g", 1, [0]],
        ["_b", 1, [0]],
        ["_a", 1, [0]]
    ];
    _color = [_r, _g, _b, _a] call BIS_fnc_colorRGBAtoHTML;

    private _isImage = toLower _text select [count _text - 4] in [".paa", ".jpg"];
    if (_isImage) then {
        _composition pushBack parseText format ["<img align='center' size='%2' color='%3' image='%1'/>", _text, _size, _color];
    } else {
        _composition pushBack parseText format ["<t align='center' size='%2' color='%3'>%1</t>", _text, _size, _color];
    };
} forEach _this;

_composition deleteAt 0;

// add the queue
if (isNil QGVAR(notifyQueue)) then {
    GVAR(notifyQueue) = [];
};

GVAR(notifyQueue) pushBack _composition;

private _fnc_processQueue = {
    private _composition = _this;

    QGVAR(notify) cutRsc ["RscTitleDisplayEmpty", "PLAIN", 0, true];
    private _display = uiNamespace getVariable "RscTitleDisplayEmpty";

    private _vignette = _display displayCtrl 1202;
    _vignette ctrlShow false;

    private _control = _display ctrlCreate ["RscStructuredText", -1];
    _control ctrlSetStructuredText composeText _composition;
    _control ctrlSetBackgroundColor [0,0,0,0.5];

    private _left = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(notify),x)', safezoneX + safezoneW - 16 * GUI_GRID_W];
    private _top = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(notify),y)', safezoneY + 6 * GUI_GRID_H];
    private _width = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(notify),w)', 15 * GUI_GRID_W];
    private _height = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(notify),h)', 3 * GUI_GRID_H];

    _width = ctrlTextWidth _control max _width;

    // need to set this before reading the text height, to get the correct amount of auto line breaks
    _control ctrlSetPosition [0, 0, _width, _height];
    _control ctrlCommit 0;

    _height = ctrlTextHeight _control max _height;

    // ensure the box not going off screen
    private _right = _left + _width;
    private _bottom = _top + _height;

    private _leftEdge = safezoneX;
    private _rightEdge = safezoneW + safezoneX;
    private _topEdge = safezoneY;
    private _bottomEdge = safezoneH + safezoneY;

    if (_right > _rightEdge) then {
        _left = _left - (_right - _rightEdge);
    };

    if (_left < _leftEdge) then {
        _left = _left + (_leftEdge - _left);
    };

    if (_bottom > _bottomEdge) then {
        _top = _top - (_bottom - _bottomEdge);
    };

    if (_top < _topEdge) then {
        _top = _top + (_topEdge - _top);
    };

    _control ctrlSetPosition [_left, _top, _width, _height];

    // fade in
    _control ctrlSetFade 1;
    _control ctrlCommit 0;
    _control ctrlSetFade 0;
    _control ctrlCommit (FADE_IN_TIME);

    // pop queue
    [{
        params ["_control", "_fnc_processQueue"];

        GVAR(notifyQueue) deleteAt 0;
        private _composition = GVAR(notifyQueue) select 0;

        if (!isNil "_composition") then {
            _composition call _fnc_processQueue;
        } else {
            _control ctrlSetFade 1;
            _control ctrlCommit (FADE_OUT_TIME);
        };
    }, [_control, _fnc_processQueue], LIFE_TIME] call CBA_fnc_waitAndExecute;
};

if (count GVAR(notifyQueue) isEqualTo 1) then {
    _composition call _fnc_processQueue;
};

nil

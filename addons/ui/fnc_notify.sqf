#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_notify

Description:
    Display a text message. Multiple incoming messages are queued.

Parameters:
    _content   - Notifications content (lines). <ARRAY>
        _line1 - First content line. <ARRAY>
        _line2 - Second content line. <ARRAY>
        ...
        _lineN - N-th content line (may be passed directly if only 1 line is required). <ARRAY>
            _text  - Text to display or path to .paa or .jpg image (may be passed directly if only text is required). <STRING, NUMBER>
            _size  - Text or image size multiplier. (optional, default: 1) <NUMBER>
            _color - RGB or RGBA color (range 0-1). (optional, default: [1, 1, 1, 1]) <ARRAY>
    _skippable - Skip or overwrite this notification if another entered the queue. (optional, default: false) <BOOL>

Examples:
    (begin example)
        "Banana" call CBA_fnc_notify;
        ["Banana", 1.5, [1, 1, 0, 1]] call CBA_fnc_notify;
        [["Banana", 1.5, [1, 1, 0, 1]], ["Not Apple"], true] call CBA_fnc_notify;
    (end)

Returns:
    Nothing

Authors:
    commy2
---------------------------------------------------------------------------- */

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
private _skippable = false;

{
    // Additional arguments at the end
    if (_x isEqualType true) exitWith {
        TRACE_1("Skippable argument",_x);
        _skippable = _x;
    };

    // Line
    _composition pushBack lineBreak;

    _x params [["_text", "", ["", 0]], ["_size", 1, [0]], ["_color", [], [[]], [3,4]]];

    if (_text isEqualType 0) then {
        _text = str _text;
    };

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

private _notification = [_composition, _skippable];

// add the queue
if (isNil QGVAR(notifyQueue)) then {
    GVAR(notifyQueue) = [];
};

GVAR(notifyQueue) pushBack _notification;

private _fnc_popQueue = {
    params ["_controls", "_fnc_processQueue"];

    GVAR(notifyQueue) deleteAt 0;
    private _notification = GVAR(notifyQueue) select 0;

    if (!isNil "_notification") then {
        _notification call _fnc_processQueue;
    } else {
        // fade out
        {
            _x ctrlSetFade 1;
            _x ctrlCommit (FADE_OUT_TIME);
        } forEach _controls;
    };
};

private _fnc_processQueue = {
    params ["_composition", "_skippable"];

    QGVAR(notify) cutRsc ["RscTitleDisplayEmpty", "PLAIN", 0, true];
    private _display = uiNamespace getVariable "RscTitleDisplayEmpty";

    private _vignette = _display displayCtrl 1202;
    _vignette ctrlShow false;

    private _background = _display ctrlCreate ["RscText", -1];
    _background ctrlSetBackgroundColor [0,0,0,0.25];

    private _text = _display ctrlCreate ["RscStructuredText", -1];
    _text ctrlSetStructuredText composeText _composition;

    private _controls = [_background, _text];

    private _left = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(notify),x)', NOTIFY_DEFAULT_X];
    private _top = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(notify),y)', NOTIFY_DEFAULT_Y];
    private _width = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(notify),w)', NOTIFY_MIN_WIDTH];
    private _height = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(notify),h)', NOTIFY_MIN_HEIGHT];

    _width = ctrlTextWidth _text max _width;

    // need to set this before reading the text height, to get the correct amount of auto line breaks
    _text ctrlSetPosition [0, 0, _width, _height];
    _text ctrlCommit 0;

    private _textHeight = ctrlTextHeight _text;
    _height = _textHeight max _height;

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

    _background ctrlSetPosition [_left, _top, _width, _height];

    if (_textHeight < _height) then {
        _top = _top + (_height - _textHeight) / 2;
    };

    _text ctrlSetPosition [_left, _top, _width, _textHeight];

    // fade in
    {
        _x ctrlSetFade 1;
        _x ctrlCommit 0;
        _x ctrlSetFade 0;
        _x ctrlCommit (FADE_IN_TIME);
    } forEach _controls;

    // pop queue
    TRACE_3("Pop wait",_composition,_skippable,GVAR(notifyQueue));
    [{
        // Show next notification immediately if current one is skippable
        _this select 3 && {count GVAR(notifyQueue) > 1}
    }, {
        // Skip current notification
        LOG("Skipped queue process");
        params ["_fnc_popQueue", "_controls", "_fnc_processQueue"];
        [_controls, _fnc_processQueue] call _fnc_popQueue;
    }, [_fnc_popQueue, _controls, _fnc_processQueue, _skippable], GVAR(notifyLifetime), {
        // Normally move to next notification
        LOG("Normal queue process");
        params ["_fnc_popQueue", "_controls", "_fnc_processQueue"];
        [_controls, _fnc_processQueue] call _fnc_popQueue;
    }] call CBA_fnc_waitUntilAndExecute;
};

if (count GVAR(notifyQueue) isEqualTo 1) then {
    _notification call _fnc_processQueue;
};

nil

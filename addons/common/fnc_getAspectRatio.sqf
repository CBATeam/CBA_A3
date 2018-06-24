#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getAspectRatio

Description:
    Used to determine the Aspect ratio of the screen.

Parameters:
    _output - string with one of ["ARRAY","NUMBER","STRING"]

Returns:
    array, string or number of screenratio i.e. [16,9] or "16:9" or 1.333 ..

Examples:
    (begin example)
        _ratio = "STRING" call CBA_fnc_getAspectRatio;
        _ratio = "ARRAY" call CBA_fnc_getAspectRatio;
        _ratio = "NUMBER" call CBA_fnc_getAspectRatio;
    (end)

Author:
  Deadfast @ Skypechat 090909, inspired and made CBA compliant by Vigilante
---------------------------------------------------------------------------- */
SCRIPT(getAspectRatio);


 private ["_output","_aspectStr","_aspectArr","_ratio","_return"];

_output = toUpper _this;

_aspectStr = "";
_aspectArr = [];
_return = 0;

_ratio = (round ((safeZoneW / safeZoneH) * 1000)) / 1000;
switch (_ratio) do {
    case 1: {
            _aspectStr = "4:3";
            _aspectArr = [4,3];
    };
    case 1.333: {
            _aspectStr = "16:9";
            _aspectArr = [16,9];
    };
    case 1.334: {
            _aspectStr = "16:9";
            _aspectArr = [16,9];
    };
    case 1.2: {
            _aspectStr = "16:10";
            _aspectArr = [16,10];
    };
    case 0.937: {
            _aspectStr = "5:4";
            _aspectArr = [5,4];
    };
    case 0.938: {
            _aspectStr = "5:4";
            _aspectArr = [5,4];
    };
    case 1.001: {
            _aspectStr = "12:3";
            _aspectArr = [12,3];
    };
    default {
        hint str _ratio;
    };
};

if (_output == "ARRAY") then {_return = _aspectArr;};
if (_output == "STRING") then {_return = _aspectStr;};
if (_output == "NUMBER") then {_return = _ratio;};

_return;;
#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_addRenamedItem

Description:
    Rename an item

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
    SynixeBrett
---------------------------------------------------------------------------- */

params ["_class", "_name"];

GVAR(renamedItems) setVariable [_class, _name, true];

/* ----------------------------------------------------------------------------
Function: CBA_help_fnc_setCreditsLine

Description:
    Picks a random CfgPatches entry with an "author" entry and displays author,
    version and URL in the main menu and ingame in the pause menu.

Parameters:
    0: _display - Either Main menu or Pause menu display or a control of these displays. <DISPLAY, CONTROL>

Returns:
    None
---------------------------------------------------------------------------- */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

disableSerialization;

// get display
params [["_display", displayNull, [displayNull, controlNull]]];

if (_display isEqualType controlNull) then {
    _display = ctrlParent _display;
};

private _ctrl = _display displayCtrl CBA_CREDITS_CONT_IDC;

if !(ctrlText _ctrl isEqualTo "") exitWith {};

// get settings
{
    if (isNil _x) then {
        missionNamespace setVariable [_x, isClass (configFile >> "CfgPatches" >> _x)];
    };
} forEach ["CBA_DisableCredits", "CBA_MonochromeCredits"];

if (CBA_DisableCredits) exitWith {};

// find addon with author
private _config = configFile >> "CfgPatches";
private _entry = selectRandom ("
    isText (_x >> 'author') &&
    {getText (_x >> 'author') != localize 'STR_A3_Bohemia_Interactive'} &&
    {getText (_x >> 'author') != ''}
" configClasses _config);

if (isNil "_entry") exitWith {};

// addon name
private _name = configName _entry;

if (isText (_entry >> "name")) then {
    _name = getText (_entry >> "name");
};

if (!CBA_MonochromeCredits) then {
    _name = format ["<t color='#99cccc'>%1</t>", _name];
};

// author(s) name
private _author = getText (_entry >> "author");

if (isArray (_entry >> "authors")) then {
    private _authors = getArray (_entry >> "authors");

    {
        if (_x isEqualType "") then {
            _author = format ["%1, %2", _author, _x];
        };
    } forEach _authors;
};

// version if any
private _version = "";

if (isText (_entry >> "version")) then {
    _version = format [" v%1", getText (_entry >> "version")];
};

// add single line
_ctrl ctrlSetStructuredText parseText format ["%1%2 by %3 %4", _name, _version, _author];

#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_help_fnc_setCreditsLine

Description:
    Picks a random CfgPatches entry with an "author" entry and displays author,
    version and URL in the main menu and ingame in the pause menu.

Parameters:
    0: _control - Credits line control <CONTROL>

Returns:
    None
---------------------------------------------------------------------------- */

params ["_control"];

if !(ctrlText _control isEqualTo "") exitWith {};

// get settings
{
    if (isNil _x) then {
        missionNamespace setVariable [_x, isClass (configFile >> "CfgPatches" >> _x)];
    };
} forEach ["CBA_DisableCredits", "CBA_MonochromeCredits"];

if (CBA_DisableCredits) exitWith {};

// find random addon with author
private _entry = selectRandom (uiNamespace getVariable [QGVAR(creditsCache), []]);

if (isNil "_entry") exitWith {};

// addon name
private _name = configName _entry;

if (isText (_entry >> "name")) then {
    _name = getText (_entry >> "name");
};

if (!CBA_MonochromeCredits) then {
    _name = format ["<t color='#99cccc'>%1</t>", _name];
};

// author name
private _author = getText (_entry >> "author");

// version if any
private _version = "";

if (isText (_entry >> "version")) then {
    _version = format [" v%1", getText (_entry >> "version")];
};

// add single line
_control ctrlSetStructuredText parseText format ["%1%2 by %3", _name, _version, _author];

// make credits line not obstruct other controls
_control ctrlEnable false;

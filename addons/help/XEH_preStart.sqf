//#define DEBUG_MODE_FULL
#include "script_component.hpp"

if (!hasInterface) exitWith {};

// credits
private _addons = "true" configClasses (configFile >> "CfgPatches") select {
    isText (_x >> "author") && {!(getText (_x >> "author") in [localize "STR_A3_Bohemia_Interactive", "CFGPATCHES_AUTHOR", ""])}
};

private _credits = [];

{
    private _name = configName _x;

    if (isText (_x >> "name")) then {
        _name = getText (_x >> "name");
    };

    _name = format ["<font color='#99cccc'>%1</font>", _name];

    private _version = "";

    if (isText (_x >> "version")) then {
        _version = format [" v%1", getText (_x >> "version")];
    };

    private _author = getText (_x >> "author");

    _credits pushBack format ["<font color='#bdcc9c'>%1%2 by %3</font>", _name, _version, _author];
} forEach _addons;

_credits = _credits joinString "<br/>";

uiNamespace setVariable [QGVAR(credits), compileFinal str _credits];

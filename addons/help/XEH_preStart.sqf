#include "script_component.hpp"

private _addons = "true" configClasses (configFile >> "CfgPatches") select {
    isText (_x >> "author") && {!(getText (_x >> "author") in [localize "STR_A3_Bohemia_Interactive", "CFGPATCHES_AUTHOR", ""])}
};

private _credits = [];

{
    private _entry = _x;

    private _name = configName _entry;

    if (isText (_entry >> "name")) then {
        _name = getText (_entry >> "name");
    };

    _name = format ["<font color='#99cccc'>%1</font>", _name];

    private _version = "";

    if (isText (_entry >> "version")) then {
        _version = format [" v%1", getText (_entry >> "version")];
    };

    private _author = getText (_entry >> "author");

    _credits pushBack format ["<font color='#bdcc9c'>%1%2 by %3</font>", _name, _version, _author];
} forEach _addons;

_credits = _credits joinString "<br/>";

uiNamespace setVariable [QGVAR(credits), compileFinal str _credits];

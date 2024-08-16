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
        _name = getText (_x >> "name") call CBA_fnc_sanitizeHTML;
    };

    _name = format ["<font color='#99cccc'>%1</font>", _name];

    private _version = "";

    if (isText (_x >> "versionStr")) then {
        _version = format [" v%1", getText (_x >> "versionStr")];
    } else {
        if (isNumber (_x >> "version")) then {
            _version = format [" v%1", getNumber (_x >> "version")];
        } else {
            if (isText (_x >> "version")) then {
                _version = format [" v%1", getText (_x >> "version")];
            };
        };
    };

    private _author = getText (_x >> "author") call CBA_fnc_sanitizeHTML;

    _credits pushBack format ["<font color='#bdcc9c'>%1%2 by %3</font>", _name, _version, _author];
} forEach _addons;

_credits = _credits arrayIntersect _credits;

_credits sort true;

_credits = _credits joinString "<br/>";

uiNamespace setVariable [QGVAR(credits), compileFinal str _credits];

// mods
private _mods = "true" configClasses (configFile >> "CfgPatches") apply {configSourceMod _x};
_mods = ((_mods arrayIntersect _mods) select {!isNumber (configfile >> "CfgMods" >> _x >> "appId")}) - [""];

_mods = _mods apply {
    private _entry = configfile >> "CfgMods" >> _x;

    private _name = getText (_entry >> "name");

    if (isClass _entry) then {
        _x = format ["    <font color='#cc9cbd'>%1 - %2</font>", configName _entry, _name];

        if (isText (_entry >> "description")) then {
            private _description = getText (_entry >> "description");

            _x = _x + format ["<br/>%1<br/>", _description];
        };
    };

    _x call CBA_fnc_sanitizeHTML
};

_mods sort true;

_mods = _mods joinString "<br/>";

uiNamespace setVariable [QGVAR(mods), compileFinal str _mods];

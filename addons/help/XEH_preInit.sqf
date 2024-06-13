//#define DEBUG_MODE_FULL
#include "script_component.hpp"

ADDON = false;

if (!hasInterface) exitWith {
    ADDON = true;
};

// bwc
FUNC(help) = BIS_fnc_help;

// keys
private _keys = "";

private _config = configFile >> "CfgSettings" >> "CBA" >> "events";

{
    private _addon = configName _x;

    _keys = _keys + format ["%1:<br/>", _addon];

    {
        private _action = configName _x;

        private _keybind = if (isNumber _x) then {
            [getNumber _x, false, false, false]
        } else {
            [
                getNumber (_x >> "key"),
                getNumber (_x >> "shift") > 0,
                getNumber (_x >> "ctrl") > 0,
                getNumber (_x >> "alt") > 0
            ]
        };

        private _keyName = _keybind call CBA_fnc_localizeKey;

        _keys = _keys + format ["    %1: <font color='#c48214'>%2</font><br/>", _action, _keyName];
    } forEach configProperties [_x, "isNumber _x || isClass _x"];

    _keys = _keys + "<br/>";
} forEach ("true" configClasses _config);

GVAR(keys) = _keys;

ADDON = true;

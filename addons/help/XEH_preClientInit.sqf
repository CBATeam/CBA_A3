//#define DEBUG_MODE_FULL
#include "script_component.hpp"

LOG(MSG_INIT);

ADDON = false;

[QFUNC(help), {call BIS_fnc_help}] call CBA_fnc_compileFinal;

[QFUNC(process), {
    params ["_hash1", "_hash2", "_hash3"];

    private _result = [];

    {
        private _entry = format [
            "%1, v%2, (%3)<br/>Author: %4",
            _x,
            _hash3 getVariable _x,
            _hash2 getVariable _x,
            (_hash1 getVariable _x) joinString ", "
        ];

        _result pushBack _entry;
    } forEach allVariables _hash1;

    _result joinString "<br/><br/>";
}] call CBA_fnc_compileFinal;

// keys
private _fnc_getKeyName = {
    private _shift = [0, DIK_LSHIFT] select (_shift > 0);
    private _ctrl = [0, DIK_LCONTROL] select (_ctrl > 0);
    private _alt = [0, DIK_LMENU] select (_alt > 0);

    private _keys = [_shift, _ctrl, _alt, _key];

    private _result = "^";

    {
        private _keyName = call compile format ["format ['%1', %2]", "%1", keyName _x];
        _keyName = [_keyName, " "] call CBA_fnc_split;

        private _keyText = "^";

        {
            _keyText = _keyText + " " + _x;
        } forEach _keyName;

        _keyText = [_keyText, "^ ", ""] call CBA_fnc_replace;
        _result = _result + "-" + _keyText;
    } forEach _keys;

    _result = [_result, "^ ", ""] call CBA_fnc_replace;
    _result = [_result, "^-", ""] call CBA_fnc_replace;
    _result = [_result, "^", "None"] call CBA_fnc_replace;
    _result
};

private _text = "";

private _config = configFile >> "CfgSettings" >> "CBA" >> "events";

{
    private _addonConfig = _x;
    private _addonName = configName _addonConfig;

    private _addonNameArr = [_addonName, "_"] call CBA_fnc_split;
    private _addonText = "^";

    {
        if (_x != "sys") then {
            _addonText = format ["%1 %2", _addonText, _x];
        };
    } forEach _addonNameArr;

    _addonText = [_addonText, "^ ", ""] call CBA_fnc_replace;
    _addonText = format ["%1:", _addonText];

    {
        private _entry = _x;
        private _actionName = configName _entry;

        _actionName = [_actionName, "_", " "] call CBA_fnc_replace;

        private ["_key", "_shift", "_ctrl", "_alt"];

        if (isNumber _entry) then {
            _key = getNumber _entry;
            _shift = 0;
            _ctrl = 0;
            _alt = 0;
        } else {
            _key = getNumber (_entry >> "key");
            _shift = getNumber (_entry >> "shift");
            _ctrl = getNumber (_entry >> "ctrl");
            _alt = getNumber (_entry >> "alt");
        };

        private _keyName = [_key, _shift, _ctrl, _alt] call _fnc_getKeyName;

        _actionName = format ["    %1: %2", _actionName, _keyName];

        _text = _text + _actionName + "<br/>";
    } forEach configProperties [_addonConfig, "isNumber _x || isClass _x", true];

    _text = _text + "<br/>";
} forEach ("true" configClasses _config);

GVAR(keys) = _text;

// credits
GVAR(credits) = call CBA_fnc_createNamespace;

private _fnc_readCreditsFromConfig = {
    params ["_type"];

    private _config = configFile >> _type;

    private _hash1 = call CBA_fnc_createNamespace;
    private _hash2 = call CBA_fnc_createNamespace;
    private _hash3 = call CBA_fnc_createNamespace;

    {
        private _entry = _x;

        _hash1 setVariable [configName _entry, getArray (_entry >> "author")];
        _hash2 setVariable [configName _entry, getText (_entry >> "authorUrl")];
        _hash3 setVariable [configName _entry, getText (_entry >> "version")];
    } forEach ("isArray (_x >> 'author')" configClasses _config);

    [_hash1, _hash2, _hash3]
};

{
    GVAR(credits) setVariable [_x, _x call _fnc_readCreditsFromConfig];
} forEach ["CfgPatches"]; //, "CfgVehicles", "CfgWeapons"];

// docs
GVAR(docs) = "";

private _config = configFile >> "CfgMods";

{
    private _entry = format ["* %1 - %2<br />%3<br /><br />", configName _x, getText (_x >> "name"), getText (_x >> "description")];

    GVAR(docs) + _entry;
} forEach ("isText (_x >> 'description')" configClasses _config);

ADDON = true;

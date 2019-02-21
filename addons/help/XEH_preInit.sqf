//#define DEBUG_MODE_FULL
#include "script_component.hpp"

if (!hasInterface) exitWith {};

ADDON = false;

// bwc
QFUNC(help) = BIS_fnc_help;

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

        private _keyState = if (isNumber _entry) then {
            [getNumber _entry, 0, 0, 0 ]
        } else {
            [
                getNumber (_entry >> "key"),
                getNumber (_entry >> "shift"),
                getNumber (_entry >> "ctrl"),
                getNumber (_entry >> "alt")
            ]
        };

        private _keyName = _keyState call _fnc_getKeyName;

        _actionName = format ["    %1: %2", _actionName, _keyName];

        _text = _text + _actionName + "<br/>";
    } forEach configProperties [_addonConfig, "isNumber _x || isClass _x", true];

    _text = _text + "<br/>";
} forEach ("true" configClasses _config);

GVAR(keys) = _text;

ADDON = true;

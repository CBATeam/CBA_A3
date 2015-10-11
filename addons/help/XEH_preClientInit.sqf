// Any registered functions used in the PreINIT phase must use the uiNamespace copies of the variable.
// So uiNamespace getVariable "CBA_fnc_hashCreate" instead of just CBA_fnc_hashCreate -VM

//#define DEBUG_MODE_FULL
#include "script_component.hpp"

LOG(MSG_INIT);

ADDON = false;

PREP(help);
PREP(describe);

FUNC(readConfig) = {
    params ["_type"];
    _config = configFile >> _type;
    _hash = [[], []] call (uiNamespace getVariable "CBA_fnc_hashCreate");
    _hash2 = [[], ""] call (uiNamespace getVariable "CBA_fnc_hashCreate");
    _hash3 = [[], ""] call (uiNamespace getVariable "CBA_fnc_hashCreate");
    for "_i" from 0 to (count _config) - 1 do {
        _entry = _config select _i;
        if (isClass _entry) then {
            if (isArray (_entry >> "author")) then { [_hash, configName _entry, getArray(_entry >> "author")] call (uiNamespace getVariable "CBA_fnc_hashSet") };
            if (isText (_entry >> "authorUrl")) then { [_hash2, configName _entry, getText(_entry >> "authorUrl")] call (uiNamespace getVariable "CBA_fnc_hashSet") };
            if (isText (_entry >> "version")) then { [_hash3, configName _entry, getText(_entry >> "version")] call (uiNamespace getVariable "CBA_fnc_hashSet") };
        };
    };
    [_hash, _hash2, _hash3];
};

FUNC(process) = {
    params ["_h1","_h2","_h3"];
    _ar = [];
    [_h1, {_entry = format["%1, v%2, (%3)<br/>Author: %4", _key, [_h3, _key] call (uiNamespace getVariable "CBA_fnc_hashGet"), [_h2, _key] call (uiNamespace getVariable "CBA_fnc_hashGet"), _value joinString ", "]; PUSH(_ar,_entry) }] call (uiNamespace getVariable "CBA_fnc_hashEachPair");
    _ar joinString "<br/><br/>";
};

private ["_pkeynam", "_shift", "_ctrl", "_alt", "_keys", "_key", "_keystrg", "_mod", "_knaml", "_knam", "_k", "_text", "_cEvents", "_i", "_cSys", "_tSys", "_aSys", "_tS", "_j", "_c", "_tC", "_keyn", "_credits"];
_pkeynam = { //local function
    _shift = if(_shift > 0) then {42} else {0};
    _ctrl = if(_ctrl > 0) then {56} else {0};
    _alt = if(_alt > 0) then {29} else {0};
    _keys = [_shift,_ctrl,_alt,_key];
    _keystrg = "^";
    {
        _mod = _x in [42,56,29]; // ???
        _knaml = call compile format["format['%2',%1]",(keyName _x),"%1"];
        _knaml = _knaml splitString " ";
        _knam = "^";
        {_k = _x; _knam = _knam + " " + _k} forEach _knaml;
        // if(!(_mod) || ( (_k != (localize "STR_ACE_KN_LEFT")) && (_k != (localize "STR_ACE_KN_RIGHT")) )) then {  // ?????
        _knam = [_knam, "^ ", ""] call (uiNamespace getVariable "CBA_fnc_replace");
        _keystrg = _keystrg + "-" + _knam;
    } forEach _keys;
    _keystrg = [_keystrg, "^ ", ""] call (uiNamespace getVariable "CBA_fnc_replace");
    _keystrg = [_keystrg, "^-", ""] call (uiNamespace getVariable "CBA_fnc_replace");
    _keystrg = [_keystrg, "^", "None"] call (uiNamespace getVariable "CBA_fnc_replace");
    _keystrg
};

_text="";
_cEvents = configFile/"CfgSettings"/"CBA"/"events";
for "_i" from 0 to (count _cEvents)-1 do {
    _cSys = _cEvents select _i;
    _tSys = configName _cSys;
    if (isNumber((_cSys select 0)/"key")) then {
        //format system name
        _aSys = _tSys splitString "_";
        _tS = "^";
        {if((_x != "sys")) then {_tS = _tS + " " + _x;}} forEach _aSys;
        // (_x != "ace") &&
        _tS = [_tS, "^ ", ""] call (uiNamespace getVariable "CBA_fnc_replace");
        _tS = format["%1:",_tS];
        _text = _text + _tS + "<br/>";
        for "_j" from 0 to (count _cSys)-1 do {
            _c = _cSys select _j;
            _tC = configName _c;
            _tC = [_tC, "_", " "] call (uiNamespace getVariable "CBA_fnc_replace");
            //key
            _key = getNumber (_c/"key");
            _shift = getNumber (_c/"shift");
            _ctrl = getNumber (_c/"ctrl");
            _alt = getNumber (_c/"alt");
            _keyn = [_key,_shift,_ctrl,_alt] call _pkeynam;
            _tC = format["    %1: %2",_tC,_keyn];
            _text = _text + _tC + "<br/>";
        };
        _text = _text + "<br/>";
    };
};


GVAR(credits) = [[], []] call (uiNamespace getVariable "CBA_fnc_hashCreate");
{ [GVAR(credits), _x, [_x] call FUNC(readConfig)] call (uiNamespace getVariable "CBA_fnc_hashSet") } forEach ["CfgPatches"]; //, "CfgVehicles", "CfgWeapons"];

GVAR(docs) = "";
_cfg = configFile >> "CfgMods";
_c = count _cfg;
if (_c > 0) then {
    for "_i" from 0 to (_c - 1) do {
        _mod = _cfg select _i;
        if (isClass _mod && {isText(_mod >> "description")}) then {
            _e = format["* %1 - %2<br />%3<br /><br />", configName _mod, getText(_mod >> "name"), getText(_mod >> "description")];
            ADD(GVAR(docs),_e);
        };
    };
};

GVAR(keys) = _text;

ADDON = true;

//#define DEBUG_MODE_FULL
#include "script_component.hpp"

GVAR(CREDITS_Info) = [GVAR(credits), "CfgPatches"] call (uiNamespace getVariable "CBA_fnc_hashGet");
GVAR(CREDITS_CfgPatches) = (GVAR(CREDITS_Info)) call FUNC(process);
TRACE_2("",GVAR(CREDITS_Info), GVAR(CREDITS_CfgPatches));

#ifdef DEBUG_MODE_FULL
    // Troubleshooting an A3 Funcitons Compliation for missionNamespace.
    if (isNil "CBA_fnc_hashGet") then { diag_log "CBA_fnc_hashGet is nil!!";};
    if (isNil QGVAR(CREDITS_CfgPatches)) then { diag_log "CREDITS_CfgPatches is nil! CBA_fnc_hashGet must have failed"; TRACE_1("",CBA_fnc_hashGet)};
#endif

private ["_pkeynam", "_shift", "_ctrl", "_alt", "_keys", "_key", "_keystrg",
 "_mod", "_knaml", "_knam", "_i", "_j", "_k", "_text",  "_names", "_handlers",
 "_name", "_handler", "_actionNames", "_actionEntries", "_actionName",
 "_displayName", "_keyn"];
 
_pkeynam = {
    _shift = if(_shift) then {42} else {0};
    _ctrl = if(_ctrl) then {56} else {0};
    _alt = if(_alt) then {29} else {0};
    _keys = [_shift,_ctrl,_alt,_dikKey];
    _keystrg = "^";
    {
        _knaml = [cba_keybinding_dikDecToStringTable, format ["%1", _x]] call BIS_fnc_getFromPairs;
        _knaml = [_knaml, " "] call (uiNamespace getVariable "CBA_fnc_split");
        _knam = "^";
        {_k = _x; _knam = _knam + " " + _k} forEach _knaml;
        _knam = [_knam, "^ ", ""] call (uiNamespace getVariable "CBA_fnc_replace");
        _keystrg = _keystrg + "-" + _knam;
    } forEach _keys;
    _keystrg = [_keystrg, "^ ", ""] call (uiNamespace getVariable "CBA_fnc_replace");
    _keystrg = [_keystrg, "^-", ""] call (uiNamespace getVariable "CBA_fnc_replace");
    _keystrg = [_keystrg, "^", "None"] call (uiNamespace getVariable "CBA_fnc_replace");
    _keystrg
};

_h = _pkeynam spawn {
    _text = "";
    _names = cba_keybinding_handlers select 0;
    _handlers = cba_keybinding_handlers select 1;
    for "_i" from 0 to (count _names) do {
        _name = _names select _i;
        _handler = _handlers select _i;
        if (!isNil "_name") then {
            _text = _text + format ["%1:<br/>", _name];
            _actionNames = _handler select 0;
            _actionEntries = _handler select 1;
            
            for "_j" from 0 to (count _actionNames - 1) do {
                _actionName = _actionNames select _j;
                _actionEntry = _actionEntries select _j;
        
                _displayName = _actionEntry select 0;
                if (typeName _displayName == typeName []) then {
                    _displayName = (_actionEntry select 0) select 0;
                };
                _keyBind = _actionEntry select 1;
                _dikKey = _keyBind select 0;
                _mod = _keyBind select 1;
                _shift = _mod select 0;
                _ctrl = _mod select 1;
                _alt = _mod select 2;
                _keyn = call _this;
    
                _text = _text + format ["    %1: <font color='#c48214'>%2</font><br/>", _displayName, _keyn];
            };
            _text = _text + "<br/>";
        };
    };
    player createDiaryRecord ["CBA_docs", [(localize "STR_DN_CBA_HELP_KEYS"), _text]];
};

player createDiarySubject ["CBA_docs", "CBA"];
//player createDiaryRecord ["CBA_docs", [(localize "STR_DN_CBA_WEBSITE_WIKI"), "http://dev-heaven.net/projects/cca"]];
if (!isNil QGVAR(CREDITS_CfgPatches)) then { player createDiaryRecord ["CBA_docs", [(localize "STR_DN_CBA_CREDITS_ADDONS"), GVAR(CREDITS_CfgPatches)]];};
if (!isNil QGVAR(docs)) then { player createDiaryRecord ["CBA_docs", ["Docs", GVAR(docs)]];};
if (!isNil QGVAR(keys)) then { player createDiaryRecord ["CBA_docs", [(localize "STR_DN_CBA_HELP_KEYS"), GVAR(keys)]];};
//player createDiaryRecord ["CBA_docs", [(localize "STR_DN_CBA_CREDITS"), GVAR(credits_cba)]];
//player createDiaryRecord ["CBA_docs", ["Credits - Vehicles", ([GVAR(credits), "CfgVehicles"] call (uiNamespace getVariable "CBA_fnc_hashGet")) call FUNC(process)]];
//player createDiaryRecord ["CBA_docs", ["Credits - Weapons", ([GVAR(credits), "CfgWeapons"] call (uiNamespace getVariable "CBA_fnc_hashGet")) call FUNC(process)]];

//player createDiaryRecord ["CBA_docs", [(localize "STR_DN_CBA_WEBSITE"), "http://dev-heaven.net/projects/cca"]];


// [cba_help_credits, "CfgPatches"] call (uiNamespace getVariable "CBA_fnc_hashGet")
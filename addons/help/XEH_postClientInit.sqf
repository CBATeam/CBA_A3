//#define DEBUG_MODE_FULL
#include "script_component.hpp"

if (!hasInterface) exitWith {};

// create diary
player createDiarySubject ["CBA_docs", "CBA"];

//player createDiaryRecord ["CBA_docs", [localize "STR_DN_CBA_WEBSITE_WIKI", "http://dev-heaven.net/projects/cca"]];

private _creditsInfo = GVAR(credits) getVariable "CfgPatches";
private _credits_CfgPatches = _creditsInfo call FUNC(process);

if (!isNil "_credits_CfgPatches") then {
    player createDiaryRecord ["CBA_docs", [localize "STR_DN_CBA_CREDITS_ADDONS", _credits_CfgPatches]];
};

if (!isNil QGVAR(docs)) then {
    player createDiaryRecord ["CBA_docs", ["Docs", GVAR(docs)]];
};

if (!isNil QGVAR(keys)) then {
    player createDiaryRecord ["CBA_docs", [localize "STR_DN_CBA_HELP_KEYS", GVAR(keys)]];
};

//player createDiaryRecord ["CBA_docs", [localize "STR_DN_CBA_CREDITS", GVAR(credits_cba)]];
//player createDiaryRecord ["CBA_docs", ["Credits - Vehicles", (_creditsInfo getVariable "CfgVehicles") call FUNC(process)]];
//player createDiaryRecord ["CBA_docs", ["Credits - Weapons", (_creditsInfo getVariable "CfgWeapons") call FUNC(process)]];
//player createDiaryRecord ["CBA_docs", [localize "STR_DN_CBA_WEBSITE", "http://dev-heaven.net/projects/cca"]];

// add diary for scripted keybinds
private _fnc_getKeyName = {
    private _shift = [0, DIK_LSHIFT] select _shift;
    private _ctrl = [0, DIK_LCONTROL] select _ctrl;
    private _alt = [0, DIK_LMENU] select _alt;

    private _keys = [_shift, _ctrl, _alt, _key];

    _result = "^";

    {
        private _keyname1 = EGVAR(keybinding,keyNames) select _x;
        if (isNil "_keyname1") then {
            _keyname1 = format [localize ELSTRING(keybinding,unkownKey), _x];
        };

        _keyname1 = [_keyname1, " "] call CBA_fnc_split;

        private _keyname2 = "^";

        {
            _keyname2 = _keyname2 + " " + _x;
        } forEach _keyname1;

        _keyname2 = [_keyname2, "^ ", ""] call CBA_fnc_replace;
        _result = _result + "+" + _keyname2;
    } forEach _keys;

    _result = [_result, "^ ", ""] call CBA_fnc_replace;
    _result = [_result, "^+", ""] call CBA_fnc_replace;
    _result = [_result, "^", "None"] call CBA_fnc_replace;
    _result = [_result, "LAlt", "Alt"] call CBA_fnc_replace;
    _result = [_result, "LCtrl", "Ctrl"] call CBA_fnc_replace;
    _result = [_result, "LShift", "Shift"] call CBA_fnc_replace;
    _result
};

_fnc_getKeyName spawn {
    private _text = GVAR(keys);

    cba_keybinding_handlers params [["_modNames", [], [[]]], ["_keyHandlers", [], [[]]]];

    {
        private _modName = _x;
        private _keyHandler = _keyHandlers param [_forEachIndex, []];
        if (!isNil "_modName" && _modName in cba_keybinding_activeMods) then {
            _text = _text + format ["%1:<br/>", _modName];

            _keyHandler params [["_actionNames", [], [[]]], ["_actionEntries", [], [[]]]];

            {
                private _actionName = _x;
                private _actionEntry = _actionEntries param [_forEachIndex, []];

                _actionEntry params [["_displayName", "", ["", []]], ["_keyBind", [], [[]]]];

                if (_displayName isEqualType []) then {
                    _displayName = _displayName param [0, ""];
                };

                // Escape < and >
                _displayName = [_displayName, "<", "&lt;"] call CBA_fnc_replace;
                _displayName = [_displayName, ">", "&gt;"] call CBA_fnc_replace;

                _keyBind params [["_key", 0, [0]], ["_mod", [], [[]]]];
                _mod params [["_shift", false, [false]], ["_ctrl", false, [false]], ["_alt", false, [false]]];

                _text = _text + format ["    %1: <font color='#c48214'>%2</font><br/>", _displayName, call _this];
            } forEach _actionNames;

            _text = _text + "<br/>";
        };
    } forEach _modNames;

    player createDiaryRecord ["CBA_docs", [localize "STR_DN_CBA_HELP_KEYS", _text]];
};

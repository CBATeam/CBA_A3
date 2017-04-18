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
0 spawn {
    private _text = GVAR(keys);

    EGVAR(keybinding,handlers) params [["_modNames", [], [[]]], ["_keyHandlers", [], [[]]]];

    {
        private _modName = _x;
        private _keyHandler = _keyHandlers param [_forEachIndex, []];
        if (!isNil "_modName" && _modName in cba_keybinding_activeMods) then {
            _text = _text + format ["%1:<br/>", _modName];

            _keyHandler params [["_actionNames", [], [[]]], ["_actionEntries", [], [[]]]];

            {
                private _actionName = _x;
                private _actionEntry = _actionEntries param [_forEachIndex, []];

                _actionEntry params [["_displayName", "", ["", []]], ["_keybind", [], [[]]]];

                if (_displayName isEqualType []) then {
                    _displayName = _displayName param [0, ""];
                };

                // Escape < and >
                _displayName = [_displayName, "<", "&lt;"] call CBA_fnc_replace;
                _displayName = [_displayName, ">", "&gt;"] call CBA_fnc_replace;

                _keybind params [["_key", 0, [0]], ["_modifier", [], [[]]]];
                _modifier params [["_shift", false, [false]], ["_ctrl", false, [false]], ["_alt", false, [false]]];

                // Try to convert dik code to a human key code.
                private _keyName = EGVAR(keybinding,keyNames) getVariable str _key;

                if (isNil "_keyName") then {
                    _keyName = ["", format [localize ELSTRING(keybinding,unkownKey), _key]] select (_key > 0);
                };

                // Build the full key combination name.
                if (_shift && {!(_key in [DIK_LSHIFT, DIK_RSHIFT])}) then {
                    _keyName = localize "str_dik_shift" + "+" + _keyName;
                };

                if (_alt && {!(_key in [DIK_LMENU, DIK_RMENU])}) then {
                    _keyName = localize "str_dik_alt" + "+" + _keyName;
                };

                if (_ctrl && {!(_key in [DIK_LCONTROL, DIK_RCONTROL])}) then {
                    _keyName = localize "str_dik_control" + "+" + _keyName;
                };

                _text = _text + format ["    %1: <font color='#c48214'>%2</font><br/>", _displayName, _keyName];
            } forEach _actionNames;

            _text = _text + "<br/>";
        };
    } forEach _modNames;

    player createDiaryRecord ["CBA_docs", [localize "STR_DN_CBA_HELP_KEYS", _text]];
};

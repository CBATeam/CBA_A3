//#define DEBUG_MODE_FULL
#include "script_component.hpp"

if (!hasInterface) exitWith {};

// create diary, entries added in reverse order
player createDiarySubject ["CBA_docs", "CBA"];

// add diary for scripted keybinds
{
    private _fnc_process = {
        private _result = [];

        {
            private _entry = _x;

            // addon name
            private _name = configName _entry;

            if (isText (_entry >> "name")) then {
                _name = getText (_entry >> "name");
            };

            _name = format ["<font color='#99cccc'>%1</font>", _name];

            // version if any
            private _version = "";

            if (isText (_entry >> "version")) then {
                _version = format [" v%1", getText (_entry >> "version")];
            };

            // author name
            private _author = getText (_entry >> "author");

            _result pushBack format ["<font color='#bdcc9c'>%1%2 by %3</font>", _name, _version, _author];
        } forEach (uiNamespace getVariable [QGVAR(creditsCache), []]);

        _result joinString "<br/>";
    };

    private _text = GVAR(keys);

    private _activeMods = allVariables EGVAR(keybinding,addons);
    _activeMods sort true;

    {
        (EGVAR(keybinding,addons) getVariable _x) params ["_addonName", "_addonActions"];

        _text = _text + format ["%1:<br/>", _addonName];

        {
            (EGVAR(keybinding,actions) getVariable (_addonName + "$" + _x)) params ["_displayName", "", "_registryKeybinds"];
            if (isLocalized _displayName) then { _displayName = localize _displayName; };

            private _keyName = (_registryKeybinds select {_x select 0 > DIK_ESCAPE} apply {_x call CBA_fnc_localizeKey}) joinString "    ";

            _text = _text + format ["    %1: <font color='#c48214'>%2</font><br/>", _displayName, _keyName];
        } forEach _addonActions;

        _text = _text + "<br/>";
    } forEach _activeMods;

    // delete last line break
    _text = _text select [0, count _text - 5];

    player createDiaryRecord ["CBA_docs", [localize "STR_CBA_Help_Keys", _text]];

    if (!isNil QGVAR(docs)) then {
        //player createDiaryRecord ["CBA_docs", ["Docs", GVAR(docs)]];
    };

    // "<url='https://www.arma3.com'>ARMA 3</url>"
    player createDiaryRecord ["CBA_docs", [localize "STR_CBA_Credits", call _fnc_process]];

    player createDiaryRecord ["CBA_docs", [localize "STR_CBA_Bugtracker", localize "STR_CBA_URL_Bugtracker"]];
    player createDiaryRecord ["CBA_docs", [localize "STR_CBA_Wiki", localize "STR_CBA_URL_Wiki"]];
} call CBA_fnc_execNextFrame;

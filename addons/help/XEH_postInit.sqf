//#define DEBUG_MODE_FULL
#include "script_component.hpp"

if (!hasInterface) exitWith {};

// create diary, entries added in reverse order
player createDiarySubject ["CBA_docs", "CBA"];

// add diary for scripted keybinds
{
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
    player createDiaryRecord ["CBA_docs", ["Docs", call (uiNamespace getVariable QGVAR(docs))]];
    player createDiaryRecord ["CBA_docs", [localize "STR_CBA_Credits", call (uiNamespace getVariable QGVAR(credits))]];
    player createDiaryRecord ["CBA_docs", [localize "STR_CBA_Bugtracker", localize "STR_CBA_URL_Bugtracker"]]; //"<url='https://www.arma3.com'>ARMA 3</url>"
    player createDiaryRecord ["CBA_docs", [localize "STR_CBA_Wiki", localize "STR_CBA_URL_Wiki"]];
} call CBA_fnc_execNextFrame;

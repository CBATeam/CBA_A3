//#define DEBUG_MODE_FULL
#include "script_component.hpp"

if (!hasInterface) exitWith {};

{
    // create diary, entries added in reverse order
    private _unit = player;
    _unit createDiarySubject [QGVAR(docs), "CBA"];

    // add diary for scripted keybinds
    private _keys = GVAR(keys);

    private _addons = allVariables EGVAR(keybinding,addons);
    _addons sort true;

    {
        (EGVAR(keybinding,addons) getVariable _x) params ["_addon", "_addonActions"];

        _keys = _keys + format ["%1:<br/>", _addon];

        {
            (EGVAR(keybinding,actions) getVariable (_addon + "$" + _x)) params ["_displayName", "", "_keybinds"];

            if (isLocalized _displayName) then {
                _displayName = localize _displayName;
            };

            private _keyName = (_keybinds select {_x select 0 > DIK_ESCAPE} apply {_x call CBA_fnc_localizeKey}) joinString "    ";

            _keys = _keys + format ["    %1: <font color='#c48214'>%2</font><br/>", _displayName, _keyName];
        } forEach _addonActions;

        _keys = _keys + "<br/>";
    } forEach _addons;

    // delete last line breaks
    _keys = _keys select [0, count _keys - 10];

    _unit createDiaryRecord [QGVAR(docs), [localize "STR_CBA_Help_Keys", _keys]];
    _unit createDiaryRecord [QGVAR(docs), [localize "STR_CBA_Credits", call (uiNamespace getVariable QGVAR(credits))]];
    _unit createDiaryRecord [QGVAR(docs), [localize "STR_CBA_Addons", call (uiNamespace getVariable QGVAR(mods))]];
    _unit createDiaryRecord [QGVAR(docs), [localize "STR_CBA_Bugtracker", localize "STR_CBA_URL_Bugtracker"]]; //"<url='https://www.arma3.com'>ARMA 3</url>"
    _unit createDiaryRecord [QGVAR(docs), [localize "STR_CBA_Wiki", localize "STR_CBA_URL_Wiki"]];
} call CBA_fnc_execNextFrame;

//#define DEBUG_MODE_FULL
#include "script_component.hpp"

if (!hasInterface) exitWith {};

{
    // create diary, entries added in reverse order
    private _unit = player;
    _unit createDiarySubject [QGVAR(docs), "CBA"];

    // add diary for config & scripted keybinds
    private _keys = [];

    private _config = configFile >> "CfgSettings" >> "CBA" >> "events";

    {
        private _addon = configName _x;

        private _addonKeys = [format ["%1:", _addon]];

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

            _addonKeys pushBack format ["    %1: <font color='#c48214'>%2</font>", _action, _keyName];
        } forEach configProperties [_x, "isNumber _x || isClass _x"];

        _addonKeys pushBack "<br/>";
        _keys pushBack (_addonKeys joinString "<br/>");
    } forEach ("true" configClasses _config);

    private _addons = allVariables EGVAR(keybinding,addons);

    {
        (EGVAR(keybinding,addons) getVariable _x) params ["_addon", "_addonActions"];

        private _name = _addon;
        if (isLocalized _name) then {
            _name = localize _name;
        };

        private _addonKeys = [format ["%1:", _name]];

        {
            (EGVAR(keybinding,actions) getVariable (_addon + "$" + _x)) params ["_displayName", "", "_keybinds"];

            if (isLocalized _displayName) then {
                _displayName = localize _displayName;
            };

            private _keyName = (_keybinds select {_x select 0 > DIK_ESCAPE} apply {_x call CBA_fnc_localizeKey}) joinString "    ";

            _addonKeys pushBack format ["    %1: <font color='#c48214'>%2</font>", _displayName, _keyName];
        } forEach _addonActions;

        _addonKeys pushBack "<br/>";
        _keys pushBack (_addonKeys joinString "<br/>");
    } forEach _addons;

    // Get localized categories first, then sort
    _keys sort true;

    _keys = _keys joinString "";

    // delete last line breaks
    _keys = _keys select [0, count _keys - 10];

    GVAR(DiaryRecordKeys) = _unit createDiaryRecord [QGVAR(docs), [localize "STR_CBA_Help_Keys", format ["<font size=20>%1</font><br/>%2", localize "STR_CBA_Help_Keys", _keys]], taskNull, "", false];
    GVAR(DiaryRecordCredits) = _unit createDiaryRecord [QGVAR(docs), [localize "STR_CBA_Credits", format ["<font size=20>%1</font><br/>%2", localize "STR_CBA_Credits", call (uiNamespace getVariable QGVAR(credits))]], taskNull, "", false];
    GVAR(DiaryRecordAddons) = _unit createDiaryRecord [QGVAR(docs), [localize "STR_CBA_Addons", format ["<font size=20>%1</font><br/>%2", localize "STR_CBA_Addons", call (uiNamespace getVariable QGVAR(mods))]], taskNull, "", false];
} call CBA_fnc_execNextFrame;

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

    private _activeMods = allVariables EGVAR(keybinding,addons);
    _activeMods sort true;

    {
        (EGVAR(keybinding,addons) getVariable _x) params ["_addonName", "_addonActions"];

        _text = _text + format ["%1:<br/>", _addonName];

        {
            (EGVAR(keybinding,actions) getVariable (_addonName + "$" + _x)) params ["_displayName", "", "_registryKeybinds"];

            private _keyName = (_registryKeybinds select {_x select 0 > DIK_ESCAPE} apply {_x call CBA_fnc_localizeKey}) joinString "    ";

            _text = _text + format ["    %1: <font color='#c48214'>%2</font><br/>", _displayName, _keyName];
        } forEach _addonActions;

        _text = _text + "<br/>";
    } forEach _activeMods;

    player createDiaryRecord ["CBA_docs", [localize "STR_DN_CBA_HELP_KEYS", _text]];
};

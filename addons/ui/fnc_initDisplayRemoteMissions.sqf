#include "script_component.hpp"
#include "\a3\ui_f\hpp\defineResinclDesign.inc" // can't have this in config, because it redefines some entries, and that makes Mikero's shits its pants

// Function shouldn't be preped, but exit just to be safe because Headless Clients will trigger RscDisplayRemoteMissions and have problems with this
if (!hasInterface) exitWith {};

params ["_display"];
private _ctrlMaps = _display displayCtrl IDC_SERVER_ISLAND;
private _ctrlMissions = _display displayCtrl IDC_SERVER_MISSION;

// find all stock missions
private _stockMissions = [];

private _fnc_findMissions = {
    {
        if (isText (_x >> "directory")) then {
            _stockMissions pushBack configName _x;
        };

        _x call _fnc_findMissions;
    } forEach configProperties [_this, "isClass _x"];
};

(configFile >> "CfgMissions" >> "MPMissions") call _fnc_findMissions;

_display setVariable [QGVAR(stockMissions), _stockMissions];

// Show worldnames as tooltips on map list
private _mapNames = createHashMap;
{
    private _worldName = configName _x;
    private _description = getText (configFile >> "CfgWorlds" >> _worldName >> "description");
    _mapNames set [_description, _worldname];
} forEach (configProperties [configfile >> "CfgWorldList", "isClass _x"]);
for "_index" from 0 to ((lbSize _ctrlMaps) - 1) do {
    private _description = _ctrlMaps lbText _index;
    private _worldName = _mapNames getOrDefault [_description, ""];
    _ctrlMaps lbSetTooltip [_index, _worldName];
};

lbSort _ctrlMaps;
_ctrlMaps lbSetCurSel 0;

ctrlPosition _ctrlMissions params ["_left", "_top", "_width", "_height"];

private _widthSearchBar = (_width - 11 * GUI_GRID_W) min (10 * GUI_GRID_W);

private _ctrlSearch = _display ctrlCreate ["RscEdit", IDC_SEARCH];
_ctrlSearch ctrlSetPosition [
    _left + 0.1 * GUI_GRID_W,
    _top,
    _widthSearchBar,
    GUI_GRID_H
];
_ctrlSearch ctrlCommit 0;

private _filter = profileNamespace getVariable [QGVAR(Filter), ""];
_ctrlSearch ctrlSetText _filter;

private _ctrlSearchButton = _display ctrlCreate ["RscButtonSearch", IDC_SEARCH_BUTTON];
_ctrlSearchButton ctrlSetPosition [
    _left + 0.1 * GUI_GRID_W + _widthSearchBar,
    _top,
    GUI_GRID_W,
    GUI_GRID_H
];
_ctrlSearchButton ctrlCommit 0;

private _ctrlShowStockMissions = _display ctrlCreate ["RscButton", -1];
_ctrlShowStockMissions ctrlSetPosition [
    _left + _width - 10 * GUI_GRID_W,
    _top,
    10 * GUI_GRID_W,
    GUI_GRID_H
];
_ctrlShowStockMissions ctrlCommit 0;
_ctrlShowStockMissions ctrlSetFont "PuristaLight";

_ctrlShowStockMissions ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlShowStockMissions"];

    private _showStockMissions = !(profileNamespace getVariable [QGVAR(ShowStockMissions), true]);
    profileNamespace setVariable [QGVAR(ShowStockMissions), _showStockMissions];
    saveProfileNamespace;

    _ctrlShowStockMissions ctrlSetText toUpper localize (["STR_CBA_Ui_CustomMissions", "STR_CBA_Ui_AllMissions"] select _showStockMissions);
}];

private _showStockMissions = profileNamespace getVariable [QGVAR(ShowStockMissions), true];
_ctrlShowStockMissions ctrlSetText toUpper localize (["STR_CBA_Ui_CustomMissions", "STR_CBA_Ui_AllMissions"] select _showStockMissions);

_ctrlMissions ctrlSetPosition [
    _left,
    _top + 1.1 * GUI_GRID_H,
    _width,
    _height - 1.1 * GUI_GRID_H
];
_ctrlMissions ctrlCommit 0;

// store all missions of the currently selected map
private _fnc_storeMapMissions = {_this spawn {isNil { // delay a frame
    params ["_ctrlMaps"];
    private _display = ctrlParent _ctrlMaps;
    private _ctrlMissions = _display displayCtrl IDC_SERVER_MISSION;

    private _missions = [];
    for "_i" from 0 to (lbSize _ctrlMissions - 1) do {
        private _name = _ctrlMissions lbText _i;
        with uiNamespace do {
            _name = _name call CBA_fnc_decodeURL;
        };

        private _value = _ctrlMissions lbValue _i;
        private _data = _ctrlMissions lbData _i;
        private _color = _ctrlMissions lbColor _i;

        _missions pushBack [_name, _value, _data, _color];
    };

    _ctrlMissions setVariable [QGVAR(missions), _missions];
    _display call (_display getVariable QFUNC(filter));
}}};

_ctrlMaps call _fnc_storeMapMissions;
_ctrlMaps ctrlAddEventHandler ["lbSelChanged", _fnc_storeMapMissions];

// filter out missions we don't want
_display setVariable [QFUNC(filter), {
    params ["_display"];
    private _ctrlSearch = _display displayCtrl IDC_SEARCH;
    private _ctrlMissions = _display displayCtrl IDC_SERVER_MISSION;

    private _filter = ctrlText _ctrlSearch;

    if (_filter != profileNamespace getVariable [QGVAR(Filter), ""]) then {
        profileNamespace setVariable [QGVAR(Filter), _filter];
        saveProfileNamespace;
    };

    _filter = toLower _filter;

    private _missions = _ctrlMissions getVariable QGVAR(missions);
    private _stockMissions = _display getVariable QGVAR(stockMissions);
    private _showStockMissions = profileNamespace getVariable [QGVAR(ShowStockMissions), true];

    lbClear _ctrlMissions;

    {
        _x params ["_name", "_value", "_data", "_color"];
        private _classname = _data splitString "." param [0, ""];

        if (toLower _name find _filter != -1 && {_showStockMissions || {!(_classname in _stockMissions)}}) then {
            private _index = _ctrlMissions lbAdd _name;
            _ctrlMissions lbSetValue [_index, _value];
            _ctrlMissions lbSetData [_index, _data];
            _ctrlMissions lbSetColor [_index, _color];
        };
    } forEach _missions;

    _ctrlMissions lbSetCurSel 0;
}];

// update every time search parameters are changed
private _fnc_update = {_this spawn {isNil { // delay a frame
    params ["_ctrlSearch"];
    private _display = ctrlParent _ctrlSearch;
    _display call (_display getVariable QFUNC(filter));
}}};

_ctrlSearch ctrlAddEventHandler ["KeyDown", _fnc_update];
_ctrlSearch ctrlAddEventHandler ["KeyUp", _fnc_update];
_ctrlSearchButton ctrlAddEventHandler ["ButtonClick", _fnc_update];
_ctrlShowStockMissions ctrlAddEventHandler ["ButtonClick", _fnc_update];

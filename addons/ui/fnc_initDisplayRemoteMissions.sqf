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

private _worldNames = createHashMap;
private _worldFeatures = createHashMap;
private _defaultPicture = getText (configFile >> "display3DENNew" >> "defaultPicture");
private _defaultAuthor = localize "STR_AUTHOR_UNKNOWN";
private _authorFullLocalized = localize "STR_FORMAT_AUTHOR_SCRIPTED";
{
    private _worldName = configName _x;
    private _worldConfig = configFile >> "CfgWorlds" >> _worldName;

    private _description = getText (_worldConfig >> "description");
    _worldNames set [_description, _worldname];

    private _pictureMap = getText (_worldConfig >> "pictureMap");
    if (_pictureMap == "") then {_pictureMap = _defaultPicture}; // can be empty
    private _author = getText (_worldConfig >> "author");
    if (_author == "") then {_author = _defaultAuthor};
    _author = format [_authorFullLocalized, _author];

    _worldFeatures set [_worldName, [_pictureMap, _author]];
} forEach (configProperties [configFile >> "CfgWorldList", "isClass _x"]);

// Show worldnames as tooltips on map list
for "_index" from 0 to ((lbSize _ctrlMaps) - 1) do {
    private _description = _ctrlMaps lbText _index;
    private _worldName = _worldNames getOrDefault [_description, ""];
    _ctrlMaps lbSetTooltip [_index, _worldName];
};

_ctrlMaps setVariable [QGVAR(worldFeatures), _worldFeatures];

ctrlPosition _ctrlMaps params ["_mapsLeft", "_mapsTop", "_mapsWidth", "_mapsHeight"];
private _squareWidth = _mapsHeight * 3 / 4;
private _mapsWidthNew = _mapsWidth - _squareWidth;
_ctrlMaps ctrlSetPositionW _mapsWidthNew;
_ctrlMaps ctrlCommit 0;

private _ctrlIslandPanorama = _display ctrlCreate ["RscPicture", IDC_RSCDISPLAYSELECTISLAND_ISLANDPANORAMA];
_ctrlIslandPanorama ctrlSetPosition [
    _mapsLeft + _mapsWidthNew,
    _mapsTop,
    _squareWidth,
    _mapsHeight
];
_ctrlIslandPanorama ctrlCommit 0;

_ctrlMaps ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlMaps", "_lbCurSel"];
    private _worldFeatures = _ctrlMaps getVariable QGVAR(worldFeatures);
    _worldFeatures getOrDefault [_ctrlMaps lbData _lbCurSel, []] params [["_picture", ""], ["_author", ""]];
    private _display = ctrlParent _ctrlMaps;
    private _ctrlIslandPanorama = _display displayCtrl IDC_RSCDISPLAYSELECTISLAND_ISLANDPANORAMA;
    _ctrlIslandPanorama ctrlSetText _picture;
    _ctrlIslandPanorama ctrlSetTooltip _author;
}];

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

private _showStockMissions = true isEqualTo (profileNamespace getVariable [QGVAR(ShowStockMissions), true]);
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
        private _picture = _ctrlMissions lbPicture _i;
        private _pictureRight = _ctrlMissions lbPictureRight _i;

        _missions pushBack [_name, _value, _data, _color, _picture, _pictureRight];
    };

    _ctrlMissions setVariable [QGVAR(missions), _missions];
    _display call (_display getVariable QFUNC(filter));
}}};

_ctrlMaps call _fnc_storeMapMissions;
_ctrlMaps ctrlAddEventHandler ["LBSelChanged", _fnc_storeMapMissions];

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
        _x params ["_name", "_value", "_data", "_color", "_picture", "_pictureRight"];
        private _classname = _data splitString "." param [0, ""];

        if (toLower _name find _filter != -1 && {_showStockMissions || {!(_classname in _stockMissions)}}) then {
            private _index = _ctrlMissions lbAdd _name;
            _ctrlMissions lbSetValue [_index, _value];
            _ctrlMissions lbSetData [_index, _data];
            _ctrlMissions lbSetColor [_index, _color];
            _ctrlMissions lbSetPicture [_index, _picture];
            _ctrlMissions lbSetPictureRight [_index, _pictureRight];
            _ctrlMissions lbSetTooltip [_index, format ["%1", _data]];
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

//#define DEBUG_MODE_FULL
#include "\x\cba\addons\ui\script_component.hpp"

TRACE_1("",_this);

private ["_msg", "_exit", "_list", "_i", "_key"];
// _this = ["player", [DIK_LSHIFT], -3, ["mission\weapon_menuDef.sqf", ["main"]]]
// Note: calling script may require this file for dik codes: #include "\x\cba\addons\ui_helper\script_dikCodes.hpp"

_msg = "FLEXIMENU: Unknown Error in fnc_add.sqf"; //Initialize
_key = [];

// validate params
_msg = format ["Error: invalid params. %1 (%2)", _this, __FILE__ ];  //

if (isNil "_msg") then  { _msg = "FLEXIMENU: Unknown Error in fnc_add.sqf"};
if (isNil QUOTE(GVAR(typeMenuSources))) exitWith {diag_log "Error: TypeMenuSources invalid"};
if (typeName _this != typeName []) exitWith {diag_log _msg};
if (count _this < 4 || {count _this > 5}) exitWith {diag_log "Error: Too few or too many arguments"};
if !(toLower typeName (_this select _flexiMenu_typeMenuSources_ID_type) in [toLower typeName "", toLower typeName []]) exitWith {diag_log _msg};
if (typeName (_this select _flexiMenu_typeMenuSources_ID_DIKCodes) != typeName []) exitWith {diag_log _msg};
if (typeName (_this select _flexiMenu_typeMenuSources_ID_priority) != typeName 2) exitWith {diag_log _msg};
if !(typeName (_this select _flexiMenu_typeMenuSources_ID_menuSource) in [typeName [], typeName ""]) exitWith {diag_log _msg};

// common bug: invalid DIK code (type any) when missing #include "dikCodes.h"

//TODO: still not detecting nil?
// if (({isNil "_x"} count (_this select _flexiMenu_typeMenuSources_ID_DIKCodes)) > 0) exitWith {diag_log _msg};

if (count _this == 4) then {_this pushBack true};


// convert any single key items (eg: DIK_A) into a key array [key, [shift,ctrl,alt]]
if (count (_this select _flexiMenu_typeMenuSources_ID_DIKCodes) != 0) then {
    for "_i" from 0 to (count (_this select _flexiMenu_typeMenuSources_ID_DIKCodes) - 1) do {
        _key = (_this select _flexiMenu_typeMenuSources_ID_DIKCodes) select _i;
        // if not an already an array (eg: simple DIK integer)
        if (typeName _key != typeName []) then {
            _key = [_key, [false,false,false]];
            (_this select _flexiMenu_typeMenuSources_ID_DIKCodes) set [_i, _key];
        };
    };
};

TRACE_2("",_key,_flexiMenu_typeMenuSources_ID_DIKCodes);

// Check for duplicate record and then warn and ignore.
if (count (_this select _flexiMenu_typeMenuSources_ID_DIKCodes) != 0) then {
    if (({str _x == str _this} count (_this select _flexiMenu_typeMenuSources_ID_DIKCodes)) > 0) exitWith {
        diag_log format ["Warning: duplicate record, ignoring. %1 (%2)", _this, __FILE__];
    };
};

GVAR(typeMenuSources) pushBack _this;
[GVAR(typeMenuSources), _flexiMenu_typeMenuSources_ID_priority] call CBA_fnc_sortNestedArray;

// reverse the order of sorting, so highest priority is at the top
_list = [];
for "_e" from (count GVAR(typeMenuSources) - 1) to 0 step -1 do {
    _list pushBack (GVAR(typeMenuSources) select _e);
};
GVAR(typeMenuSources) = _list;

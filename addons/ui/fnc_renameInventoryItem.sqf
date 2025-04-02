#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_renameInventoryItem

Description:
    Renames inventory item locally

Parameters:
    _class - Item classname. <STRING>
    _name - New item name. <STRING>
    _picture - New item picture. <STRING>

Examples:
    (begin example)
        ["DocumentsSecret", "SynixeBrett's secret documents"] call CBA_fnc_renameInventoryItem;
        ["DocumentsSecret", "SynixeBrett's secret documents", "\a3\Missions_F_Oldman\Props\data\FilesSecret_ca.paa"] call CBA_fnc_renameInventoryItem;
    (end)

Returns:
    Nothing

Authors:
    SynixeBrett
---------------------------------------------------------------------------- */

params [
    ["_class", "", [""]],
    ["_name", "", [""]],
    ["_picture", "", [""]]
];

// Exit if no interface or empty class
if (!hasInterface || {_class == ""}) exitWith {};

// Create local namespace on first use
if (isNil QGVAR(renamedItems)) then {
    GVAR(renamedItems) = createHashMap;
};

private _config = _class call CBA_fnc_getItemConfig;
if (isNull _config) exitWith { ERROR_1("Class [%1] does not exists",_class) };
_class = configName _config; // Ensure class name is in config case

GVAR(renamedItems) set [_class, [_name, _picture]];

nil

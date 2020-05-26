#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_renameInventoryItem

Description:
    Renames inventory item locally

Parameters:
    _class - Item classname. <STRING>
    _name - New item name. <STRING>

Examples:
    (begin example)
        ["DocumentsSecret", "SynixeBrett's secret documents"] call CBA_fnc_renameInventoryItem;
    (end)

Returns:
    Nothing

Authors:
    SynixeBrett
---------------------------------------------------------------------------- */

params [
  ["_class", "", [""]],
  ["_name", "", [""]]
];

// Exit if no interface or empty class
if (!hasInterface || {_class isEqualTo ""}) exitWith {};

// Create local namespace on first use
if (isNil QGVAR(renamedItems)) then {
  GVAR(renamedItems) = false call CBA_fnc_createNamespace;
};

GVAR(renamedItems) setVariable [_class, _name];

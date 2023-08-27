#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_addAttachementCondition

Description:
    Adds condition to be able to switch to an attachment.

Parameters:
    0: _item - Attachment classname <STRING>
    1: _condition - Code (return false if not allowed) <CODE>

Returns:
    None

Examples:
    (begin example)
        ["ACE_acc_pointer_red", { false }] call CBA_fnc_addAttachementCondition
    (end)

Author:
    PabstMirror
---------------------------------------------------------------------------- */

params [["_item", "", [""]], ["_condition", {true}, [{}]]];

if (!isClass (configfile >> "CfgWeapons" >> _item)) exitWith { ERROR_1("Item not found [%1]", _item); };

private _usageArray = GVAR(usageHash) getOrDefault [_item, [], true];
_usageArray pushBack _condition;

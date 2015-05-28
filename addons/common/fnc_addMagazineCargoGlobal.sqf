/* ----------------------------------------------------------------------------
Function: CBA_fnc_addMagazineCargoGlobal

Description:
    Add magazine(s) to a vehicle's cargo. MP synchronized.

    Function which verifies existence of _item and _unit, returns false in case
    of trouble, or when able to add _item to _unit true in case of success.

Parameters:
    _unit  - the vehicle [Object]
    _item  - name of magazine to [String]
    _count - number of magazines to add [Number] (Default: 1)

Returns:
    true on success, false otherwise

Examples:
    (begin example)
    // Add one mine to the cargo of SomeTruck
    _result = [ SomeTruck, "Mine"] call CBA_fnc_AddMagazineCargoGlobal

    // Add three smoke cans to MyCar
    _result = [ MyCar, "SmokeShell", 3] call CBA_fnc_AddMagazineCargoGlobal
    (end)

Author:
  Sickboy (addMagazineCargo)
---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(addMagazineCargoGlobal);

PARAMS_2(_unit,_item);
DEFAULT_PARAM(2,_count,1);

if (typeName _unit != "OBJECT") exitWith
{
    TRACE_2("Unit not Object",_unit,_item);
    false
};
//_item = _this select 1;
if (typeName _item != "STRING") exitWith
{
    TRACE_2("Item not String",_unit,_item);
    false
};
if (isNull _unit) exitWith
{
    TRACE_2("Unit isNull",_unit,_item);
    false
};
if (_item == "") exitWith
{
    TRACE_2("Empty Item",_unit,_item);
    false
};
if !(isClass (configFile >> "CfgMagazines" >> _item)) exitWith
{
    TRACE_2("Item does not exist in the game config",_unit,_item);
    false
};
if (typeName _count != "SCALAR") exitWith
{
    TRACE_3("Count is not a number",_unit,_item,_count);
    false
};
_unit addMagazineCargoGlobal [_item, _count];
TRACE_3("Success",_unit,_item,_count);
true

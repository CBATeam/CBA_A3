/* ----------------------------------------------------------------------------
Function: CBA_fnc_getGroupIndex

Description:
    Finds out the actual ID number of a person within his group as assigned by
    the game and used in the squad leader's command menu.

    This is not just the order within the units of his group (this order can
    change due to players joining and leaving the game, deaths or promotions).

    Inspired by the OFP function, squadNumber.sqf, by General Barron
    (http://www.ofpec.com/ed_depot/index_new.php?action=details&id=139&page=1&game=OFP&type=fu&cat=xyz)

Parameters:
    _unit - Unit to check <OBJECT>

Returns:
    Number of person in his group <NUMBER>

Author:
    ?, A3: commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(getGroupIndex);

params [["_unit", objNull, [objNull]]];

{
    // Save and remove the person's varName, so that format doesn't just show that.
    private _varName = vehicleVarName _unit;
    _unit setVehicleVarName "";

    private _return = str _unit select [count str group _unit + 1];
    _return = (_return splitString " ") param [0, ""];

    // Go back to the original varName.
    _unit setVehicleVarName _varName;

    parseNumber _return
} call CBA_fnc_directCall

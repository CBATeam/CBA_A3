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
    _man - Man to check [Object: "Man"]

Returns:
    Number of person in his group [Number: 1+]

---------------------------------------------------------------------------- */

#include "script_component.hpp"
#include "\x\cba\addons\strings\script_strings.hpp"

SCRIPT(getGroupIndex);

// ----------------------------------------------------------------------------

params ["_man"];

private ["_varName", "_manLabel", "_number", "_labelArray", "_groupLabelLen"];

// Save and remove the person's varName, so that format doesn't just show that.
_varName = vehicleVarName _man;
_man setVehicleVarName "";

_labelArray = toArray (str _man);
_groupLabelLen = [str (group _man)] call CBA_fnc_strLen;
_number = [];

// Read in all digits after the group name and colon in the full player label.
// Format of player label is "<groupName>:<groupNumber> <playerName>"
for "_i" from (_groupLabelLen + 1) to ((count _labelArray) - 1) do {
    if ((_labelArray select _i) == ASCII_SPACE) exitWith {};
    _number pushBack (_labelArray select _i);
};

// Go back to the original varName.
_man setVehicleVarName _varName;

parseNumber (toString _number); // Return.

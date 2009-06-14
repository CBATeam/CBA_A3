#include "script_component.hpp"
/*
	createTrigger function by Sickboy (sb_at_dev-heaven.net)
	Basic: [[position]] call createTrigger;
	Optional:
	"AREA:", [5, 5, 0,false]
	"ACT:", ["CIV", "PRESENT", true]
	"STATE:", ["this", "hint 'Civilian near player'", "hint 'no civilian near'"]
	"NAME:", "VariableName"
*/

private
[
	"_pos",
	"_area",
	"_activation",
	"_name",
	"_statements",
	"_trg"
];

_pos = _this select 0;
_area = ["AREA:", "area:", [],_this] call CBA_fGetArg;
_activation = ["ACT:", "act:", [],_this] call CBA_fGetArg;
_statements = ["STATE:", "state:", [],_this] call CBA_fGetArg;
_name = ["NAME:", "name:", "", _this] call CBA_fGetArg;

_trg = createTrigger["EmptyDetector", _pos];
if (count _area>0) then { _trg setTriggerArea _area };
if (count _activation>0) then { _trg setTriggerActivation _activation };
if (count _statements>0) then { _trg setTriggerStatements _statements };
if (_name != "") then { call compile format["%1 = _trg", _name] };

[_trg, _this]
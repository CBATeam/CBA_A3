#define DEBUG_MODE_FULL
#include "script_component.hpp"

private ["_ar", "_entry"];
PARAMS_1(_unit);
_ar = [];
_entry = ["Unit", format["%1", typeOf _unit]];
PUSH(_ar,_entry);

if (vehicle _unit != _unit) then {
	_entry = ["Vehicle", format["%1", typeOf (vehicle _unit)]];
	PUSH(_ar,_entry);
};

_entry = ["Weapons", format["%1", weapons _unit]];
PUSH(_ar,_entry);
_entry = ["Magazines", format["%1", magazines _unit]];
PUSH(_ar,_entry);

_ar;

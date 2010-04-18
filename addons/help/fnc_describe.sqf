#define DEBUG_MODE_FULL
#define __cfg configFile >> _type
#include "script_component.hpp"

private ["_ar", "_entry", "_type"];
PARAMS_1(_unit);
_ar = [];
_type = typeOf _unit;

_entry = ["Unit", format["%1", _type]];
PUSH(_ar,_entry);

if (vehicle _unit != _unit) then {
	_entry = ["Vehicle", format["%1", typeOf (vehicle _unit)]];
	PUSH(_ar,_entry);
};

_entry = ["Weapons", format["%1", weapons _unit]];
PUSH(_ar,_entry);

_entry = ["Magazines", format["%1", magazines _unit]];
PUSH(_ar,_entry);

if (isArray(__cfg >> "Author")) then {
	_entry = ["Author", format["%1", getArray(__cfg >> "Author")]];
	PUSH(_ar,_entry);
};

if (isText(__cfg >> "AuthorUrl")) then {
	_entry = ["AuthorUrl", format["%1", getText(__cfg >> "AuthorUrl")]];
	PUSH(_ar,_entry);
};

_ar;

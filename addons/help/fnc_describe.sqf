//#define DEBUG_MODE_FULL
#define __cfg configFile >> _type
#define __cfgveh configFile >> _type
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
    if (isArray(__cfgveh >> "author")) then {
        _entry = ["VehAuthor", format["%1", getArray(__cfgveh >> "author")]];
        PUSH(_ar,_entry);
    };

    if (isText(__cfgveh >> "authorUrl")) then {
        _entry = ["VehAuthorUrl", format["%1", getText(__cfgveh >> "authorUrl")]];
        PUSH(_ar,_entry);
    };
};

_entry = ["Weapons", format["%1", weapons _unit]];
PUSH(_ar,_entry);

_entry = ["Magazines", format["%1", magazines _unit]];
PUSH(_ar,_entry);

if (isArray(__cfg >> "author")) then {
    _entry = ["Author", format["%1", getArray(__cfg >> "author")]];
    PUSH(_ar,_entry);
};

if (isText(__cfg >> "authorUrl")) then {
    _entry = ["AuthorUrl", format["%1", getText(__cfg >> "authorUrl")]];
    PUSH(_ar,_entry);
};

_ar;

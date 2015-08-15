// #define DEBUG_MODE_FULL
#include "script_component.hpp"

private ["_cfg", "_init", "_initAr", "_XEH", "_type", "_excl"];

params ["_obj"];
_type = typeOf _obj;

if (_type in SLX_XEH_EXCL_CLASSES) exitWith { TRACE_2("Exclusion, abort (cache hit)",_obj,_type) };

_excl = getNumber(configFile >> "CfgVehicles" >> _type >> "SLX_XEH_DISABLED") == 1;
if !(_excl) then { { if (_obj isKindOf _x) exitWith { _excl = true } } forEach SLX_XEH_EXCLUDES };
if (_excl) exitWith {
    TRACE_2("Exclusion, abort and caching",_obj,_type);
    PUSH(SLX_XEH_EXCL_CLASSES,_type);
};

_cfg = (configFile >> "CfgVehicles" >> _type >> "EventHandlers");

// No EH class - Needs full XEH
if !(isClass _cfg) exitWith {
    TRACE_2("Adding XEH Full and caching",_obj,_type);
    PUSH(SLX_XEH_FULL_CLASSES,_type);
    [_obj] call SLX_XEH_EH_Init;
};

// Check 2 - XEH init EH detected
_XEH = false;
_init = _cfg >> "init";
if (isText _init) then {
    _txt = getText(_init);
    _XEH = _txt find "_this call SLX_XEH_EH_Init" > -1;
};

if (_XEH) then {
    TRACE_2("Has XEH init",_obj,_type)
} else {
    TRACE_2("Adding XEH init",_obj,_type);
    [_obj] call SLX_XEH_EH_Init;
};

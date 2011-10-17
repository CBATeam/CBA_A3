// Init/InitPost per Object

// #define DEBUG_MODE_FULL
#include "script_component.hpp"

/*  Extended event handlers by Solus
*
*  Get all inherited classes, then check if each inherited class has a counter-
*  part in the extended event handlers classes, then and add all lines from
*  each matching EH class and exec them.
*/
private [
	"_slx_xeh_unit", "_Extended_Init_Class", "_isRespawn", "_unitClass",
	"_inits", "_init", "_excludeClass", "_excludeClasses", "_isExcluded",
	"_u", "_sim", "_data",
	"_isMan", "_fSetInit", "_post", "_isDelayed", "_sys_inits", "_slx_xeh_unitAr"
];

#ifdef DEBUG_MODE_FULL
	format["XEH BEG: %2, %3", time, _this, local (_this select 0), typeOf (_this select 0)] call SLX_XEH_LOG;
#endif

// Get unit.
PARAMS_1(_slx_xeh_unit);

if (isNull _slx_xeh_unit) exitWith {
	#ifdef DEBUG_MODE_FULL
		format["XEH EXIT - NULL OBJECT: %2", time, _this] call SLX_XEH_LOG;
	#endif
};

DEFAULT_PARAM(1,_Extended_Init_Class,SLX_XEH_STR_INIT_EH);
DEFAULT_PARAM(2,_isRespawn,false);
DEFAULT_PARAM(3,_isDelayed,false);
_unitClass = typeOf _slx_xeh_unit;
TRACE_1("UnitClass",_unitClass);
_post = _Extended_Init_Class == SLX_XEH_STR_INIT_POST_EH;

// Multiplayer respawn handling
// Bug #7432 fix - all machines will re-run the init EH where the unit is not local, when a unit respawns
_sim = getText(configFile/"CfgVehicles"/_unitClass/"simulation");
_isMan = _slx_xeh_unit isKindOf "Man" || { _sim == _x }count["soldier"] > 0; // "invisible"

if !(_post) then {
	// Pre Cache the "Other" EventHandlers
	if !(SLX_XEH_RECOMPILE) then { _unitClass call FUNC(init_others_enum_cache) };
};

// TODO: Remove delayed when v1.60 or newer is detected - #25225
if (count _this == 2 && _isMan && (time>0) && (SLX_XEH_MACHINE select 9) && !_post) exitWith
{
	// Delay initialisation until we can check if it's a respawned unit
	// or a createUnit:ed one. (Respawned units will have the object variable
	// "slx_xeh_isplayable" set to true)
	#ifdef DEBUG_MODE_FULL
		format["XEH: (Bug #7432) deferring init for %2 ",time, _this] call SLX_XEH_LOG;
	#endif

	// PreCache Init eventhandlers
	if !(SLX_XEH_RECOMPILE) then {
		[_unitClass, _Extended_Init_Class, false] call FUNC(init_enum_cache);
		[_unitClass, _Extended_Init_Class, true] call FUNC(init_enum_cache);
	};

	// Wait for the unit to be fully "ready"
	if (SLX_XEH_MACHINE select 7) then {
		_h = [_slx_xeh_unit] spawn FUNC(init_delayed);
	} else {
		PUSH(SLX_XEH_DELAYED,_slx_xeh_unit);
	};

	#ifdef DEBUG_MODE_FULL
	format["XEH END: %2", time, _this] call SLX_XEH_LOG;
	#endif
	nil;
};

if (_isMan && !isNil "SLX_XEH_INIT_MEN") then { if !(_slx_xeh_unit in SLX_XEH_INIT_MEN) then { PUSH(SLX_XEH_INIT_MEN,_slx_xeh_unit) } }; // naughty JIP crew double init!

// All inits
_inits = [_unitClass, _Extended_Init_Class, _isRespawn] call FUNC(init_enum_cache);

// Naughty but more flexible...
// TODO: Improve
_sys_inits = [];
if !(_isRespawn) then {
	// Compile code for other EHs to run and put them in the setVariable.
	// Set up code for the remaining event handlers too...
	// This is in PostInit as opposed to (pre)Init,
	// because units in a player's group setVariables are lost (counts at least for disabledAI = 1;)
	// Run men's FUNC(init_others) in PostInit, only when in Multiplayer
	// Run supportM
	
	// TODO: Remove delayed to PostInit for ManBasedUnits when v1.60 or newer is detected - #25225
	if (_post) then {
		if (_isMan) then {
			_sys_inits set [count _sys_inits, {_this call FUNC(init_playable) }];
			if (isMultiplayer) then { _sys_inits set [count _sys_inits, {_this call FUNC(init_others)}] };
		};
	} else {
		_sys_inits set [count _sys_inits, {_this call FUNC(support_monitor2)}];
		if (!_isMan || !isMultiplayer) then { _sys_inits set [count _sys_inits, {_this call FUNC(init_others)}] };
	};
};

if !(_post) then { _sys_inits set [count _sys_inits, compile format ['[_this select 0, %1, %2] call FUNC(init_post)',_isRespawn,_isDelayed]] };

if (count _sys_inits > 0) then { _inits = [_sys_inits] + _inits };

// Now call all the init EHs on the unit.
#ifdef DEBUG_MODE_FULL
	format["XEH RUN: %2 - %3 - %4", time, _this, typeOf _slx_xeh_unit, _inits] call SLX_XEH_LOG;
#endif

_slx_xeh_unitAr = [_slx_xeh_unit];

// forEach configFile type
{
	// forEach code
	{
		TRACE_4("Running Code on",_Extended_Init_Class,_slx_xeh_unitAr,_unitClass,_x);
		_slx_xeh_unitAr call _x;
	} forEach _x;
} forEach _inits;

#ifdef DEBUG_MODE_FULL
	format["XEH END: %2", time, _this] call SLX_XEH_LOG;
#endif

nil;

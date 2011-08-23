// #define DEBUG_MODE_FULL
#include "script_component.hpp"

/*  Extended event handlers by Solus
*
*  Get all inherited classes, then check if each inherited class has a counter-
*  part in the extended event handlers classes, then and add all lines from
*  each matching EH class and exec them.
*/
private [
	"_slx_xeh_unit", "_Extended_Init_Class", "_isRespawn", "_unitClass", "_classes",
	"_inits", "_init", "_excludeClass", "_excludeClasses", "_isExcluded",
	"_u", "_sim", "_data",
	"_isMan", "_fSetInit", "_post", "_isDelayed", "_sys_inits", "_slx_xeh_unitAr"
];

#ifdef DEBUG_MODE_FULL
	format["XEH BEG: %2, %3", time, _this, local (_this select 0), typeOf (_this select 0)] call SLX_XEH_LOG;
#endif

// Get unit.
_slx_xeh_unit = _this select 0;
if (isNull _slx_xeh_unit) exitWith {
	#ifdef DEBUG_MODE_FULL
		format["XEH EXIT - NULL OBJECT: %2", time, _this] call SLX_XEH_LOG;
	#endif
};
_Extended_Init_Class = _this select 1;
_isRespawn = if (count _this < 3) then { false } else { _this select 2 };
_isDelayed = if (count _this < 4) then { false } else { _this select 3 };
_unitClass = typeOf _slx_xeh_unit;

_post = _Extended_Init_Class == "Extended_InitPost_EventHandlers";

// Multiplayer respawn handling
// Bug #7432 fix - all machines will re-run the init EH where the unit is not local, when a unit respawns
_sim = getText(configFile/"CfgVehicles"/_unitClass/"simulation");
_isMan = _slx_xeh_unit isKindOf "Man" || { _sim == _x }count["soldier"] > 0; // "invisible"

if (count _this == 2 && _isMan && (time>0) && (SLX_XEH_MACHINE select 9) && !_post) exitWith
{
	// Delay initialisation until we can check if it's a respawned unit
	// or a createUnit:ed one. (Respawned units will have the object variable
	// "slx_xeh_isplayable" set to true)
	#ifdef DEBUG_MODE_FULL
		format["XEH: (Bug #7432) deferring init for %2 ",time, _this] call SLX_XEH_LOG;
	#endif

	// Wait for the unit to be fully "ready"
	if (SLX_XEH_MACHINE select 7) then {
		_h = [_slx_xeh_unit] spawn SLX_XEH_INIT_DELAYED;
	} else {
		SLX_XEH_DELAYED set [count SLX_XEH_DELAYED, _slx_xeh_unit];
	};

	#ifdef DEBUG_MODE_FULL
	format["XEH END: %2", time, _this] call SLX_XEH_LOG;
	#endif
	nil;
};

if (_isMan) then { if !(isNil "SLX_XEH_INIT_MEN") then { PUSH(SLX_XEH_INIT_MEN,_slx_xeh_unit) } }; // naughty JIP crew double init!

// Get array of inherited classes of unit.
_classes = [_unitClass];
while { !((_classes select 0) in SLX_XEH_DEF_CLASSES) } do
{
	_classes = [(configName (inheritsFrom (configFile/"CfgVehicles"/(_classes select 0))))]+_classes;
};

_inits = [];

// Naughty but more flexible...
_sys_inits = [];
if !(_isRespawn) then {
	// Compile code for other EHs to run and put them in the setVariable.
	// Set up code for the remaining event handlers too...
	// This is in PostInit as opposed to (pre)Init,
	// because units in a player's group setVariables are lost (counts at least for disabledAI = 1;)
	// Run men's SLX_XEH_initOthers in PostInit, only when in Multiplayer
	// Run supportM
	if (_post) then {
		if (_isMan) then {
			_sys_inits set [count _sys_inits, {_this call SLX_XEH_initPlayable }];
			if (isMultiplayer) then { _sys_inits set [count _sys_inits, {_this call SLX_XEH_initOthers}] };
		};
	} else {
		_sys_inits set [count _sys_inits, {_this call SLX_XEH_FNC_SUPPORTM2}];
		if (!_isMan || !isMultiplayer) then { _sys_inits set [count _sys_inits, {_this call SLX_XEH_initOthers}] };
	};
};

if !(_post) then { _sys_inits set [count _sys_inits, compile format ["[_this select 0, %1, %2] call SLX_XEH_initPost",_isRespawn,_isDelayed]] };


/*
*  Several BIS vehicles use a set of EH:s in the BIS "DefaultEventhandlers"
*  ("DEH" in the following) class - Car, Tank, Helicopter, Plane and Ship.
*
*  Further, The AAV class uses a variation of this DefaultEventhandlers set with
*  it's own specific init EH.  Here, we make sure to include the BIS DEH init
*  event handler and make it the first one that will be called by XEH. The AAV
*  is accomodated by code further below and two composite
*  Extended_Init_EventHandlers definitions in the config.cpp that define
*  a property "replaceDefault" which will replace the DEH init with the
*  class-specific BIS init EH for that vehicle.
*/

// TODO: What if SuperOfSuper inheritsFrom DefaultEventhandlers?
_useDEHinit = false;
if !(_post) then
{
	_ehSuper = inheritsFrom(configFile/"CfgVehicles"/_unitClass/"EventHandlers");
	if (configName(_ehSuper)=="DefaultEventhandlers") then
	{
		if (isText (configFile/"DefaultEventhandlers"/"init")) then
		{
			_useDEHinit = true;
			_DEHinit = getText(configFile/"DefaultEventhandlers"/"init");
			_inits = [compile(_DEHinit)];
		};
	};
};

// All inits
{
	_data = [_x >> _Extended_Init_Class, _unitClass, _classes, _useDEHinit, _isRespawn] call SLX_XEH_F2_INIT;
	ADD(_inits,_data);
} forEach SLX_XEH_CONFIG_FILES;

if (count _sys_inits > 0) then { _inits = _sys_inits + _inits };

// Now call all the init EHs on the unit.
#ifdef DEBUG_MODE_FULL
	format["XEH RUN: %2 - %3 - %4", time, _this, typeOf (_this select 0), _inits] call SLX_XEH_LOG;
#endif

_slx_xeh_unitAr = [_slx_xeh_unit];
{
	if (typeName _x=="CODE") then
	{
		// Normal code type handler
		_slx_xeh_unitAr call _x;
	} else {
		// It's an array of handlers (all, server, client)
		{_slx_xeh_unitAr call _x} forEach _x;
	};
} forEach _inits;

#ifdef DEBUG_MODE_FULL
	format["XEH END: %2", time, _this] call SLX_XEH_LOG;
#endif

nil;

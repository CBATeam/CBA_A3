// #define DEBUG_MODE_FULL
#include "script_component.hpp"

SLX_XEH_EH_Init = { PUSH(SLX_XEH_PROCESSED_OBJECTS,_this select 0); [_this select 0, SLX_XEH_STR_INIT_EH]call FUNC(init) };
SLX_XEH_EH_RespawnInit = { PUSH(SLX_XEH_PROCESSED_OBJECTS,_this select 0); [_this select 0, SLX_XEH_STR_INIT_EH, true] call FUNC(init) };

// The actual XEH functions that are called from within the engine eventhandlers.
// This can also be uesd for better debugging
#ifdef DEBUG_MODE_FULL
	#define XEH_FUNC_NORMAL(A) SLX_XEH_STR_##A = 'Extended_##A##EH'; SLX_XEH_EH_##A = { if ('A' in ['Respawn', 'MPRespawn', 'Killed', 'MPKilled', 'Hit', 'MPHit']) then { diag_log ['A',_this, local (_this select 0), typeOf (_this select 0)] }; { _this call _x }forEach((_this select 0)getVariable SLX_XEH_STR_##A) }
#endif
#ifndef DEBUG_MODE_FULL
	#define XEH_FUNC_NORMAL(A) SLX_XEH_STR_##A = 'Extended_##A##EH'; SLX_XEH_EH_##A = { { _this call _x }forEach((_this select 0)getVariable SLX_XEH_STR_##A) }
#endif

#define XEH_FUNC_PLAYER(A) SLX_XEH_STR_##A##_Player = 'Extended_##A##EH_Player'; SLX_XEH_EH_##A##_Player = { { _this call _x }forEach((_this select 0)getVariable SLX_XEH_STR_##A_Player) }

#define XEH_FUNC(A) XEH_FUNC_NORMAL(A); XEH_FUNC_PLAYER(A)

XEH_FUNC(Hit);
XEH_FUNC(AnimChanged);
XEH_FUNC(AnimDone);
XEH_FUNC(AnimStateChanged);
XEH_FUNC(Dammaged);
XEH_FUNC(Engine);
XEH_FUNC(FiredNear);
XEH_FUNC(Fuel);
XEH_FUNC(Gear);
XEH_FUNC(GetIn);
XEH_FUNC(GetOut);
XEH_FUNC(IncomingMissile);
XEH_FUNC(Hit);
XEH_FUNC(Killed);
XEH_FUNC(LandedTouchDown);
XEH_FUNC(LandedStopped);
XEH_FUNC(Respawn);
XEH_FUNC(MPHit);
XEH_FUNC(MPKilled);
XEH_FUNC(MPRespawn);
XEH_FUNC(FiredBis);

SLX_XEH_STR_GetInMan = 'Extended_GetInManEH';
SLX_XEH_STR_GetInMan_Player = 'Extended_GetInManEH_Player';
SLX_XEH_EH_GetInMan = { _slx_xeh_ar = [_this select 2, _this select 1, _this select 0]; {_slx_xeh_ar call _x }forEach((_this select 2)getVariable SLX_XEH_STR_GetInMan) };
SLX_XEH_EH_GetInMan_Player = { _slx_xeh_ar = [_this select 2, _this select 1, _this select 0]; {_slx_xeh_ar call _x }forEach((_this select 2)getVariable SLX_XEH_STR_GetInMan_Player) };

SLX_XEH_STR_GetOutMan = 'Extended_GetInManEH';
SLX_XEH_STR_GetOutMan_Player = 'Extended_GetInManEH_Player';
SLX_XEH_EH_GetOutMan = { _slx_xeh_ar = [_this select 2, _this select 1, _this select 0]; {_slx_xeh_ar call _x}forEach((_this select 2)getVariable SLX_XEH_STR_GetOutMan) };
SLX_XEH_EH_GetOutMan_Player = { _slx_xeh_ar = [_this select 2, _this select 1, _this select 0]; { _slx_xeh_ar call _x }forEach((_this select 2)getVariable SLX_XEH_STR_GetOutMan_Player) };

SLX_XEH_STR_Fired = 'Extended_FiredEH';
SLX_XEH_STR_Fired_Player = 'Extended_FiredEH_Player';
SLX_XEH_EH_Fired =
{
	#ifdef DEBUG_MODE_FULL
		// diag_log ['Fired',_this, local (_this select 0), typeOf (_this select 0)];
	#endif
	_this call SLX_XEH_EH_FiredBis;
	_feh = ((_this select 0)getVariable SLX_XEH_STR_Fired);
	if (count _feh > 0) then { 
		_c=count _this;
		if(_c<6)then{_this set[_c,nearestObject[_this select 0,_this select 4]];_this set[_c+1,currentMagazine(_this select 0)]}else{_this = +_this; _mag=_this select 5;_this set[5,_this select 6];_this set[6,_mag]};
		{_this call _x } forEach _feh;
	};
};
SLX_XEH_EH_Fired_Player =
{
	#ifdef DEBUG_MODE_FULL
		// diag_log ['Fired',_this, local (_this select 0), typeOf (_this select 0)];
	#endif
	_this call SLX_XEH_EH_FiredBis_Player;
	_feh = ((_this select 0)getVariable SLX_XEH_STR_Fired_Player);
	if (count _feh > 0) then { 
		_c=count _this;
		if(_c<6)then{_this set[_c,nearestObject[_this select 0,_this select 4]];_this set[_c+1,currentMagazine(_this select 0)]}else{_this = +_this; _mag=_this select 5;_this set[5,_this select 6];_this set[6,_mag]};
		{_this call _x } forEach _feh;
	};
};

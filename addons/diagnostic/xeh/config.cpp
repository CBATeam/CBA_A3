// #define EH_DEBUG_ENABLED
#ifdef EH_DEBUG_ENABLED
	#include "script_component.hpp"
	class CfgPatches {
			class ADDON {
					units[] = {};
					weapons[] = {};
					worlds[] = {};
					requiredVersion = 1.0;
					requiredAddons[] = {"cba_diagnostic"};
			};
	};

	#define ARGUMENTS diag_frameNo, diag_tickTime, time, _this
	#define UNIT_ARGS 'type', 'STD', typeOf (_this select 0), _this
	#define UNIT_ARGS2 'type', 'PLY', typeOf (_this select 0), _this
	#define EH_INIT(type2) ##type2 = QUOTE(FUNC(diag_xeh) = { diag_log [ARGUMENTS]; }; ['type type2'] call FUNC(diag_xeh))

	#define EH_DEBUG(type) class Extended_##type##_EventHandlers { class All { class 0 { ##type = QUOTE([UNIT_ARGS] call FUNC(diag_xeh)); ##type##Player = QUOTE([UNIT_ARGS2] call FUNC(diag_xeh)); }; }; }
	// Exception: INIT and INITPOST both use init, serverInit, clientInit :|
	// TODO: serverInit/clientInit ?
	#define EH_DEBUG_INIT(type) class Extended_##type##_EventHandlers { class All { class 0 { init = QUOTE([UNIT_ARGS] call FUNC(diag_xeh)); }; }; }
	// TODO: server##type client##type ?
	#define EH_DEBUG_ONCE(type) class Extended_##type##_EventHandlers { class 0 { EH_INIT(init); EH_INIT(serverInit); EH_INIT(clientInit); }; }

	EH_DEBUG_ONCE(preInit);
	EH_DEBUG_ONCE(postInit);
	EH_DEBUG_INIT(InitPost);
	EH_DEBUG_INIT(Init);
	EH_DEBUG(AnimChanged);
	EH_DEBUG(AnimDone);
	EH_DEBUG(AnimStateChanged);
	EH_DEBUG(ControlsShifted);
	EH_DEBUG(Dammaged);
	EH_DEBUG(Engine);
	EH_DEBUG(EpeContact);
	EH_DEBUG(EpeContactEnd);
	EH_DEBUG(EpeContactStart);
	EH_DEBUG(Explosion);
	EH_DEBUG(Fired);
	EH_DEBUG(FiredNear);
	EH_DEBUG(Fuel);
	EH_DEBUG(Gear);
	EH_DEBUG(GetIn);
	EH_DEBUG(GetOut);
//	EH_DEBUG(HandleDamage);
//	EH_DEBUG(HandleHeal);
	EH_DEBUG(Hit);
	EH_DEBUG(HitPart);
	EH_DEBUG(IncomingMissile);
	EH_DEBUG(Killed);
	EH_DEBUG(LandedTouchDown);
	EH_DEBUG(LandedStopped);
	EH_DEBUG(Local);
//	EH_DEBUG(MPHit);
//	EH_DEBUG(MPKilled);
//	EH_DEBUG(MPRespawn);
	EH_DEBUG(Put);
	EH_DEBUG(Respawn);
	EH_DEBUG(Take);
	EH_DEBUG(WeaponAssembled);
	EH_DEBUG(WeaponDisassembled);
#endif


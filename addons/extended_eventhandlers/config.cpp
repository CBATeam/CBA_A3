#define false 0
#define true 1

#define private 0
#define public 2

// Extended event handlers by Solus and Killswitch
class CfgPatches
{
    class Extended_EventHandlers
    {
        units[] = {};
        requiredVersion = 1.00;
        requiredAddons[] = { "CAData", "CAAir", "CACharacters" };
        SLX_XEH2_Version = 2.00;
    };
};

class CfgAddons
{
    class PreloadAddons
    {
        class Extended_EventHandlers
        {
            list[] = { "Extended_EventHandlers" };
        };
     };
};

// XEH uses all existing event handlers
#define EXTENDED_EVENTHANDLERS init = "if(isnil'SLX_XEH_objects')then{call compile preprocessFile'extended_eventhandlers\InitXEH.sqf'};[_this select 0,'Extended_Init_EventHandlers']call SLX_XEH_init;"; \
fired = "_s=nearestObject[_this select 0,_this select 4]; [_this select 0,_this select 1,_this select 2,_this select 3,_this select 4,_s]call((_this select 0)getVariable'Extended_FiredEH')"; \
animChanged     = "_this call((_this select 0)getVariable'Extended_AnimChangedEH')"; \
animDone        = "_this call((_this select 0)getVariable'Extended_AnimDoneEH')"; \
dammaged        = "_this call((_this select 0)getVariable'Extended_DammagedEH')"; \
engine          = "_this call((_this select 0)getVariable'Extended_EngineEH')"; \
firedNear       = "_this call((_this select 0)getVariable'Extended_FiredNearEH')"; \
fuel            = "_this call((_this select 0)getVariable'Extended_FuelEH')"; \
gear            = "_this call((_this select 0)getVariable'Extended_GearEH')"; \
getIn           = "_this call((_this select 0)getVariable'Extended_GetInEH')"; \
getOut          = "_this call((_this select 0)getVariable'Extended_GetOutEH')"; \
//handleDamage    = "_this call((_this select 0)getVariable'Extended_HandleDamageEH')"; \
//handleHealing   = "_this call((_this select 0)getVariable'Extended_HandleHealingEH')"; \
hit             = "_this call((_this select 0)getVariable'Extended_HitEH')"; \
incomingMissile = "_this call((_this select 0)getVariable'Extended_IncomingMissileEH')"; \
killed          = "_this call((_this select 0)getVariable'Extended_KilledEH')"; \
landedTouchDown = "_this call((_this select 0)getVariable'Extended_LandedTouchDownEH')"; \
landedStopped   = "_this call((_this select 0)getVariable'Extended_LandedStoppedEH')";


// We'll need this one for backwards compatibility with third-party addons
// that expect the class to exist
class Extended_EventHandlers
{
    EXTENDED_EVENTHANDLERS
};

// Class for "pre-init", run-once event handlers. Code in here runs before any
// Extended_Init_Eventhandlers code.
class Extended_PreInit_EventHandlers {};

// The PostInit handlers also run once, but after all the extended init EH:s
// have run and after all mission.sqm "init lines" have been processed.
class Extended_PostInit_EventHandlers {};

// Finally, "InitPost" handlers are run once on every unit in the mission.
// Note the difference here - the PreInit and PostInit handlers above run once
// per mission but InitPost handlers are called for each unit.
class Extended_InitPost_EventHandlers
{
    class All
    {
        // Compile code for other EHs to run and put them in the setVariable.
        // Set up code for the remaining event handlers too...
        class SLX_Init_Other_All
        {
            scope     = public;
            onRespawn = true;   // Run this EH when a unit respawns
            init      = "_this call SLX_XEH_initOthers";
        };
    };
};

// Extended EH classes, where new events are defined.
class Extended_Init_EventHandlers
{
    // Default Extended Event Handlers: Add extended event handlers to compile code.
    class All
    {
        class SLX_Init_Post_All
        {
                scope     = public;
                onRespawn = true;   // Run this EH when a unit respawns
                init      = "_this call SLX_XEH_initPost";
        };
    };

    // Vehicles.
    class AAV
    {
        class SLX_BIS_AAV_Init
        {
            scope = public;
            init  = "_this execVM'\ca\tracked2\AAV\scripts\init.sqf'";
            replaceDEH = true;  // replace the BIS DefaultEventhandlers init
                                // since this is what the stock BIS AAV does
        };
    };
    
    class StaticCannon
    {
        SLX_BIS_StaticCannon_Init = "_scr = _this execVM'\ca\Data\ParticleEffects\SCRIPTS\init.sqf'";
    };
    
    class M252
    {
        SLX_BIS = "_scr = _this execVM'\ca\Data\ParticleEffects\SCRIPTS\init.sqf'";
    };
    
    class 2b14_82mm
    {
        SLX_BIS = "_scr = _this execVM'\ca\Data\ParticleEffects\SCRIPTS\init.sqf'";
    };
    
    class A10
    {
        SLX_BIS = "_scr = _this execVM ""\ca\Data\ParticleEffects\SCRIPTS\init.sqf"";";
    };
    
    class Su34
    {
        SLX_BIS_init = "_scr = _this execVM ""\ca\Data\ParticleEffects\SCRIPTS\init.sqf"";";
    };
    
    // Fires.
    class Land_Fire_burning
    {
        SLX_BIS = "(_this select 0) inflame true";
    };
    class Land_Campfire_burning
    {
        SLX_BIS = "(_this select 0) inflame true";
    };
    class Land_Fire_barrel_burning
    {
        SLX_BIS = "(_this select 0) inflame true";
    };
    
    // Flag carriers
    class FlagCarrierUSA
    {
        SLX_BIS = "(_this select 0) setFlagTexture ""\ca\data\flag_usa_co.paa""";
    };
    class FlagCarrierCDF
    {
        SLX_BIS = "(_this select 0) setFlagTexture ""\ca\data\flag_Chernarus_co.paa""";
    };
    class FlagCarrierRU
    {
        SLX_BIS = "(_this select 0) setFlagTexture ""\ca\data\flag_rus_co.paa""";
    };
    class FlagCarrierINS
    {
        SLX_BIS = "(_this select 0) setFlagTexture ""\ca\data\flag_ChDKZ_co.paa""";
    };
    class FlagCarrierGUE
    {
        SLX_BIS = "(_this select 0) setFlagTexture ""\ca\data\flag_NAPA_co.paa""";
    };
    class FlagCarrierChecked
    {
        SLX_BIS = "(_this select 0) setFlagTexture ""\ca\structures\misc\armory\checkered_flag\data\checker_flag_co.paa""";
    };
    
    // Popup targets
    class TargetPopUpTarget
    {
        SLX_BIS = "[(_this select 0)] execVM ""ca\misc\scripts\PopUpTarget.sqf""";
    };
    class TargetEpopup
    {
        SLX_BIS = "[(_this select 0)] execVM ""ca\misc\scripts\PopUpTarget.sqf""";
    };
    
    // Force recon specials.
    class FR_Miles
    {
        SLX_BIS = "(_this select 0) setIdentity ""Miles"";";
    };
    class FR_Cooper
    {
        SLX_BIS = "(_this select 0) setIdentity ""Cooper"";";
    };
    class FR_Sykes
    {
        SLX_BIS = "(_this select 0) setIdentity ""Sykes"";";
    };
    class FR_Ohara
    {
        SLX_BIS = "(_this select 0) setIdentity ""Ohara"";";
    };
    class FR_Rodriguez
    { 
        SLX_BIS = "(_this select 0) setIdentity ""Rodriguez"";";
    };
    
    // Buildings
    class Barrack2
    {
        SLX_BIS = "(_this select 0) setdir getdir (_this select 0)";
    };
    class Mass_grave
    {
        SLX_BIS = "dummy = _this execVM ""ca\characters2\OTHER\scripts\fly.sqf""";
    };
    
    // Logics
    class BIS_ARTY_Logic
    {
        SLX_BIS = "_script = _this execVM '\ca\modules\arty\data\scripts\init.sqf'";
    };
    class BIS_ARTY_Virtual_Artillery
    {
        SLX_BIS = "_script = _this execVM '\ca\modules\arty\data\scripts\ARTY_initVirtual.sqf'";
    };
    class Warfare
    {
        SLX_BIS = "if (IsNil {BIS_WF_Common}) then {BIS_WF_Common = _this select 0;Private [""_nullReturn""];_nullReturn = [false] ExecVM ""ca\Warfare2\Scripts\Init.sqf"";};";
    };
    class AlternativeInjurySimulation
    {
        SLX_BIS = "[] call (compile (preprocessFileLineNumbers (""\ca\Modules\MP\data\scripts\MPframework.sqf""))); _ok = _this execVM ""\ca\Modules\AIS\data\scripts\ISserverStartUsingLogic.sqf""";
    };
    class AliceManager
    {
        SLX_BIS = "if (isnil 'BIS_alice_mainscope') then {BIS_alice_mainscope = _this select 0; publicvariable 'BIS_alice_mainscope'; if (isServer) then {private [""_ok""];_ok = _this execVM ""ca\modules\alice\data\scripts\main.sqf""};};";
 
    };
    class AmbientCombatManager
    {
        SLX_BIS = "private [""_ok""]; _ok = (_this select 0) execVM ""ca\modules\ambient_combat\data\scripts\init.sqf""";
    };
    class BIS_animals_Logic
    {
        SLX_BIS = "_this execVM '\CA\Modules\Animals\Data\scripts\init.sqf'";
    };
    class BattleFieldClearance
    {
        SLX_BIS = "[] call (compile (preprocessFileLineNumbers (""\ca\Modules\MP\data\scripts\MPframework.sqf""))); _ok = _this execVM ""\ca\Modules\BC\data\scripts\BCserverStartUsingLogic.sqf""";
    };
    class BIS_clouds_Logic
    {
        SLX_BIS = "_this exec '\ca\modules\Clouds\data\scripts\BIS_CloudSystem.sqs'";
    };
    class ConstructionManager
    {
        SLX_BIS = "if (isServer) then {private [""_ok""];_ok = _this execVM ""ca\modules\coin\data\scripts\coin.sqf""};";
    };
    class FirstAidSystem
    {
        SLX_BIS = "[] call (compile (preprocessFileLineNumbers (""\ca\Modules\MP\data\scripts\MPframework.sqf""))); _ok = _this execVM ""\ca\Modules\FA\data\scripts\FAserverStartUsingLogic.sqf""";
    };
    class FunctionsManager
    {
        SLX_BIS = "debugLog format ['PRELOAD_ Functions\init %1', [_this, BIS_functions_mainscope]];     if (isnil 'BIS_functions_mainscope') then     { BIS_functions_mainscope = _this select 0;  if (isServer) then {_this execVM 'ca\modules\functions\main.sqf'};} else {_this spawn { debugLog format ['PRELOAD_ Functions\init  ERROR: deleting redundant FM! %1', [_this, (_this select 0), BIS_functions_mainscope]]; _mygrp = group (_this select 0); deleteVehicle (_this select 0); deleteGroup _mygrp;};};               if (isnil 'RE') then {[] execVM '\ca\Modules\MP\data\scripts\MPframework.sqf'};    ";
    };
    class PreloadManager
    {
        SLX_BIS ="onPreloadStarted {BIS_PRELOAD_ARRAY=[];debugLog format['PRELOAD_ Preload Manager - onPreloadStarted, _maxTime %1 timenow %2',_maxTime,time];startLoadingScreen[localize 'str_load_game','RscDisplayLoadMission'];};onPreloadFinished {    debugLog format['PRELOAD_  Preload Manager - onPreloadFinished T %1',time];    startLoadingScreen['','RscDisplayLoadMission'];    endLoadingScreen;            };    ";
    };
    class GarbageCollector
    {
        SLX_BIS = "private [""_ok""]; _ok = (_this select 0) execVM ""ca\modules\garbage_collector\data\scripts\init.sqf""";
    };
    class HighCommand
    {
        SLX_BIS = "if (isServer) then {if (isnil 'BIS_HC_mainscope') then {BIS_HC_mainscope = _this select 0; publicvariable 'bis_hc_mainscope'}; _ok = _this execVM '\ca\Modules\HC\data\scripts\hc.sqf'}; if (isnil 'RE') then {private [""_ok""]; _ok = [] execVM '\ca\Modules\MP\data\scripts\MPframework.sqf'}";
    };
    class MartaManager
    {
        SLX_BIS = "if (isnil 'BIS_marta_mainscope') then {BIS_marta_mainscope = _this select 0; if (isServer) then {private [""_ok""];_ok = _this execVM ""ca\modules\marta\data\scripts\main.sqf""}}; if (isnil 'RE') then {private [""_ok""]; _ok = [] execVM '\ca\Modules\MP\data\scripts\MPframework.sqf'};";
    };
    class SilvieManager
    {
        SLX_BIS = "if (isnil 'BIS_silvie_mainscope') then {BIS_silvie_mainscope = _this select 0; if (isServer) then {private [""_ok""];_ok = _this execVM ""ca\modules\silvie\data\scripts\main.sqf""};};";
    };
    class BIS_SRRS_Logic
    {
        SLX_BIS = "_ok = _this execVM '\ca\modules\srrs\data\scripts\init.sqf'";
    };
    class UAVManager
    {
        SLX_BIS = "if (isServer) then {private [""_ok""];_ok = _this execVM ""ca\modules\uav\data\scripts\uav.sqf""};";
    };
    class ZoraManager
    {
        SLX_BIS = "if (isnil 'BIS_Zora_mainscope') then {BIS_Zora_MainScope = _this select 0; if (isServer) then {private [""_ok""];_ok = _this execVM ""ca\modules\zora\data\scripts\main.sqf""};};";
    };
    class SecOpManager
    {
        SLX_BIS = "private [""_ok""]; _ok = (_this select 0) execVM ""ca\missions\som\data\scripts\init.sqf""";
    };
    class StrategicReferenceLayer
    {
        SLX_BIS = "private [""_ok""]; _ok = (_this select 0) execVM ""ca\modules\strat_layer\data\scripts\init.sqf""";
    };
};
class Extended_AnimChanged_EventHandlers {};
class Extended_AnimDone_EventHandlers {};
class Extended_Dammaged_EventHandlers {};
class Extended_Engine_EventHandlers {};
class Extended_Fired_EventHandlers
{
    class StaticCannon
    {
        // Stock BIS fired EH for the StaticCannon class
        SLX_BIS_StaticCannon_fired ="_this call BIS_Effects_EH_Fired";
    };
    
    class M252
    {
        SLX_BIS ="_this call BIS_Effects_EH_Fired;";
    };
    
    class 2b14_82mm
    {
        SLX_BIS ="_this call BIS_Effects_EH_Fired;";
    };
    
    class A10
    {
        SLX_BIS = "_this call BIS_Effects_EH_Fired;";
    };
    
    class Su34
    {
        SLX_BIS = "_this call BIS_Effects_EH_Fired;";
    };
};

class Extended_FiredNear_EventHandlers
{
    class CAAnimalBase
    {
        SLX_BIS_CAAnimalBase_firedNear = "_this execFSM'CA\animals2\Data\scripts\reactFire.fsm'";
    };
};
class Extended_Fuel_EventHandlers {};
class Extended_Gear_EventHandlers {};
class Extended_GetIn_EventHandlers {};
class Extended_GetOut_EventHandlers {};
class Extended_Hit_EventHandlers {};
class Extended_IncomingMissile_EventHandlers {};
class Extended_Killed_EventHandlers
{
    class A10
    {
        SLX_BIS = "_this call BIS_Effects_EH_Killed;";
    };
    
    class Su34
    {
        SLX_BIS = "_this call BIS_Effects_EH_Killed;";
    };
};
class Extended_LandedTouchDown_EventHandlers {};
class Extended_LandedStopped_EventHandlers {};
class Extended_HandleDamage_EventHandlers {};


class DefaultEventhandlers; // external - BIS default event handlers in ArmA 2

// Make event handler classes have the extended event handlers.
class CfgVehicles
{
    class All;
    class Air;
    class Animal;
    class LandVehicle;
    class Man;
    class Tracked_APC;
    class StaticWeapon;
    
    // Generic classes.
    class AllVehicles: All
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class CAAnimalBase: Animal
    {
         class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class CAManBase: Man
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class Car: LandVehicle
    {
        class EventHandlers : DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
    };
    class Helicopter: Air
    {
        class EventHandlers : DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
    };
    class Plane: Air
    {
        class EventHandlers : DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
    };
    /*
    class ParachuteBase: Helicopter
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    */
    class Ship: AllVehicles
    {
        class EventHandlers : DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
    };
    class StaticCannon: StaticWeapon
    {
         class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class Tank: LandVehicle
    {
        class EventHandlers : DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
    };
    
    // Vehicles.
    class AAV: Tracked_APC
    {
         class EventHandlers : DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
    };
    class A10 : Plane
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class Su34 : Plane
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class MQ9PredatorB;
    class CruiseMissile2 : MQ9PredatorB
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    
    // Static weapons.
    class StaticMortar;
    class 2b14_82mm : StaticMortar
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class M252 : StaticMortar
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    
    // Fires.
    class Land_Fire;
    class Land_Fire_burning : Land_Fire
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    
    class Land_Campfire;
    class Land_Campfire_burning : Land_Campfire
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    
    class Land_Fire_barrel;
    class Land_Fire_barrel_burning : Land_Fire_barrel
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    
    // Flag carriers
    class FlagCarrier;
    class FlagCarrierUSA : FlagCarrier
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class FlagCarrierCDF : FlagCarrierUSA
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class FlagCarrierRU : FlagCarrierUSA
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class FlagCarrierINS : FlagCarrierUSA
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class FlagCarrierGUE : FlagCarrierUSA
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    
    class FlagCarrierCore;
    class FlagCarrierChecked : FlagCarrierCore
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    
    // Popup targets
    class TargetBase;
    class TargetPopUpTarget : TargetBase
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class TargetEpopup : TargetBase
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    
    // Buildings
    class Land_Barrack2;
    class Barrack2 : Land_Barrack2
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    
    class Grave;
    class Mass_grave : Grave
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    
    // Logics
    class Logic;
    class BIS_ARTY_Logic : Logic
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class BIS_ARTY_Virtual_Artillery : Logic
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class Warfare : Logic
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class AlternativeInjurySimulation : Logic
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class AliceManager : Logic
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class AmbientCombatManager : Logic
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class BIS_animals_Logic : Logic
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class BattleFieldClearance : Logic
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class BIS_clouds_Logic : Logic
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class ConstructionManager : Logic
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class FirstAidSystem : Logic
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class FunctionsManager : Logic
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class PreloadManager : Logic
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class GarbageCollector : Logic
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class HighCommand : Logic
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class MartaManager : Logic
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class SilvieManager : Logic
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class BIS_SRRS_Logic : Logic
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class UAVManager : Logic
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class ZoraManager : Logic
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class SecOpManager : Logic
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class StrategicReferenceLayer : Logic
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    
    // Force Recon specials:
#define SLX_BIS_ForceRecon_EH \
    { \
        class EventHandlers : EventHandlers \
        { \
            HandleIdentity = "true"; \
            EXTENDED_EVENTHANDLERS \
        }; \
    }
    
    class SoldierWB;
    class FR_Base : SoldierWB
    {
        class EventHandlers { EXTENDED_EVENTHANDLERS };
    };
    
    class FR_Miles : FR_Base
    SLX_BIS_ForceRecon_EH;

    class FR_GL;
    class FR_Cooper : FR_GL
    SLX_BIS_ForceRecon_EH;

    class FR_Marksman;
    class FR_Sykes : FR_Marksman
    SLX_BIS_ForceRecon_EH;

    class FR_Corpsman;
    class FR_OHara : FR_Corpsman
    SLX_BIS_ForceRecon_EH;

    class FR_AR;
    class FR_Rodriguez : FR_AR
    SLX_BIS_ForceRecon_EH;
};


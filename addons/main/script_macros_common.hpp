/*
	Macros - By Sickboy <sb_at_dev-heaven.net>
*/

/* ****************************************************
 New - Should be exported to general addon
 Aim:
   - Simplify (shorten) the amount of characters required for repetitive tasks
   - Provide a solid structure that can be dynamic and easy editable (Which sometimes means we cannot adhere to Aim #1 ;-)
     An example is the path that is built from defines. Some available in this file, others in mods and addons.
 
 Follows  Standard:
   Object variables: PREFIX_COMPONENT
   Main-object variables: PREFIX_main
   Paths: MAINPREFIX\PREFIX\SUBPREFIX\COMPONENT\SCRIPTNAME.sqf
   e.g: x\six\addons\sys_menu\fDate.sqf
 
 Usage:
   define PREFIX and COMPONENT, then include this file
   (Note, you could have a main addon for your mod, define the PREFIX in a macros.hpp,
   and include this script_macros_common.hpp file.
   Then in your addons, add a component.hpp, define the COMPONENT,
   and include your mod's script_macros.hpp
   In your scripts you can then include the addon's component.hpp with relative path)
 
 TODO:
   - Try only to use 1 string type " vs '
   - Evaluate double functions, and simplification
   - Evaluate naming scheme; current = prototype
   - Evaluate "Debug" features..
   - Evaluate "create mini function per precompiled script, that will load the script on first usage, rather than on init"
   - Also saw "Namespace" typeName, evaluate which we need :P
   - Single/Multi player gamelogics? (Incase of MP, you would want only 1 gamelogic per component, which is pv'ed from server, etc)
 */
 
#ifndef CBA_MAIN_SCRIPT_MACROS_COMMON_INCLUDED
#define CBA_MAIN_SCRIPT_MACROS_COMMON_INCLUDED

#ifndef MAINPREFIX
	#define MAINPREFIX x
#endif

#ifndef SUBPREFIX
	#define SUBPREFIX addons
#endif

#ifndef MAINLOGIC
	#define MAINLOGIC main
#endif

// *************************************
// Internal Functions
#define DEFAULT_DEBUG_SETTINGS [false, true, false]
// TODO: Evaluate if you can use macros with #ifdef..
//#define DEBUG_SETTINGSS(var1) DEBUG_##var1##_SETTINGS
//#define DEBUGS(var1) DEBUG_##var1
//#define DEBUG_SETTINGS DEBUG_SETTINGSS(COMPONENT)
//#define DEBUG DEBUGS(COMPONENT)
#define DOUBLES(var1,var2) ##var1##_##var2
#define TRIPPLES(var1,var2,var3) ##var1##_##var2##_##var3
#define STR(var1) #var1
#define INC(var) var = (var) + 1
#define DEC(var) var = (var) - 1
#define ADD(var1,var2) var1 = var1 + var2
#define REM(var1,var2) var1 = var1 - var2
#define PUSH(var1,var2) var1 set [count var1, var2]
#define ISNILS(var1,var2) if (isNil #var1) then { ##var1 = ##var2 }
#define ISNILS2(var1,var2,var3,var4) ISNILS(TRIPPLES(var1,var2,var3),var4)
#define ISNILS3(var1,var2,var3) ISNILS(DOUBLES(var1,var2),var3)
#define ISNIL(var1,var2) ISNILS2(PREFIX,COMPONENT,var1,var2)
#define ISNILMAIN(var1,var2) ISNILS3(PREFIX,var1,var2)
// TODO: Evaluate using a single group for the logicCreation?
#define CREATELOGICS(var1,var2) ##var1##_##var2## = (createGroup sideLogic) createUnit ["LOGIC", [0, 0, 0], [], 0, "NONE"]
#define CREATELOGICLOCALS(var1,var2) ##var1##_##var2## = "LOGIC" createVehicleLocal [0, 0, 0]
#define CREATELOGICGLOBALS(var1,var2) ##var1##_##var2## = (createGroup sideLogic) createUnit ["LOGIC", [0, 0, 0], [], 0, "NONE"]; publicVariable STR(DOUBLES(var1,var2))
#define CREATELOGICGLOBALTESTS(var1,var2) ##var1##_##var2## = (createGroup sideLogic) createUnit [STR(TRIPPLES(PREFIX,COMPONENT,logic)), [0, 0, 0], [], 0, "NONE"];
#define GETVARS(var1,var2,var3) (##var1##_##var2 getVariable #var3)
#define GETVARMAINS(var1,var2) GETVARS(var1,MAINLOGIC,var2)
// TODO: Evaluate merging of different path functions...   .sqf  good to put in define?
#define PATHTOS(var1,var2,var3) MAINPREFIX\##var1\SUBPREFIX\##var2\##var3.sqf
#define PATHTOFS(var1,var2,var3) \MAINPREFIX\##var1\SUBPREFIX\##var2\##var3
#define COMPILEPREPROCESSS(var1,var2,var3) compile preProcessFileLineNumbers 'PATHTOS(var1,var2,var3)'
#define SETVARS(var1,var2) ##var1##_##var2 setVariable
#define SETVARMAINS(var1) SETVARS(var1,MAINLOGIC)
#define GVARS(var1,var2,var3) ##var1##_##var2##_##var3
#define GVARMAINS(var1,var2) ##var1##_##var2##
#define CFGSETTINGSS(var1,var2) configFile >> "CfgSettings" >> #var1 >> #var2
//#define SETGVARS(var1,var2,var3) ##var1##_##var2##_##var3 = 
//#define SETGVARMAINS(var1,var2) ##var1##_##var2 = 

// Direct file function
#define EXECFS(var1,var2,var3) execVM 'PATHTOS(var1,var2,var3)'
#define EXECFSTEST(var1,var2,var3) (_this select 0) execVM 'PATHTOS(var1,var2,var3)'
#define SPAWNFS(var1,var2,var3) spawn COMPILEPREPROCESSS(var1,var2,var3)
#define CALLFS(var1,var2,var3) call COMPILEPREPROCESSS(var1,var2,var3)
#define CALLFSTEST(var1,var2,var3) (_this select 0) call COMPILEPREPROCESSS(var1,var2,var3)

// Using a gameLogic
#define PREP_LOGIC(var1,var2,var3) GLOBALVARMAINS(var1,var2) setVariable ['##var3', COMPILEPREPROCESSS(var1,var2,var3)]
#define PREPMAIN_LOGIC(var1,var2,var3) ##var1##_MAINLOGIC setVariable ['##var3', COMPILEPREPROCESSS(var1,var2,var3)]
#define CALL_LOGIC(var1,var2,var3) call GETVARS(var1,var2,var3)
#define CALLMAIN_LOGIC(var1,var2) call GETVARMAINS(var1,var2)
#define SPAWN_LOGIC(var1,var2,var3) spawn GETVARS(var1,var2,var3)
#define SPAWNMAIN_LOGIC(var1,var2) spawn GETVARMAINS(var1,var2)

// Using globalVariables
#define PREP_GVAR(var1,var2,var3) ##var1##_##var2##_##var3 = COMPILEPREPROCESSS(var1,var2,var3)
#define PREPMAIN_GVAR(var1,var2,var3) ##var1##_##var3 = COMPILEPREPROCESSS(var1,var2,var3)
#define CALL_GVAR(var1,var2,var3) call ##var1##_##var2##_##var3
#define CALLMAIN_GVAR(var1,var3) call ##var1##_##var3
#define SPAWN_GVAR(var1,var2,var3) spawn ##var1##_##var2##_##var3
#define SPAWNMAIN_GVAR(var1,var2) spawn ##var1##_##var2

// *************************************
// User Functions
// Please define PREFIX and COMPONENT before including
#define ADDON DOUBLES(PREFIX,COMPONENT)
#define CFGSETTINGS CFGSETTINGSS(PREFIX,COMPONENT)
#define PATHTO(var1) PATHTOS(PREFIX,COMPONENT,var1)
#define PATHTOF(var1) PATHTOFS(PREFIX,COMPONENT,var1)
#define COMPILEPREPROCESS(var1) COMPILEPREPROCESSS(PREFIX,COMPONENT,var1)
#define GVAR(var1) GVARS(PREFIX,COMPONENT,var1)
#define GVARMAIN(var1) GVARMAINS(PREFIX,var1)
// TODO: What's this?
#define SETTINGS DOUBLES(PREFIX,settings)
#define CREATELOGIC CREATELOGICS(PREFIX,COMPONENT)
#define CREATELOGICGLOBAL CREATELOGICGLOBALS(PREFIX,COMPONENT)
#define CREATELOGICGLOBALTEST CREATELOGICGLOBALTESTS(PREFIX,COMPONENT)
#define CREATELOGICLOCAL CREATELOGICLOCALS(PREFIX,COMPONENT)
#define CREATELOGICMAIN CREATELOGICS(PREFIX,MAINLOGIC)
#define GETVAR(var1) GETVARS(PREFIX,COMPONENT,var1)
#define SETVAR SETVARS(PREFIX,COMPONENT)
#define SETVARMAIN SETVARMAINS(PREFIX)
#define IFCOUNT(var1,var2,var3) if (count ##var1 > ##var2) then { ##var3 = ##var1 select ##var2 };

#define EXECF(var1) EXECFS(PREFIX,COMPONENT,var1)
#define EXECFTEST(var1) EXECFSTEST(PREFIX,COMPONENT,var1)
#define SPAWNF(var1) SPAWNFS(PREFIX,COMPONENT,var1)
#define CALLF(var1) CALLFS(PREFIX,COMPONENT,var1)
#define CALLFTEST(var1) CALLFSTEST(PREFIX,COMPONENT,var1)

/*
// Using Gamelogic
#define PREP(var1) PREP_LOGIC(PREFIX,COMPONENT,var1)
#define PREPMAIN(var1) PREPMAIN_LOGIC(PREFIX,COMPONENT,var1)
#define CALL(var1) CALL_LOGIC(PREFIX,COMPONENT,var1)
#define CALLMAIN(var1) CALL_LOGIC(PREFIX,var1)
#define SPAWN(var1) SPAWN_LOGIC(PREFIX,COMPONENT,var1)
#define SPAWNMAIN(var1) SPAWN_LOGIC(PREFIX,var1)
*/

// Using GlobalVariables
#define PREP(var1) PREP_GVAR(PREFIX,COMPONENT,var1)
#define PREPMAIN(var1) PREPMAIN_GVAR(PREFIX,COMPONENT,var1)
#define CALL(var1) CALL_GVAR(PREFIX,COMPONENT,var1)
#define CALLMAIN(var1) CALLMAIN_GVAR(PREFIX,var1)
#define SPAWN(var1) SPAWN_GVAR(PREFIX,COMPONENT,var1)
#define SPAWNMAIN(var1) SPAWNMAIN_GVAR(PREFIX,var1)

#endif


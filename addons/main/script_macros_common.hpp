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
#define ADD(var1,var2) var1 = (var1) + (var2)
#define REM(var1,var2) var1 = (var1) - (var2)
#define PUSH(var1,var2) var1 set [count (var1), var2]
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

// === Splitting an array into a number of variables ===
#define EXPLODE_2(X,A,B) \
	A = (X) select 0; B = (X) select 1
	
#define EXPLODE_3(X,A,B,C) \
	A = (X) select 0; B = (X) select 1; C = (X) select 2
	
#define EXPLODE_4(X,A,B,C,D) \
	A = (X) select 0; B = (X) select 1; C = (X) select 2; D = (X) select 3
	
#define EXPLODE_5(X,A,B,C,D,E) \
	EXPLODE_4(X,A,B,C,D); E = (X) select 4
	
#define EXPLODE_6(X,A,B,C,D,E,F) \
	EXPLODE_4(X,A,B,C,D); E = (X) select 4; F = (X) select 5
	
#define EXPLODE_7(X,A,B,C,D,E,F,G) \
	EXPLODE_4(X,A,B,C,D); E = (X) select 4; F = (X) select 5; G = (X) select 6
	
#define EXPLODE_8(X,A,B,C,D,E,F,G,H) \
	EXPLODE_4(X,A,B,C,D); E = (X) select 4; F = (X) select 5; G = (X) select 6; H = (X) select 7

// === Getting parameters passed to a code block (function) ===
#define PARAMS_1(A) \
	private 'A'; A = _this select 0
	
#define PARAMS_2(A,B) \
	private ['A', 'B']; EXPLODE_2(_this,A,B)
	
#define PARAMS_3(A,B,C) \
	private ['A', 'B', 'C']; EXPLODE_3(_this,A,B,C)
	
#define PARAMS_4(A,B,C,D) \
	private ['A', 'B', 'C', 'D']; EXPLODE_4(_this,A,B,C,D)
	
#define PARAMS_5(A,B,C,D,E) \
	private ['A', 'B', 'C', 'D', 'E']; EXPLODE_5(_this,A,B,C,D,E)
	
#define PARAMS_6(A,B,C,D,E,F) \
	private ['A', 'B', 'C', 'D', 'E', 'F']; EXPLODE_6(_this,A,B,C,D,E,F)
	
#define PARAMS_7(A,B,C,D,E,F,G) \
	private ['A', 'B', 'C', 'D', 'E', 'F', 'G']; EXPLODE_7(_this,A,B,C,D,E,F,G)
	
#define PARAMS_8(A,B,C,D,E,F,G,H) \
	private ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']; EXPLODE_8(_this,A,B,C,D,E,F,G,H)
	
#define DEFAULT_PARAM(INDEX,NAME,DEF_VALUE) \
private #NAME; \
NAME = if (isNil "_this") then \
{ \
	DEF_VALUE; \
} \
else \
{ \
	if ((count _this) > (INDEX)) then \
	{ \
		if (isNil {_this select (INDEX)}) then \
		{ \
			DEF_VALUE; \
		} \
		else \
		{ \
			_this select (INDEX); \
		}; \
	} \
	else \
	{ \
		DEF_VALUE; \
	}; \
}

// === Debugging ===

#define DEBUG_ENABLED

#ifdef THIS_FILE
#define THIS_FILE_ 'THIS_FILE'
#else
#define THIS_FILE_ __FILE__
#endif

#define LOG(TEXT) [THIS_FILE_, __LINE__, TEXT] call CBA_fnc_log
#define ERROR(TEXT) [THIS_FILE_, __LINE__, TEXT, TITLE] call CBA_fnc_error

//#ifdef DEBUG_ENABLED

// === TRACING ===
// Trace with just a simple message.
#define TRACE(TEXT) LOG(TEXT)

// Trace with a message and 1-8 variables to show.
#define TRACE_1(TEXT,A) \
	[THIS_FILE_, __LINE__, format ['%1: A=%2', TEXT, A]] call CBA_fnc_log
	
#define TRACE_2(TEXT,A,B) \
	[THIS_FILE_, __LINE__, format ['%1: A=%2, B=%3', TEXT, A, B]] call CBA_fnc_log
	
#define TRACE_3(TEXT,A,B,C) \
	[THIS_FILE_, __LINE__, format ['%1: A=%2, B=%3, C=%4', TEXT, A, B, C]] call CBA_fnc_log
	
#define TRACE_4(TEXT,A,B,C,D) \
	[THIS_FILE_, __LINE__, format ['%1: A=%2, B=%3, C=%4, D=%5', TEXT, A, B, C, D]] call CBA_fnc_log
	
#define TRACE_5(TEXT,A,B,C,D,E) \
	[THIS_FILE_, __LINE__, format ['%1: A=%2, B=%3, C=%4, D=%5, E=%6', TEXT, A, B, C, D, E]] call CBA_fnc_log
	
#define TRACE_6(TEXT,A,B,C,D,E,F) \
	[THIS_FILE_, __LINE__, format ['%1: A=%2, B=%3, C=%4, D=%5, E=%6, F=%7', TEXT, A, B, C, D, E, F]] call CBA_fnc_log
	
#define TRACE_7(TEXT,A,B,C,D,E,F,G) \
	[THIS_FILE_, __LINE__, format ['%1: A=%2, B=%3, C=%4, D=%5, E=%6, F=%7, G=%8', TEXT, A, B, C, D, E, F, G]] call CBA_fnc_log
	
#define TRACE_8(TEXT,A,B,C,D,E,F,G,H) \
	[THIS_FILE_, __LINE__, format ['%1: A=%2, B=%3, C=%4, D=%5, E=%6, F=%7, G=%8, H=%9', TEXT, A, B, C, D, E, F, G, H]] call CBA_fnc_log

/*
#else // Debug mode off.
#define TRACE(TEXT)
#define TRACE_1(TEXT)
#define TRACE_2(TEXT)
#define TRACE_3(TEXT)
#define TRACE_4(TEXT)
#define TRACE_5(TEXT)
#define TRACE_6(TEXT)
#define TRACE_7(TEXT)
#define TRACE_8(TEXT)

#endif
*/

// === Assertion ===
#define ASSERTION_FAILED_TITLE "Assertion failed!"

// e.g ASSERT_TRUE(_frogIsDead,"The frog is alive");
#define ASSERT_TRUE(CONDITION,MESSAGE) \
if (not (CONDITION)) then \
{ \
	[THIS_FILE_, __LINE__, 'Assertion (CONDITION) failed!\n\n' + (MESSAGE), ASSERTION_FAILED_TITLE] call CBA_fnc_error; \
}

// e.g ASSERT_FALSE(_frogIsDead,"The frog died");
#define ASSERT_FALSE(CONDITION,MESSAGE) \
if (CONDITION) then \
{ \
	[THIS_FILE_, __LINE__, 'Assertion (not (CONDITION)) failed!\n\n' + (MESSAGE), ASSERTION_FAILED_TITLE] call CBA_fnc_error; \
}

// e.g ASSERT_OP(_fish,>,5,"Too few fish ;(");
#define ASSERT_OP(A,OP,B,MESSAGE) \
if (not ((A) OP (B))) then \
{ \
	[THIS_FILE_, __LINE__, 'Assertion (A OP B) failed!\n' + 'A: ' + (str (A)) + '\n' + 'B: ' + (str (B)) + "\n\n" + (MESSAGE), ASSERTION_FAILED_TITLE] call CBA_fnc_error; \
}

// e.g ASSERT_DEFINED(_anUndefinedVar,"Too few fish ;(");
#define ASSERT_DEFINED(VAR,MESSAGE) \
if (isNil VAR) then \
{ \
	[THIS_FILE_, __LINE__, 'Assertion (VAR is defined) failed!\n\n' + (MESSAGE), ASSERTION_FAILED_TITLE] call CBA_fnc_error; \
}

#define SCRIPT(NAME) \
#define THIS_FILE PREFIX\COMPONENT\NAME \
scriptName = 'PREFIX\COMPONENT\NAME'

#endif


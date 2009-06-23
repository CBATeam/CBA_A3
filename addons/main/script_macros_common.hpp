/*
	Header: script_macros_common.hpp
	
	Description:
		A general set of useful macro functions for use by CBA itself or by any module that uses CBA.
		
	Usage:
		These macros can be used in any SQF file by including this file at the top of the script:
		(begin example)
			#include "/x/cba/addons/main_common/script_macros_common.hpp"
		(end)

	Authors:
		Sickboy <sb_at_dev-heaven.net> and Spooner
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
 
#ifndef CBA_COMMON_SCRIPT_MACROS_COMMON_INCLUDED
#define CBA_COMMON_SCRIPT_MACROS_COMMON_INCLUDED

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
#define DEFAULT_DEBUGSETTINGS [false, true, false]
// TODO: Evaluate if you can use macros with #ifdef..
//#define DEBUGSETTINGSS(var1) DEBUG_##var1##
//#define DEBUGS(var1) DEBUG_##var1
//#define DEBUGSETTINGS DEBUGS(COMPONENT)
//#define DEBUG DEBUGS(COMPONENT)
#define DOUBLES(var1,var2) ##var1##_##var2
#define TRIPLES(var1,var2,var3) ##var1##_##var2##_##var3
#define QUOTE(var1) #var1
#define INC(var) var = (var) + 1
#define DEC(var) var = (var) - 1
#define ADD(var1,var2) var1 = (var1) + (var2)
#define SUB(var1,var2) var1 = (var1) - (var2)
#define REM(var1,var2) SUB(var1,var2)
#define PUSH(var1,var2) var1 set [count (var1), var2]
#define ISNILS(var1,var2) if (isNil #var1) then { ##var1 = ##var2 }
#define ISNILS2(var1,var2,var3,var4) ISNILS(TRIPLES(var1,var2,var3),var4)
#define ISNILS3(var1,var2,var3) ISNILS(DOUBLES(var1,var2),var3)
#define ISNIL(var1,var2) ISNILS2(PREFIX,COMPONENT,var1,var2)
#define ISNILMAIN(var1,var2) ISNILS3(PREFIX,var1,var2)
// TODO: Evaluate using a single group for the logicCreation?
#define CREATELOGICS(var1,var2) ##var1##_##var2## = (createGroup sideLogic) createUnit ["LOGIC", [0, 0, 0], [], 0, "NONE"]
#define CREATELOGICLOCALS(var1,var2) ##var1##_##var2## = "LOGIC" createVehicleLocal [0, 0, 0]
#define CREATELOGICGLOBALS(var1,var2) ##var1##_##var2## = (createGroup sideLogic) createUnit ["LOGIC", [0, 0, 0], [], 0, "NONE"]; publicVariable QUOTE(DOUBLES(var1,var2))
#define CREATELOGICGLOBALTESTS(var1,var2) ##var1##_##var2## = (createGroup sideLogic) createUnit [QUOTE(TRIPLES(PREFIX,COMPONENT,logic)), [0, 0, 0], [], 0, "NONE"];
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

#define DEPRECATE_SYS(OLD_PREFIX,OLD_FUNCTION,NEW_PREFIX,NEW_FUNCTION) \
	DOUBLES(OLD_PREFIX,OLD_FUNCTION) = { \
		WARNING('Deprecated function used: DOUBLES(OLD_PREFIX,OLD_FUNCTION) (new: DOUBLES(NEW_PREFIX,NEW_FUNCTION)) in ADDON'); \
		if (isNil "_this") then { call DOUBLES(NEW_PREFIX,NEW_FUNCTION) } else { _this call DOUBLES(NEW_PREFIX,NEW_FUNCTION) } }
		
#define DEPRECATE(OLD_FUNCTION,NEW_FUNCTION) DEPRICATE_SYS(PREFIX,OLD_FUNCTION,PREFIX,NEW_FUNCTION)

// Misspelled deprecation itself deprecated ;)
#define DEPRICATE_SYS(OLD_PREFIX,OLD_FUNCTION,NEW_PREFIX,NEW_FUNCTION) DEPRECATE_SYS(OLD_PREFIX,OLD_FUNCTION,NEW_PREFIX,NEW_FUNCTION)
#define DEPRICATE(OLD_FUNCTION,NEW_FUNCTION) DEPRECATE(OLD_FUNCTION,NEW_FUNCTION)

// Macro: OBSOLETE(OLD_FUNCTION,COMMAND_FUNCTION)
//	Replace an obsolete OLD_FUNCTION (which will have PREFIX_ prepended) with a simple
//	COMMAND_FUNCTION, with the intention that it will be replaced ASAP.
//	Shows a warning in RPT each time the obsolete function it is used.
//
// Example:
// 	(begin example)
//		OBSOLETE(fMyWeapon,{ currentWeapon player });
//	(end)
#define OBSOLETE_SYS(OLD_PREFIX,OLD_FUNCTION,COMMAND_FUNCTION) \
	DOUBLES(OLD_PREFIX,OLD_FUNCTION) = { \
		WARNING('Obsolete function used: DOUBLES(OLD_PREFIX,OLD_FUNCTION) (use: COMMAND_FUNCTION) in ADDON'); \
		if (isNil "_this") then { call COMMAND_FUNCTION } else { _this call COMMAND_FUNCTION } }
		
#define OBSOLETE(OLD_FUNCTION,COMMAND_FUNCTION) OBSOLETE_SYS(PREFIX,OLD_FUNCTION,COMMAND_FUNCTION)

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

// Macros: EXPLODE_*
//    Splitting an ARRAY into a number of variables.
//
//    EXPLODE_2(ARRAY,A,B) - Split a 2-element array into separate variables.
//    EXPLODE_3(ARRAY,A,B,C) - Split a 3-element array into separate variables.
//    EXPLODE_4(ARRAY,A,B,C,D) - Split a 4-element array into separate variables.
//    EXPLODE_5(ARRAY,A,B,C,D,E) - Split a 5-element array into separate variables.
//    EXPLODE_6(ARRAY,A,B,C,D,E,F) - Split a 6-element array into separate variables.
//    EXPLODE_7(ARRAY,A,B,C,D,E,F,G) - Split a 7-element array into separate variables.
//    EXPLODE_8(ARRAY,A,B,C,D,E,F,G,H) - Split a 8-element array into separate variables.
#define EXPLODE_2(ARRAY,A,B) \
	A = (ARRAY) select 0; B = (ARRAY) select 1
	
#define EXPLODE_3(ARRAY,A,B,C) \
	A = (ARRAY) select 0; B = (ARRAY) select 1; C = (ARRAY) select 2
	
#define EXPLODE_4(ARRAY,A,B,C,D) \
	A = (ARRAY) select 0; B = (ARRAY) select 1; C = (ARRAY) select 2; D = (ARRAY) select 3
	
#define EXPLODE_5(ARRAY,A,B,C,D,E) \
	EXPLODE_4(ARRAY,A,B,C,D); E = (ARRAY) select 4
	
#define EXPLODE_6(ARRAY,A,B,C,D,E,F) \
	EXPLODE_4(ARRAY,A,B,C,D); E = (ARRAY) select 4; F = (ARRAY) select 5
	
#define EXPLODE_7(ARRAY,A,B,C,D,E,F,G) \
	EXPLODE_4(ARRAY,A,B,C,D); E = (ARRAY) select 4; F = (ARRAY) select 5; G = (ARRAY) select 6
	
#define EXPLODE_8(ARRAY,A,B,C,D,E,F,G,H) \
	EXPLODE_4(ARRAY,A,B,C,D); E = (ARRAY) select 4; F = (ARRAY) select 5; G = (ARRAY) select 6; H = (ARRAY) select 7

// Macros: PARAMS_*
//   Setting variables based on parameters passed to a function.
//
//    PARAMS_1(A) - Get 1 parameter from the _this array.
//    PARAMS_2(A,B) - Get 2 parameters from the _this array.
//    PARAMS_3(A,B,C) - Get 3 parameters from the _this array.
//    PARAMS_4(A,B,C,D) - Get 4 parameters from the _this array.
//    PARAMS_5(A,B,C,D,E) - Get 5 parameters from the _this array.
//    PARAMS_6(A,B,C,D,E,F) - Get 6 parameters from the _this array.
//    PARAMS_7(A,B,C,D,E,F,G) - Get 7 parameters from the _this array.
//    PARAMS_8(A,B,C,D,E,F,G,H) - Get 8 parameters from the _this array.
//
// Example:
// 	A function called like this:
// 	(begin example)
//		[_name,_address_telephone] call recordPersonalDetails;
//	 (end)
//	 expects 3 parameters and those variables could be initialised at the start of the function definition with:
//	 (begin example)
//		recordPersonalDetails = {
//			PARAMS_3(_name,_address,_telephone);
//			// Rest of function follows...
//		};
//	 (end)
#define PARAMS_1(A) \
	private '##A'; A = _this select 0
	
#define PARAMS_2(A,B) \
	private ['##A', '##B']; EXPLODE_2(_this,A,B)
	
#define PARAMS_3(A,B,C) \
	private ['##A', '##B', '##C']; EXPLODE_3(_this,A,B,C)
	
#define PARAMS_4(A,B,C,D) \
	private ['##A', '##B', '##C', '##D']; EXPLODE_4(_this,A,B,C,D)
	
#define PARAMS_5(A,B,C,D,E) \
	private ['##A', '##B', '##C', '##D', '##E']; EXPLODE_5(_this,A,B,C,D,E)
	
#define PARAMS_6(A,B,C,D,E,F) \
	private ['##A', '##B', '##C', '##D', '##E', '##F']; EXPLODE_6(_this,A,B,C,D,E,F)
	
#define PARAMS_7(A,B,C,D,E,F,G) \
	private ['##A', '##B', '##C', '##D', '##E', '##F', '##G']; EXPLODE_7(_this,A,B,C,D,E,F,G)
	
#define PARAMS_8(A,B,C,D,E,F,G,H) \
	private ['##A', '##B', '##C', '##D', '##E', '##F', '##G', '##H']; EXPLODE_8(_this,A,B,C,D,E,F,G,H)
	
// Macro: DEFAULT_PARAM(INDEX,NAME,DEF_VALUE) 
//	Getting a default function parameter. This may be used together with <PARAMS_*> to have a mix of required and
//     optional parameters.
//
// Example:
// 	A function called like this:
// 	( begin example)
//		[_name,_address_telephone] call myFunction;
// 	(end)
// 	expects 3 parameters and those variables could be initialised at the start of the function definition with:
// 	( begin example)
//		PARAMS_3(_name,_address_telephone);
// 	(end)
#define DEFAULT_PARAM(INDEX,NAME,DEF_VALUE) \
private '##NAME'; \
NAME = [_this, INDEX, DEF_VALUE] call CBA_fnc_defaultParam

// === Debugging ===

#define DEBUG_ENABLED

#ifdef THIS_FILE
#define THIS_FILE_ 'THIS_FILE'
#else
#define THIS_FILE_ __FILE__
#endif

// Macro: LOG(MESSAGE)
//	Log a timestamped message into the RPT log.
#define LOG(MESSAGE) [THIS_FILE_, __LINE__, MESSAGE] call CBA_fnc_log

// Macro: WARNING(MESSAGE)
//	Record a timestamped, non-critical error in the RPT log.
#define WARNING(MESSAGE) [THIS_FILE_, __LINE__, ('WARNING: ' + MESSAGE)] call CBA_fnc_log

// Macro: ERROR(TITLE,MESSAGE)
//	Record a timestamped, critical error in the RPT log. Newlines (\n) in the MESSAGE will be put on separate lines.
//
//	TODO: Popup an error dialog & throw an exception.
#define ERROR(TITLE,MESSAGE) \
	[THIS_FILE_, __LINE__, TITLE, MESSAGE] call CBA_fnc_error;

//#ifdef DEBUG_ENABLED

// Macros: TRACE_*
//	Log a message and 1-8 variables to the RPT log.
//
//    TRACE_1(MESSAGE,A) - Log 1 variable.
//    TRACE_2(MESSAGE,A,B) - Log 2 variables.
//    TRACE_3(MESSAGE,A,B,C) - Log 3 variables.
//    TRACE_4(MESSAGE,A,B,C,D) - Log 4 variables.
//    TRACE_5(MESSAGE,A,B,C,D,E) - Log 5 variables.
//    TRACE_6(MESSAGE,A,B,C,D,E,F) - Log 6 variables.
//    TRACE_7(MESSAGE,A,B,C,D,E,F,G) - Log 7 variables.
//    TRACE_8(MESSAGE,A,B,C,D,E,F,G,H) - Log 8 variables.
//
// Example:
//	 (begin example)
//		TRACE_3("After takeoff",_vehicle player,getPos (_vehicle player), getPosASL (_vehicle player));
//	 (end)
#define TRACE_1(MESSAGE,A) \
	[THIS_FILE_, __LINE__, format ['%1: ##A=%2', MESSAGE, A]] call CBA_fnc_log
	
#define TRACE_2(MESSAGE,A,B) \
	[THIS_FILE_, __LINE__, format ['%1: ##A=%2, ##B=%3', MESSAGE, A, B]] call CBA_fnc_log
	
#define TRACE_3(MESSAGE,A,B,C) \
	[THIS_FILE_, __LINE__, format ['%1: ##A=%2, ##B=%3, ##C=%4', MESSAGE, A, B, C]] call CBA_fnc_log
	
#define TRACE_4(MESSAGE,A,B,C,D) \
	[THIS_FILE_, __LINE__, format ['%1: ##A=%2, ##B=%3, ##C=%4, ##D=%5', MESSAGE, A, B, C, D]] call CBA_fnc_log
	
#define TRACE_5(MESSAGE,A,B,C,D,E) \
	[THIS_FILE_, __LINE__, format ['%1: ##A=%2, ##B=%3, ##C=%4, ##D=%5, ##E=%6', MESSAGE, A, B, C, D, E]] call CBA_fnc_log
	
#define TRACE_6(MESSAGE,A,B,C,D,E,F) \
	[THIS_FILE_, __LINE__, format ['%1: ##A=%2, ##B=%3, ##C=%4, ##D=%5, ##E=%6, ##F=%7', MESSAGE, A, B, C, D, E, F]] call CBA_fnc_log
	
#define TRACE_7(MESSAGE,A,B,C,D,E,F,G) \
	[THIS_FILE_, __LINE__, format ['%1: ##A=%2, ##B=%3, ##C=%4, ##D=%5, ##E=%6, ##=%7, ##G=%8', MESSAGE, A, B, C, D, E, F, G]] call CBA_fnc_log
	
#define TRACE_8(MESSAGE,A,B,C,D,E,F,G,H) \
	[THIS_FILE_, __LINE__, format ['%1: ##A=%2, ##B=%3, ##C=%4, ##D=%5, ##E=%6, ##F=%7, ##G=%8, ##H=%9', MESSAGE, A, B, C, D, E, F, G, H]] call CBA_fnc_log

/*
#else // Debug mode off.
#define TRACE_1(MESSAGE)
#define TRACE_2(MESSAGE)
#define TRACE_3(MESSAGE)
#define TRACE_4(MESSAGE)
#define TRACE_5(MESSAGE)
#define TRACE_6(MESSAGE)
#define TRACE_7(MESSAGE)
#define TRACE_8(MESSAGE)

#endif
*/

// === Assertion ===
#define ASSERTION_FAILED_TITLE "Assertion failed!"

// Macro: ASSERT_TRUE(CONDITION,MESSAGE)
//	Asserts that a CONDITION if true. When an assertion fails, an error is raised with the given MESSAGE.
//
// Example:
// (begin example)
// 	ASSERT_TRUE(_frogIsDead,"The frog is alive");
// (end)
#define ASSERT_TRUE(CONDITION,MESSAGE) \
if (not (CONDITION)) then \
{ \
	ERROR(ASSERTION_FAILED_TITLE,'Assertion (##CONDITION) failed!\n\n' + (MESSAGE)); \
}

// Macro: ASSERT_FALSE(CONDITION,MESSAGE)
//	Asserts that a CONDITION if false. When an assertion fails, an error is raised with the given MESSAGE.
//
// Example:
// (begin example)
//	 ASSERT_FALSE(_frogIsDead,"The frog died");
// (end)
#define ASSERT_FALSE(CONDITION,MESSAGE) \
if (CONDITION) then \
{ \
	ERROR(ASSERTION_FAILED_TITLE,'Assertion (not (##CONDITION)) failed!\n\n' + (MESSAGE)) \
}

// Macro: ASSERT_OP(A,OPERATOR,B,MESSAGE)
//	Asserts that (A OPERATOR B) is true. When an assertion fails, an error is raised with the given MESSAGE.
//
// Example:
// (begin example)
// 	ASSERT_OP(_fish,>,5,"Too few fish!");
// (end)
#define ASSERT_OP(A,OPERATOR,B,MESSAGE) \
if (not ((A) OPERATOR (B))) then \
{ \
	ERROR(ASSERTION_FAILED_TITLE,'Assertion (##A ##OPERATOR ##B) failed!\n' + '##A: ' + (str (A)) + '\n' + '##B: ' + (str (B)) + "\n\n" + (MESSAGE)); \
}

// Macro: ASSERT_DEFINED(VAR,MESSAGE)
//	Asserts that a value is defined. When an assertion fails, an error is raised with the given MESSAGE..
//
// Examples:
// (begin example)
// 	ASSERT_DEFINED("_anUndefinedVar","Too few fish!");
// 	ASSERT_DEFINED({ obj getVariable "anUndefinedVar" },"Too many fish!");
// (end)
#define ASSERT_DEFINED(VAR,MESSAGE) \
if (isNil VAR) then \
{ \
	ERROR(ASSERTION_FAILED_TITLE,'Assertion (##VAR is defined) failed!\n\n' + (MESSAGE)); \
}

// Macros: IS_*
//	Checking the data types of variables.
//
//	IS_ARRAY(VAR) - Array
//	IS_BOOL(VAR) - Boolean
//	IS_BOOLEAN(VAR) - UI display handle(synonym for <IS_BOOL(VAR)>)
//	IS_CODE(VAR) - Code block (i.e a compiled function)
//	IS_CONFIG(VAR) - Configuration
//	IS_CONTROL(VAR) - UI control handle.
//	IS_DISPLAY(VAR) - UI display handle.
//	IS_FUNCTION(VAR) - A compiled function (synonym for <IS_CODE(VAR)>)
//	IS_GROUP(VAR) - Group.
//	IS_INTEGER(VAR) - Is a number a whole number?
//	IS_LOCATION(VAR) - World location.
//	IS_NUMBER(VAR) - A floating point number (synonym for <IS_SCALAR(VAR)>)
//	IS_OBJECT(VAR) - World object.
//	IS_SCALAR(VAR) - Floating point number.
//	IS_SCRIPT(VAR) - A script handle (as returned by execVM and spawn commands).
//	IS_SIDE(VAR) - Game side.
//	IS_STRING(VAR) - World object.
//	IS_TEXT(VAR) - Structured text.
#define IS_ARRAY(VAR)    ((typeName (VAR)) == "ARRAY")
#define IS_BOOL(VAR)     ((typeName (VAR)) == "BOOL")
#define IS_BOOLEAN(VAR)  IS_BOOL(VAR)
#define IS_CODE(VAR)     ((typeName (VAR)) == "CODE")
#define IS_CONFIG(VAR)   ((typeName (VAR)) == "CONFIG")
#define IS_CONTROL(VAR)  ((typeName (VAR)) == "CONTROL")
#define IS_DISPLAY(VAR)  ((typeName (VAR)) == "DISPLAY")
#define IS_FUNCTION(VAR) IS_CODE(VAR)
#define IS_GROUP(VAR)    ((typeName (VAR)) == "GROUP")
#define IS_INTEGER(VAR)  if { IS_SCALAR(VAR) } then { (floor(VAR) == (VAR)) } else { false }
#define IS_NUMBER(VAR)   IS_SCALAR(VAR)
#define IS_OBJECT(VAR)   ((typeName (VAR)) == "OBJECT")
#define IS_SCALAR(VAR)   ((typeName (VAR)) == "SCALAR")
#define IS_SCRIPT(VAR)   ((typeName (VAR)) == "SCRIPT")
#define IS_SIDE(VAR)     ((typeName (VAR)) == "SIDE")
#define IS_STRING(VAR)   ((typeName (VAR)) == "STRING")
#define IS_TEXT(VAR)     ((typeName (VAR)) == "TEXT")
#define IS_LOCATION(VAR) ((typeName (VAR)) == "LOCATION")

// Macro: SCRIPT(NAME)
//	Sets name of script (relies on PREFIX and COMPONENT values being #defined).
#define SCRIPT(NAME) \
scriptName 'PREFIX\COMPONENT\NAME'


#endif


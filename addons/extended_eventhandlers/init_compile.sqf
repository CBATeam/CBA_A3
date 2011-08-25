/*
  Compiles scripts into uiNamespace for caching purposes
  Occurs only once per game start.
  If you want to be able to recompile at every mission restart you will have to use CBA_RECOMPILE = true; very early.

  The function will compile into uiNamespace on first usage

  By Sickboy
*/

// #define DEBUG_MODE_FULL
#include "script_component.hpp"

private "_fnc_compile";

TRACE_1("Init Compile",_this);

if (isNil "CBA_COMPILE_RECOMPILE") then { CBA_FUNC_RECOMPILE = (!isNil "CBA_RECOMPILE" || getNumber(configFile >> "CfgSettings" >> "CBA" >> "caching" >> "compile") != 1) };

_fnc_compile = {
	private "_cba_int_code";
	// TODO: Unique namespace?
	_cba_int_code = uiNamespace getVariable _this;
	if (isNil '_cba_int_code' || CBA_COMPILE_RECOMPILE) then {
		TRACE_1('Compiling',_this);
		_cba_int_code = compile preProcessFileLineNumbers _this;
		uiNameSpace setVariable [_this, _cba_int_code];
	} else { TRACE_1('Retrieved from cache',_this) };

	_cba_int_code;
};

uiNamespace setVariable ["SLX_XEH_COMPILE", _fnc_compile];

// TMP BWC
SLX_XEH_COMPILE = _fnc_compile;

// Still run the code for this call if needed
if !(isNil "_this") then { _this call _fnc_compile };

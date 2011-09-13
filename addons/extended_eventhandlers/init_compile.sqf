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

_fnc_compile = {
	private ["_cba_int_code", "_recompile", "_isCached"];

	_recompile = if (isNil "CBA_COMPILE_RECOMPILE") then { 
		if (isNil "SLX_XEH_MACHINE" || isNil "CBA_isCached") then {
			true;
		} else {
			CBA_COMPILE_RECOMPILE = (CBA_isCached != (SLX_XEH_MACHINE select 11)) || CACHE_DIS(compile);
			CBA_COMPILE_RECOMPILE;
		};
	} else {
		CBA_COMPILE_RECOMPILE;
	};

	// TODO: Unique namespace?
	_cba_int_code = uiNamespace getVariable _this;
	_isCached = if (isNil "CBA_CACHE_KEYS") then { false } else { _this in CBA_CACHE_KEYS };
	if (isNil '_cba_int_code' || _recompile || !_isCached) then {
		TRACE_1('Compiling',_this);
		_cba_int_code = compile preProcessFileLineNumbers _this;
		uiNameSpace setVariable [_this, _cba_int_code];
		if (!_isCached && !isNil "CBA_CACHE_KEYS") then { PUSH(CBA_CACHE_KEYS,_this) };
	} else { TRACE_1('Retrieved from cache',_this) };

	_cba_int_code;
};

uiNamespace setVariable ["SLX_XEH_COMPILE", _fnc_compile];

// TMP BWC
SLX_XEH_COMPILE = _fnc_compile;

// Still run the code for this call if needed
if !(isNil "_this") then { _this call _fnc_compile };

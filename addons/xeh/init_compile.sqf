/*
  Compiles scripts into uiNamespace for caching purposes
  Occurs only once per game start.
  If you want to be able to recompile at every mission restart you will have to use CBA_RECOMPILE = true; very early.

  The function will compile into uiNamespace on first usage

  By Sickboy
*/

// #define DEBUG_MODE_FULL
#include "script_component.hpp"

// #define BENCHMARK // TODO: finalize
#ifdef BENCHMARK
	if (isNil "SLX_XEH_STR_BENCH") then { SLX_XEH_STR_BENCH = "private '_cba_int_time'; _cba_int_time = diag_tickTime; call (uiNamespace getVariable '%1'); diag_log [diag_frameNo, diag_tickTime, time, '%1', _cba_int_time, diag_tickTime - _cba_int_time]; if !(isNil '_ret') then { nil } else { _ret };" };
#endif

private "_fnc_compile";
TRACE_1("Init Compile",_this);

_fnc_compile = {
	private ["_cba_int_code", "_recompile", "_isCached"];

	_recompile = if (isNil "CBA_COMPILE_RECOMPILE") then {
		if (isNil "SLX_XEH_MACHINE" || isNil "CBA_isCached") then {
			true;
		} else {
			CBA_COMPILE_RECOMPILE = CACHE_DIS(compile);
			CBA_COMPILE_RECOMPILE;
		};
	} else {
		CBA_COMPILE_RECOMPILE;
	};

	// TODO: Unique namespace?
	_cba_int_code = uiNamespace getVariable _this;
	_isCached = if (isNil "CBA_CACHE_KEYS") then { false } else { !isMultiplayer || isDedicated || _this in CBA_CACHE_KEYS };
	if (isNil '_cba_int_code' || _recompile || !_isCached) then {
		TRACE_1('Compiling',_this);
#ifdef BENCHMARK
	// TODO: Fix
	//_cba_int_code = compile ("private ['_cba_int_time']; _cba_int_time = diag_tickTime; _ret = call {" + (preProcessFile _this) + format[";}; diag_log [diag_frameNo, diag_tickTime, time, '%1', _cba_int_time, diag_tickTime - _cba_int_time]; if (isNil '_ret') then { nil } else { _ret };", _this]);
	uiNamespace setVariable [_this, compile preProcessFileLineNumbers _this];
	_cba_int_code = compile format[SLX_XEH_STR_BENCH, _this];
#else
	_cba_int_code = compile preProcessFileLineNumbers _this;
	uiNamespace setVariable [_this, _cba_int_code];
#endif
		if (!_isCached && !isNil "CBA_CACHE_KEYS") then { PUSH(CBA_CACHE_KEYS,_this) };
	} else { TRACE_1('Retrieved from cache',_this) };

	_cba_int_code;
};

uiNamespace setVariable ["SLX_XEH_COMPILE", _fnc_compile];

SLX_XEH_COMPILE = _fnc_compile;

// Still run the code for this call if needed
if !(isNil "_this") then { _this call _fnc_compile };

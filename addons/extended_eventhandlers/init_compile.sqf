// #define DEBUG_MODE_FULL
#include "script_component.hpp"

private "_fnc_compile";

_fnc_compile = {
	// Compiles scripts into uiNameSpace for caching purposes
	// By Sickboy
	private "_cba_int_code";

	_cba_int_code = uiNamespace getVariable _this;
	if (isNil '_cba_int_code' || !isNil 'CBA_RECOMPILE') then {
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

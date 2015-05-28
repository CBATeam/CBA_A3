/*
  Compiles scripts into uiNamespace for caching purposes
  Occurs only once per game start.
  If you want to be able to recompile at every mission restart you will have to use CBA_RECOMPILE = true; very early.

  The function will compile into uiNamespace on first usage

  By Sickboy
*/

// #define DEBUG_MODE_FULL
#include "script_component.hpp"

TRACE_1("Init Compile",_this);

SLX_XEH_COMPILE = {
    (compile preprocessFileLineNumbers _this);
};

SLX_XEH_COMPILE_NEW = {
    private ["_cba_int_code", "_recompile", "_isCached", "_fncFile", "_fncName", "_compileStr"];
    _fncFile = _this select 0;
    _fncName = _this select 1;
    _recompile = if (isNil "CBA_COMPILE_RECOMPILE") then {
        if (isNil "SLX_XEH_MACHINE" || {isNil "CBA_isCached"}) then {
            true;
        } else {
            CBA_COMPILE_RECOMPILE = CACHE_DIS(compile);
            CBA_COMPILE_RECOMPILE;
        };
    } else {
        CBA_COMPILE_RECOMPILE;
    };
    // if(_recompile && {!(missionNamespace getVariable [QGVAR(cacheSecWarning), false])}) then {
        // missionNamespace setVariable [QGVAR(cacheSecWarning), true];
        // diag_log text "CBA FUNCTION CACHE WARNING: Recompiling is now disabled via missions due to security issues. Please #define DISABLE_COMPILE_CACHE in your addon before including CBA macros only during development to enable recompilation.";
    // };

    // TODO: Unique namespace?
    _cba_int_code = uiNamespace getVariable _fncName;
    if (isNil '_cba_int_code') then {
        TRACE_1('Compiling',_fncFile);

        missionNamespace setVariable [_fncName, (compileFinal preprocessFileLineNumbers _fncFile)];
        uiNamespace setVariable [_fncName, missionNamespace getVariable _fncName];
    } else {
        if(_recompile) then {
            missionNamespace setVariable [_fncName, (compileFinal preprocessFileLineNumbers _fncFile)];
        } else {
            missionNamespace setVariable [_fncName, uiNamespace getVariable _fncName];
        };
    };
};

// Still run the code for this call if needed
if !(isNil "_this") then { _this call SLX_XEH_COMPILE_NEW };

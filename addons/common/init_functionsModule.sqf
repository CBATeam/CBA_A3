// Modified by Spooner for CBA in order to allow function initialisation
// in preinit phase.

//#define DEBUG_MODE_FULL
#include "script_component.hpp"

scriptName "CBA\common\init_functionsModule";

// #define DO_NOT_STORE_IN_MISSION_NS

private ["_recompile"];
_recompile = (count _this) > 0;

if (CBA_FUNC_RECOMPILE) then { _recompile = true };

#ifdef DEBUG_MODE_FULL
	_timeStart = diag_tickTime;
	diag_log [diag_frameNo, diag_tickTime, time, "Initializing function module", _this, _recompile, CBA_FUNC_RECOMPILE];
#endif


//--- Functions are already running
if (BIS_fnc_init && !_recompile) exitWith {};


//-----------------------------------------------------------------------------
//--- PREPROCESS --------------------------------------------------------------
//-----------------------------------------------------------------------------

// TODO: HeaderType etc.

//--- Create variables for all functions (and preprocess them after first call)
_pathConfigs = [configfile,campaignconfigfile,missionconfigfile];
for "_t" from 0 to 2 do {
	_pathConfig = _pathConfigs select _t;
	_pathFile = ["a3\functions_f","functions","functions"] select _t;

	_cfgFunctions = (_pathConfig >> "cfgfunctions");
	if (isText(_cfgFunctions >> "file")) then { _pathFile = getText(_cfgFunctions >> "file")};

	for "_c" from 0 to (count _cfgFunctions - 1) do {
		_currentTag = _cfgFunctions select _c;

		//--- Is Tag
		if (isclass _currentTag) then {
			_tagName = configname _currentTag;
			_itemPathTag = gettext (_currentTag >> "file");

			#ifdef DEBUG_MODE_FULL
				diag_log [_tagName, _itemPathTag];
			#endif

			for "_i" from 0 to (count _currentTag - 1) do {
				_currentCategory = _currentTag select _i;

				//--- Is Category
				if (isclass _currentCategory) then {

					_categoryName = configname _currentCategory;
					_itemPathCat = gettext (_currentCategory >> "file");
					#ifdef DEBUG_MODE_FULL
						diag_log [_categoryName,_itemPathCat];
					#endif

					for "_n" from 0 to (count _currentCategory - 1) do {
						_currentItem = _currentCategory select _n;

						//--- Is Item
						if (isclass _currentItem) then {
							_itemName = configname _currentItem;
							_itemPathItem = gettext (_currentItem >> "file");
							_itemExt = gettext (_currentItem >> "ext");
							if (_itemExt == "") then {_itemExt = ".sqf"};

							_itemPath = if (_itemPathItem != "") then {_itemPathItem} else {
								if (_itemPathCat != "") then {_itemPathCat + "\fn_" + _itemName + _itemExt} else {
									if (_itemPathTag != "") then {_itemPathTag + "\fn_" + _itemName + _itemExt} else {""};
								};
							};
							_itemPath = if (_itemPath == "") then {_pathFile + "\" + _categoryName + "\fn_" + _itemName + _itemExt} else {_itemPath};
							#ifdef DEBUG_MODE_FULL
								diag_log [_itemName,_itemPathItem,_itemPath];
							#endif

							_fn = format["%1_fnc_%2", _tagName, _itemName];
							_uifn = uiNamespace getVariable _itemPath;
							_inCache = !isMultiplayer || isDedicated || _itemPath in CBA_CACHE_KEYS;
							if (isNil "_uifn" || _recompile || !_inCache) then {
								#ifdef DEBUG_MODE_FULL
									diag_log ["Compiling", _itemName,_itemPathItem,_itemPath];
								#endif
								_compiled = if (_itemExt == ".fsm") then { compile format ["_this execfsm '%1';",_itemPath] } else { compile preProcessFileLineNumbers _itemPath };
								uiNamespace setVariable [_itemPath, _compiled];
							};
							TRACE_1("BIS Function Name: ", _fn);
							missionNameSpace setVariable [format["%1_path", _fn], _itemPath];
							#ifdef DO_NOT_STORE_IN_MISSION_NS
								missionNameSpace setVariable [_fn, compile format["_this call (uiNamespace getVariable '%1')", _itemPath]];
							#else
								missionNameSpace setVariable [_fn, uiNamespace getVariable _itemPath];
							#endif

							if (!_inCache) then { PUSH(CBA_CACHE_KEYS,_itemPath) };
						};
					};
				};
			};
		};
	};
};

private ["_test", "_test2"];
_test = (_this select 0) setPos (position (_this select 0)); if (isnil "_test") then {_test = false};
_test2 = (_this select 0) playMove ""; if (isnil "_test2") then {_test2 = false};
if (_test || _test2) then {0 call COMPILE_FILE2(A3\functions_f\misc\fn_initCounter.sqf) };

//--------------------------------------------------------------------------------------------------------
//--- INIT COMPLETE --------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------
	
#ifdef DEBUG_MODE_FULL
	diag_log [diag_frameNo, diag_tickTime, time, diag_tickTime - _timeStart, "Function module done!"];
#endif

vmBFE = uiNamespace getVariable "BIS_fnc_areEqual";
if (isNil "vmBFE") then { diag_log "WARNING: BIS_fnc_areEqual (uiNamespace-1) is Nil"; diag_log vmBFE };
if (isNil "uiNamespace getVariable 'BIS_fnc_areEqual'") then { diag_log "WARNING: BIS_fnc_areEqual (uiNamespace-2) is Nil" };
if (isNil "BIS_fnc_areEqual") then { diag_log "WARNING: BIS_fnc_areEqual (missionNamespace) is Nil" };
TRACE_2("DebugBIS_fnc_areEqual Before", BIS_fnc_areEqual,  vmBFE);
BIS_fnc_areEqual = uiNamespace getVariable "BIS_fnc_areEqual";
TRACE_2("DebugBIS_fnc_areEqual After", BIS_fnc_areEqual, vmBFE);

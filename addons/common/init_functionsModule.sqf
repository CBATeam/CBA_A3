// Modified by Spooner for CBA in order to allow function initialisation
// in preinit phase.

// #define DEBUG_MODE_FULL
#include "script_component.hpp"

scriptName "CBA\common\init_functionsModule";

private ["_recompile"];
_recompile = (count _this) > 0;

#ifdef DEBUG_MODE_FULL
	diag_log [diag_frameNo, diag_tickTime, time, "Initializing function module", _this];
#endif


//--- Functions are already running
if (BIS_fnc_init && !_recompile) exitWith {};

//-----------------------------------------------------------------------------
//--- PREPROCESS --------------------------------------------------------------
//-----------------------------------------------------------------------------

//--- Create variables for all functions (and preprocess them after first call)
for "_t" from 0 to 2 do {
	_pathConfig = [configfile,campaignconfigfile,missionconfigfile] select _t;
	_pathFile = ["ca\modules\functions","functions","functions"] select _t;

	_cfgFunctions = (_pathConfig >> "cfgfunctions");
	for "_c" from 0 to (count _cfgFunctions - 1) do {
		_currentTag = _cfgFunctions select _c;

		//--- Is Tag
		if (isclass _currentTag) then {
			_tagName = configname _currentTag;
			_itemPathTag = gettext (_currentTag >> "file");

			for "_i" from 0 to (count _currentTag - 1) do {
				_currentCategory = _currentTag select _i;

				//--- Is Category
				if (isclass _currentCategory) then {

					_categoryName = configname _currentCategory;
					_itemPathCat = gettext (_currentCategory >> "file");

					for "_n" from 0 to (count _currentCategory - 1) do {
						_currentItem = _currentCategory select _n;

						//--- Is Item
						if (isclass _currentItem) then {

							_itemName = configname _currentItem;
							_itemPathItem = gettext (_currentItem >> "file");
							_itemPath = if (_itemPathItem != "") then {_itemPathItem} else {
								if (_itemPathCat != "") then {_itemPathCat + "\fn_" + _itemName + ".sqf"} else {
									if (_itemPathTag != "") then {_itemPathTag + "\fn_" + _itemName + ".sqf"} else {""};
								};
							};
							_itemPath = if (_itemPath == "") then {_pathFile + "\" + _categoryName + "\fn_" + _itemName + ".sqf"} else {_itemPath};

							_fn = format["%1_fnc_%2", _tagName, _itemName];
							if (isNil _fn || _recompile) then {
								missionNameSpace setVariable [_fn, compile preProcessFileLineNumbers _itemPath];
							};
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
if (_test || _test2) then {0 call (compile (preprocessFileLineNumbers "ca\modules\functions\misc\fn_initCounter.sqf"))};

//--------------------------------------------------------------------------------------------------------
//--- INIT COMPLETE --------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------
[] spawn {
	waitUntil {!isNil "BIS_MPF_InitDone"}; //functions init must be after MPF init
	BIS_fnc_init = true;
};

#ifdef DEBUG_MODE_FULL
	diag_log [diag_frameNo, diag_tickTime, time, "Function module done!"];
#endif


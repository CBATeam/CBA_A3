// Modified by Spooner for CBA in order to allow function initialisation
// in preinit phase.
scriptName "CBA\common\init_functionsModule";

private ["_recompile"];
_recompile = (count _this) > 0;

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
							call compile format ["
								if (isnil '%2_fnc_%3' || %4) then {
									%2_fnc_%3 = {
										if (!%4) then {debuglog ('Log: [Functions] %2_fnc_%3 loaded (%1)')};
										%2_fnc_%3 = compile preprocessFileLineNumbers '%1';
										_this call %2_fnc_%3;
									};
									%2_fnc_%3_path = '%1';
								};
							",_itemPath,_tagName,_itemName,_recompile];
						};
					};
				};
			};
		};
	};
};


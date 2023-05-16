/*
	Author: 
		Karel Moricky, improved by Killzone_Kid

	Description:
		Initialize displays during preStart or init GUI display and run its script
		The config class of the display is available in "BIS_fnc_initDisplay_configClass" stored on display
			Example: _display getVariable "BIS_fnc_initDisplay_configClass";
		Display is also stored in uiNamespace variable with config class name
			Example: uiNamespace getVariable "RscAvCamera";

	Parameter(s):
		ARRAY - [] init displays during preStart
		or
		0: STRING - mode, can be "onLoad" or "onUnload"
		1: ARRAY - params passed from "onLoad" or "onUnload" event handler, contains only DISPLAY
		2: STRING - display class
		3: STRING - script path from CfgScriptPaths

	Returns:
		NOTHING
*/

#define CONFIG_CLASS_VAR "BIS_fnc_initDisplay_configClass"
#define INIT_GAME_VAR "BIS_initGame"

// init displays during preStart (moved from BIS_fnc_initDisplays)
if (_this isEqualTo []) exitWith
{
	{
		{
			if (getNumber (_x >> "scriptIsInternal") isEqualTo 0) then //--- Ignore internal scripts, they're recompiled first time they're opened
			{ 
				_scriptName = getText (_x >> "scriptName");
				_scriptPath = getText (_x >> "scriptPath");
				
				if (_scriptName isEqualTo "" || _scriptPath isEqualTo "") exitWith 
				{
					[
						'Undefined param(s) [scriptPath: "%2", scriptName: "%3"] while trying to init display "%1"', 
						configName _x, 
						_scriptPath, 
						_scriptName
					] 
					call BIS_fnc_logFormat;
				};
				
				_script = _scriptName + "_script";
				
				if (uiNamespace getVariable [_script, 0] isEqualType {}) exitWith {}; //--- already compiled
				
				uiNamespace setVariable 
				[
					_script,
					compileScript [
						format ["%1%2.sqf", getText (configFile >> "CfgScriptPaths" >> _scriptPath), _scriptName],
						true, // final
						format ["scriptName '%1'; _fnc_scriptName = '%1'; ", _scriptName] // prefix
					]
				];
			};
		} 
		forEach ("isText (_x >> 'scriptPath')" configClasses _x);
	} 
	forEach
	[
		configFile,
		configFile >> "RscTitles",
		configFile >> "RscInGameUI",
		configFile >> "Cfg3DEN" >> "Attributes"
	];

	nil
};

//--- Register/unregister display
with uiNamespace do
{
	params 
	[
		["_mode", "", [""]],
		["_params", []],
		["_class", "", [""]],
		["_path", "default", [""]],
		["_register", true, [true, 0]]
	];

	_display = _params param [0, displayNull];
	if (isNull _display) exitWith {nil};

	if (_register isEqualType true) then {_register = parseNumber _register};
	if (_register > 0) then 
	{
		_varDisplays = _path + "_displays";
		_displays = (uiNamespace getVariable [_varDisplays, []]) - [displayNull];

		if (_mode == "onLoad") exitWith 
		{
			//--- Register current display
			_display setVariable [CONFIG_CLASS_VAR, _class];
			uiNamespace setVariable [_class, _display];
			
			_displays pushBackUnique _display;
			uiNamespace setVariable [_varDisplays, _displays];
			
			if !(uiNamespace getVariable [INIT_GAME_VAR, false]) then 
			{
				//--- tell loading screen it can stop using ARMA 3 logo which is shown only before main menu 
				//--- and start using the classic terrain picture
				uiNamespace setVariable [INIT_GAME_VAR, _path == "GUI" && {ctrlIdd _x >= 0} count _displays > 1];
			};
			
			[missionNamespace, "OnDisplayRegistered", [_display, _class]] call BIS_fnc_callScriptedEventHandler;
		};
		
		if (_mode == "onUnload") exitWith 
		{
			//--- Unregister current display
			_displays = _displays - [_display];
			uiNamespace setVariable [_varDisplays, _displays];
			
			[missionNamespace, "OnDisplayUnregistered", [_display, _class]] call BIS_fnc_callScriptedEventHandler;
		};
		
	};
	
	//--- Call script in public version
	if (!cheatsEnabled) exitWith 
	{
		[_mode, _params, _class] call (uiNamespace getVariable (_class + "_script"));
		nil
	};

	//--- Recompile in the internal version
	uinamespace setvariable 
	[
		_class + "_script",
		compileScript [
			format ["%1%2.sqf", getText (configFile >> "CfgScriptPaths" >> _path), _class],
			true, // final
			format ["scriptName '%1'; _fnc_scriptName = '%1'; ", _class] // prefix
		]
	];
	
	//--- Call script in internal version
	if !(uiNamespace getVariable ["BIS_disableUIscripts", false]) then 
	{
		[_mode, _params, _class] call (uiNamespace getVariable (_class + "_script"));
		nil
	};
};
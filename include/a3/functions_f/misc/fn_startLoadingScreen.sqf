/*
	Author: Karel Moricky

	Description:
	Register a loading screen. Start the loading when it's the first one registered.

	Parameter(s):
		0: STRING - screen ID, will be used in BIS_fnc_endLoadingScreen
		1 (Optional): STRING - loading screen layout

	Returns:
	BOOL - true when registered
*/
disableserialization;
with uinamespace do {
	private ["_id","_rsc","_ids"];
	_id = _this param [0,"",[""]];
	_text = _this param [1,"",[""]];
	_rsc = _this param [2,"",[""]];
	_ids = missionnamespace getvariable ["BIS_fnc_startLoadingScreen_ids",[]];

	if !(_id in _ids) then {
		//--- Array has to be adjusted before loading screen starts, otherwise the rest of the script can be delayed
		_ids set [count _ids,_id];
		missionnamespace setvariable ["BIS_fnc_startLoadingScreen_ids",_ids];
		startloadingscreen [_text,_rsc];
		progressloadingscreen (uinamespace getvariable ["BIS_fnc_progressloadingscreen_progress",0]);
		//["Start '%1' loading screen for %2",_id,profilename] call bis_fnc_logFormat;
		true
	} else {
		//["Loading screen '%1' already started.",_id] call bis_fnc_error;
		false
	};
};

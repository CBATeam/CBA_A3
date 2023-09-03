/*
	Author: Karel Moricky

	Description:
	Unregister a loading screen. When none other remains, end the loading.

	Parameter(s):
		0: STRING - screen ID, used in BIS_fnc_endLoadingScreen

	Returns:
	BOOL - true when unregistered
*/

with uinamespace do {
	private ["_id","_ids"];

	_id = _this param [0,"",[""]];
	_ids = missionnamespace getvariable ["BIS_fnc_startLoadingScreen_ids",[]];

	if (_id in _ids) then {
		_ids = _ids - [_id];
		missionnamespace setvariable ["BIS_fnc_startLoadingScreen_ids",_ids];
		if (count _ids == 0) then {
			endloadingscreen;
			-1 call bis_fnc_progressloadingscreen;
		};
		//["End '%1' loading screen for %2",_id,profilename] call bis_fnc_logFormat;
		true
	} else {
		["Loading screen '%1' did not start yet.",_id] call bis_fnc_error;
		false
	};
};
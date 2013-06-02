//diag_log [diag_tickTime, diag_frameno, time];
uiNamespace setVariable ["CBA_isCached", nil];

//is TKOH active
if (isClass(configFile/"CfgPatches"/"hsim_data_h")) then {
	["onLoad",_this,"RscDisplayMultiplayerSetup"] call compile preprocessFileLineNumbers "hsim\ui_h\scripts\init_GUI.sqf";
};
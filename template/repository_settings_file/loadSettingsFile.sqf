
// do nothing if auto loaded settings file is present
if (isClass (configFile >> "CfgPatches" >> "cba_auto_load_settings_file")) exitWith {};

private _source = ["client", "server"] select (isMultiplayer && isServer);
private _file = loadFile PATH_SETTINGS_FILE_PBO;

[_file, _source] call EFUNC(settings,import);
diag_log text "[CBA] (settings): Settings file loaded from PBO.";

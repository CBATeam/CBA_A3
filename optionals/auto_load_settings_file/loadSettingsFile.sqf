
if (isFilePatchingEnabled) then {
	private _source = ["client", "server"] select (isMultiplayer && isServer);

    [loadFile PATH_SETTINGS_FILE, _source] call FUNC(import);
    diag_log text "[CBA] (settings): Settings file loaded.";
} else {
    diag_log text "[CBA] (settings): Cannot load settings file. File patching disabled. Use -filePatching flag.";
};

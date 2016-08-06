
if (isFilePatchingEnabled) then {
    private _source = ["client", "server"] select (isMultiplayer && isServer);
    private _file = loadFile PATH_SETTINGS_FILE;

    if (_file != "") then {
        [_file, _source] call EFUNC(settings,import);
        diag_log text "[CBA] (settings): Settings file loaded.";
    } else {
        diag_log text "[CBA] (settings): Settings file not loaded. File empty or does not exist.";
    };
} else {
    diag_log text "[CBA] (settings): Cannot load settings file. File patching disabled. Use -filePatching flag.";
};

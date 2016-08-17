
if (isFilePatchingEnabled) then {
    private _source = ["client", "server"] select (isMultiplayer && isServer);
    private _info = loadFile PATH_SETTINGS_FILE;

    if (_info != "") then {
        _info = _info call EFUNC(settings,parse);

        {
            _x params ["_setting", "_value", "_force"];

            [_setting, _value, _force, _source] call EFUNC(settings,set);
        } forEach _info;

        diag_log text "[CBA] (settings): Settings file loaded.";
    } else {
        diag_log text "[CBA] (settings): Settings file not loaded. File empty or does not exist.";
    };
} else {
    diag_log text "[CBA] (settings): Cannot load settings file. File patching disabled. Use -filePatching flag.";
};

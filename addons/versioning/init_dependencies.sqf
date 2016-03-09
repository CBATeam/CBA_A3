
GVAR(versionsNamespace) = [] call CBA_fnc_createNamespace;
GVAR(dependenciesNamespace) = [] call CBA_fnc_createNamespace;

{
    private _prefix = configName _x;

    private _cfgPatches = if (isText (_x >> "main_addon")) then { getText (_x >> "main_addon") } else { format ["%1_main", _prefix] };
    private _cfgVersion = configFile >> "CfgPatches" >> _cfgPatches >> "versionAr";
    private _level = if (isNumber (_x >> "level")) then { getNumber (_x >> "level") } else { -1 };
    private _version = if (isArray _cfgVersion) then { [getArray _cfgVersion, _level] } else { [[0,0,0], 0] };

    GVAR(versionsNamespace) setVariable [_prefix, _version];

    private _cfgDependencies = _x >> "dependencies";

    if (isClass _cfgDependencies) then {
        private _dependencies = [];

        {
            _dependencies pushBack [configName _x, getArray _x];
        } forEach (configProperties [_cfgDependencies, "isArray _x"]);

        GVAR(dependenciesNamespace) setVariable [_prefix, _dependencies];
    };
} forEach ("true" configClasses (configfile >> "CfgSettings" >> "CBA" >> "Versioning"));

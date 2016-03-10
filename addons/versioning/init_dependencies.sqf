/* ----------------------------------------------------------------------------
Internal Function: init_dependencies

Description:
    Reads Versioning config.

Author:
    commy2
---------------------------------------------------------------------------- */

GVAR(versions) = [[], [[0,0,0], 0]] call CBA_fnc_hashCreate;
GVAR(dependencies) = [[], ["", [0,0,0], "true"]] call CBA_fnc_hashCreate;

{
    private _prefix = configName _x;

    private _cfgPatches = if (isText (_x >> "main_addon")) then { getText (_x >> "main_addon") } else { format ["%1_main", _prefix] };
    private _cfgVersion = configFile >> "CfgPatches" >> _cfgPatches >> "versionAr";
    private _level = if (isNumber (_x >> "level")) then { getNumber (_x >> "level") } else { -1 };
    private _version = if (isArray _cfgVersion) then { [getArray _cfgVersion, _level] } else { [[0,0,0], 0] };

    [GVAR(versions), _prefix, _version] call CBA_fnc_hashSet;

    private _cfgDependencies = _x >> "dependencies";

    if (isClass _cfgDependencies) then {
        private _dependencies = [];

        {
            _dependencies pushBack [configName _x, getArray _x];
        } forEach (configProperties [_cfgDependencies, "isArray _x"]);

        [GVAR(dependencies), _prefix, _dependencies] call CBA_fnc_hashSet;
    };
} forEach ("true" configClasses (configfile >> "CfgSettings" >> "CBA" >> "Versioning"));

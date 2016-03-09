#include "script_component.hpp"

with uiNamespace do {
    disableSerialization;

    params ["_display"];

    {
        private _addon = configName _x;
        private _addonFolder = configSourceMod _x;
        private _dependencies = getArray (_x >> "versionDependencies") select 0 select 0;

        {
            _x params ["_dependency", "_dependencyVersion", "_dependencyCondition"];

            if (isClass (configFile >> "CfgPatches" >> _dependency)) then {
                private _dependencyFolder = configSourceMod (configFile >> "CfgPatches" >> _dependency);
                private _dependencyVersionLocal = getArray (configFile >> "CfgPatches" >> _dependency >> "versionAr");

                private _valid = [_dependencyVersion, _dependencyVersionLocal] call CBA_fnc_compareVersions;

                if !(_valid) exitWith {
                    _dependencyVersion = "v" + (_dependencyVersion joinString ".");
                    _dependencyVersionLocal = "v" + (_dependencyVersionLocal joinString ".");

                    private _header = format ["Error: %1 is outdated.", _dependency, _dependencyFolder];
                    private _message = format ["%1 (Addon: %2) requires %3 %5 (Addon: %4). Current version: %6.", _addon, _addonFolder, _dependency, _dependencyFolder, _dependencyVersion, _dependencyVersionLocal];

                    [_header, _message, _display] call CBA_fnc_errorMessage;
                };
            };
        } forEach getArray (_x >> "versionDependencies");
    } forEach ("isArray (_x >> 'versionDependencies')" configClasses (configFile >> "CfgPatches"));
};

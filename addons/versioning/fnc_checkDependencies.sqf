/* ----------------------------------------------------------------------------
Function: CBA_fnc_checkDependencies

Description:
    Check dependency check and warn in case of mismatch.

Parameters:
    None

Returns:
    None

Author:
    Sickboy, commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(checkDependencies);

private _namespace = GVAR(dependenciesNamespace);

{
    private _prefix = _x;

    {
        _x params ["_dependency", "_dependencyInfo"];
        _dependencyInfo params ["_dependencyClass", "_dependencyVersion", "_dependencyCondition"];

        private _class = configFile >> "CfgPatches" >> _dependencyClass;
        private _dependencyVersionStr = format ["v%1", _dependencyVersion joinString "."];
        private _dependencyIsPresent = call compile format ["%1", _dependencyCondition];

        if (isNil "_dependencyIsPresent" || {!(_dependencyIsPresent isEqualType false)}) then {
            // https://dev.withsix.com/issues/74516 - The code could return non-bool, if "true" is converted to "1" durring binarization
            WARNING("Versioning conditional return is bad" + str _x);
            _dependencyIsPresent = true;
        };

        if (_dependencyIsPresent) then {
            if (!isClass _class) then {
                ["WARNING:", format ["%1 requires %2 (@%3) at version %4 (or higher). You have none.", _prefix, _dependencyClass, _dependency, _dependencyVersionStr], _display] call CBA_fnc_errorMessage;
            } else {
                if (!isArray (_class >> "versionAr")) then {
                    ["WARNING:", format ["%1 requires %2 (@%3) at version %4 (or higher). No valid version info found.", _prefix, _dependencyClass, _dependency, _dependencyVersionStr], _display] call CBA_fnc_errorMessage;
                } else {
                    private _localVersion = getArray (_class >> "versionAr");
                    private _localVersionStr = format ["v%1", _localVersion joinString "."];

                    if !([_dependencyVersion, _localVersion] call CBA_fnc_compareVersions) then {
                        ["WARNING:", format ["%1 requires %2 (@%3) at version %4 (or higher). You have: %5", _prefix, _dependencyClass, _dependency, _dependencyVersionStr, _localVersionStr], _display] call CBA_fnc_errorMessage;
                    };
                };
            };
        };
    } forEach (_namespace getVariable _prefix);
} forEach allVariables _namespace;

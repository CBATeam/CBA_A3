#include "script_component.hpp"

if (SLX_XEH_MACHINE select 1) exitWith {
    LOG("WARNING: YOUR MACHINE WAS DETECTED AS SERVER INSTEAD OF CLIENT!");
};

GVAR(versions_serv) = + GVAR(versions);     // For latest versions
GVAR(versions_server) = + GVAR(versions);   // For legacy versions

publicVariable QGVAR(versions_serv);
publicVariable QGVAR(versions_server); // TODO: Deprecate?

// Paranoid; yet pretty annoying gamebreaking issue :-)
QGVAR(versions_serv) addPublicVariableEventHandler {
    (_this select 1) call {
        diag_log [
            diag_frameNo, diag_tickTime, time, _this,
            "WARNING: Some client seems to have overriden the versions array; please report to CBA devs!"
        ];

        diag_log [GVAR(versions), GVAR(versions_serv)];

        if (isMultiplayer) then {
            GVAR(versions_serv) = + GVAR(versions);
            publicVariable QGVAR(versions_serv);
        };
    };
};

// Skip missing mod check if it is disabled.
if (getNumber (configFile >> "CBA_disableMissingModCheck") == 1) exitWith {};

// Missing Modfolder check
QGVAR(mismatch) addPublicVariableEventHandler {
    (_this select 1) call {
        params ["_machine", "_component"];

        private _msg = format ["%1 - Not running! (Machine: %2)", _component, _machine];
        [_msg, QUOTE(COMPONENT), [CBA_display_ingame_warnings, true, true]] call CBA_fnc_debug;
    };
};

private _components = [];

{
    private _config = configFile >> "CfgSettings" >> "CBA" >> "Versioning" >> _x;

    if (isClass _config && {isText (_config >> "main_addon")}) then {
        _components pushBack getText (_config >> "main_addon");
    } else {
        _components pushBack (_x + "_main");
    };
} forEach GVAR(versions_serv);

[[_components], {
    if (!hasInterface) exitWith {};
    params ["_components"];

    LOG("cba_versioning_check");

    if (isNil "CBA_display_ingame_warnings") then {
        CBA_display_ingame_warnings = true;
    };

    private _showError = {
        params ["_component"];

        sleep 2;
        GVAR(mismatch) = [format ["%2 (%1)", name player, player], _component];
        publicVariable QGVAR(mismatch);

        private _msg = format ["You are missing the following mod: %1", _component];
        diag_log text _msg;

        if (CBA_display_ingame_warnings) then {
            sleep 2;
            player globalChat _msg;
        };
    };

    {
        if (!isClass (configFile >> "CfgPatches" >> _x)) exitWith {
            _x spawn _showError;
        };
    } forEach _components;
}] remoteExecCall ["BIS_fnc_call"];

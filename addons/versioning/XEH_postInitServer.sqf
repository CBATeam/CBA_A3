#include "script_component.hpp"

if (SLX_XEH_MACHINE select 1) exitWith { LOG("WARNING: YOUR MACHINE WAS DETECTED AS SERVER INSTEAD OF CLIENT!") };

GVAR(versions_serv) = + GVAR(versions); // For latest versions
publicVariable QGVAR(versions_serv);

// Paranoid; yet pretty annoying gamebreaking issue :-) - @todo useless, remove?
QGVAR(versions_serv) addPublicVariableEventHandler {
    diag_log [diag_frameNo, diag_tickTime, time, _this select 1, "WARNING: Some client seems to have overriden the versions array; please report to CBA devs!"];
    diag_log [GVAR(versions), GVAR(version_serv)];

    if (isDedicated) then {
        GVAR(versions_serv) = GVAR(versions);
        publicVariable QGVAR(versions_serv);
    };
};

["handleMismatch", {
    params ["_machine", "_addon"];
    CBA_logic globalChat format ["%1 - Not running! (Machine: %2)", _machine, _addon];
}] call CBA_fnc_addEventHandler;





/*
// Missing Modfolder check
FUNC(handleMismatch) = {
    params ["_machine","_mod"];
    [format[, _mod, _machine], QUOTE(COMPONENT), [CBA_display_ingame_warnings, true, true]] call CBA_fnc_debug;
};

QGVAR(mismatch) addPublicVariableEventHandler { (_this select 1) call FUNC(handleMismatch) };
*/



private "_str";
_str = 'if(isServer)exitWith{};if (isNil "CBA_display_ingame_warnings") then { CBA_display_ingame_warnings = true; };LOG("cba_versioning_check");0 = objNull spawn { sleep 1; sleep 1; _func={GVAR(mismatch)=[format["%2 (%1)",name player, player],_this];publicVariable QGVAR(mismatch);_this spawn{_t=format["You are missing the following mod: %1",_this];diag_log text _t;sleep 2;if (CBA_display_ingame_warnings) then {player globalChat _t}}};';
[GVAR(versions_serv), {
    _cfg = (configFile >> "CfgSettings" >> "CBA" >> "Versioning" >> _key);
    _addon = if (isClass _cfg) then { if (isText (_cfg >> "main_addon")) then { getText (_cfg >> "main_addon") } else { _key + "_main" }; } else { _key + "_main" };
    // TODO: Make sensitive to level, if -2, do not check for mod
    _str = _str + format['if !(isClass(configFile >> "CfgPatches" >> "%1"))exitWith{"%1" call _func};', _addon];
}] call CBA_fnc_hashEachPair;
ADD(_str,"};");
(compile _str) remoteExecCall ["BIS_fnc_call", -2];

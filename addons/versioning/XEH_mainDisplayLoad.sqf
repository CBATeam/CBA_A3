#include "script_component.hpp"

with uiNamespace do {
    params ["_display"];

    #include "init_dependencies.sqf"

    // log versioning
    if !(SLX_XEH_DisableLogging) then {
        private _namespace = GVAR(versionsNamespace);
        private _messageAr = [];

        {
            (_namespace getVariable _x) params ["_versionAr"];

            // convert large numbers to readable strings
            _versionAr apply {_x call CBA_fnc_formatNumber};

            _messageAr pushBack format ["%1 v%2", _x, _versionAr joinString "."];
        } forEach allVariables _namespace;

        private _message = "CBA Versioning: " + (_messageAr joinString ", ");

        diag_log [diag_frameNo, diag_tickTime, time, _message];
    };

    // Dependency check and warn
    call CBA_fnc_checkDependencies;
};

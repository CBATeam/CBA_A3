#include "script_component.hpp"

params ["_display"];

with uiNamespace do {
    private _timeStart = diag_tickTime;
    if (call FUNC(preloadCurator)) then {
        INFO_1("Curator item list preloaded. Time: %1 ms",round ((diag_tickTime - _timeStart) * 1000));
    };
};

RscAttrbuteInventory_weaponAddons = uiNamespace getVariable QGVAR(curatorItemCache); // spelling is "Attrbute"

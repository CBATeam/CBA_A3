#include "script_component.hpp"

disableSerialization;

params ["_display"];

private _ctrl = _display displayCtrl 104;

if (ctrlText _ctrl == localize "STR_3DEN_RscDisplayInterrupt_ButtonAbort_3DEN_text") then {
    _ctrl ctrlAddEventHandler ["buttonClick", {uiNamespace setVariable [QGVAR(3denFix), true]}];
};

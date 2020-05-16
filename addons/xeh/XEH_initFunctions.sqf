#include "script_component.hpp"

SLX_XEH_DisableLogging = false;
XEH_LOG("Reading function cache.");

diag_log [uiNamespace getVariable [QGVAR(PREP_list), []]];
{
    XEH_LOG(ARR_2(format ["Read - %1", _x]));
    missionNamespace setVariable [_x, uiNamespace getVariable _x];
} forEach call (uiNamespace getVariable [QGVAR(PREP_list), {[]}]);

XEH_LOG("Done reading function cache.");

#include "\A3\functions_f\initFunctions.sqf"

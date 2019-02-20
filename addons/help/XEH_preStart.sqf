#include "script_component.hpp"

uiNamespace setVariable [
    QGVAR(creditsCache), "
        isText (_x >> 'author') &&
        {!(getText (_x >> 'author') in [localize 'STR_A3_Bohemia_Interactive', 'CFGPATCHES_AUTHOR', ''])}
    " configClasses (configFile >> "CfgPatches")
];

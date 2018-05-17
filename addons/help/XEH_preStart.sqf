#include "script_component.hpp"

PREP(setVersionLine);
PREP(setCreditsLine);

//Cache for CBA_help_fnc_setCreditsLine
if (!isClass (configFile >> "CfgPatches" >> "CBA_DisableCredits")) then {
    uiNamespace setVariable [QGVAR(creditsCache),  
        "isText (_x >> 'author') &&
        {getText (_x >> 'author') != localize 'STR_A3_Bohemia_Interactive'} &&
        {getText (_x >> 'author') != ''}
        " configClasses (configFile >> "CfgPatches");
    ];
};

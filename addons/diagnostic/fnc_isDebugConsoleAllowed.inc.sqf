#include "script_component.hpp"

// enable debug console in virtual arsenal
if (str missionConfigFile == "A3\Missions_F_Bootcamp\Scenarios\Arsenal.VR\description.ext") exitWith {true};
if (!isMultiplayer && {getNumber (missionConfigFile >> "enableDebugConsoleSP") == 1}) exitWith {true};

call {
    #include "\a3\functions_f\debug\fn_isDebugConsoleAllowed.sqf"
};

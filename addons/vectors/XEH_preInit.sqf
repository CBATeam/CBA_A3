#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.sqf"

// Since the following causes RPT spam of "Attempting to Override, we are no longer supporting this method of deprication code. -VM
// TODO: Update the existing CBA_vect functions to contain the same code as the their BIS_fnc_ equivalents. -VM
// DEPRECATE_SYS(DOUBLES(PREFIX,fnc_vectSubtract),BIS_fnc_vectorDiff);
// DEPRECATE_SYS(DOUBLES(PREFIX,fnc_vectCross),BIS_fnc_crossProduct);
// DEPRECATE_SYS(DOUBLES(PREFIX,fnc_vectDot),BIS_fnc_dotProduct);
// DEPRECATE_SYS(DOUBLES(PREFIX,fnc_vectMagn2D),BIS_fnc_magnitude);
// DEPRECATE_SYS(DOUBLES(PREFIX,fnc_vectMagn),BIS_fnc_magnitude);
// DEPRECATE_SYS(DOUBLES(PREFIX,fnc_vectAdd),BIS_fnc_vectorAdd);

// Announce initialization complete
ADDON = true;

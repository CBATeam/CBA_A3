#include "script_component.hpp"
SCRIPT(XEH_preInit);

ADDON = false;

DEPRECATE_SYS(DOUBLES(PREFIX,fnc_vectSubtract),BIS_fnc_vectorDiff);
DEPRECATE_SYS(DOUBLES(PREFIX,fnc_vectCross),BIS_fnc_crossProduct);
DEPRECATE_SYS(DOUBLES(PREFIX,fnc_vectDot),BIS_fnc_dotProduct);
DEPRECATE_SYS(DOUBLES(PREFIX,fnc_vectMagn2D),BIS_fnc_magnitude);
DEPRECATE_SYS(DOUBLES(PREFIX,fnc_vectMagn),BIS_fnc_magnitude);
DEPRECATE_SYS(DOUBLES(PREFIX,fnc_vectAdd),BIS_fnc_vectorAdd);

// Announce initialization complete
ADDON = true;

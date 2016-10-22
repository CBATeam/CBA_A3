#include "script_component.hpp"

#include "XEH_PREP.sqf"

PREP(initDisplayMain);

if (hasInterface) then {
    PREP(initDisplayGameOptions);
    PREP(initDisplayGameOptions_disabled);
    PREP(initDisplay3DEN);
} else {
    [displayNull] call FUNC(initDisplayMain);
};

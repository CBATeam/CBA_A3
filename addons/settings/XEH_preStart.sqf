#include "script_component.hpp"

#include "XEH_PREP.hpp"

PREP(initDisplayMain);

if (hasInterface) then {
    PREP(initDisplayGameOptions);
    PREP(initDisplay3DEN);
} else {
    [displayNull] call FUNC(initDisplayMain);
};

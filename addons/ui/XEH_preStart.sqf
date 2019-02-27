#include "script_component.hpp"

if (hasInterface) then {
    PREP(initDisplayInterrupt);
    PREP(initDisplayMultiplayerSetup);
    PREP(initDisplayOptionsLayout);
    PREP(initDisplayPassword);
    PREP(initDisplayRemoteMissions);

    // preload 3den and curator item lists
    PREP(preload3DEN);
    PREP(preloadCurator);

    private _timeStart = diag_tickTime;
    call FUNC(preload3DEN);
    INFO_1("3DEN item list preloaded. Time: %1 ms",round ((diag_tickTime - _timeStart) * 1000));

    _timeStart = diag_tickTime;
    call FUNC(preloadCurator);
    INFO_1("Curator item list preloaded. Time: %1 ms",round ((diag_tickTime - _timeStart) * 1000));
};

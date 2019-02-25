#include "script_component.hpp"

PREP(initDisplayInterrupt);
PREP(initDisplayMultiplayerSetup);
PREP(initDisplayOptionsLayout);
PREP(initDisplayPassword);
PREP(initDisplayRemoteMissions);

// preload 3den item list
PREP(preload3DEN);

private _timeStart = diag_tickTime;
call FUNC(preload3DEN);
INFO_1("3DEN item list preloaded. Time: %1 ms",(diag_tickTime - _timeStart) * 1000);

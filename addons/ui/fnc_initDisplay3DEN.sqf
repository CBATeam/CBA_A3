#include "script_component.hpp"

params ["_display"];

with uiNamespace do {
    private _timeStart = diag_tickTime;
    call FUNC(preload3DEN);
    INFO_1("3DEN item list preloaded. Time: %1 ms",round ((diag_tickTime - _timeStart) * 1000));
};

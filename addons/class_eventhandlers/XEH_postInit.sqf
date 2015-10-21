#include "script_component.hpp"
SCRIPT(XEH_postInit);

// main loop.

GVAR(allUnits) = [];
GVAR(allVehicles) = [];

[{
    if !(allUnits isEqualTo GVAR(allUnits)) then {
        private _objects = allUnits;
        _objects call FUNC(checkObjects);
        GVAR(allUnits) = _objects;
    };

    if !(vehicles isEqualTo GVAR(allVehicles)) then {
        private _objects = vehicles;
        _objects call FUNC(checkObjects);
        GVAR(allVehicles) = _objects;
    };
}, 0, []] call CBA_fnc_addPerFrameHandler;

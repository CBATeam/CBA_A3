#include "script_component.hpp"

[QGVAR(broadcastIdentity), {
    params ["_unit", "_identity"];

    _unit setIdentity _identity;
}] call FUNCMAIN(addEventHandler);

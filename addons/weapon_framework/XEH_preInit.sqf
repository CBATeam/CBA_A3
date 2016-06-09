#include "script_component.hpp"

LOG(MSG_INIT);

PREP(playweaponsound);
PREP(onFiredAction);
PREP(block_reloadaction);
PREP(unit_fired);

// Needs to run late
[] spawn
{
QGVAR(playsound) addPublicVariableEventHandler {_this spawn FUNC(playweaponsound)};
};
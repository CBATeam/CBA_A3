#include "script_component.hpp"
SCRIPT(XEH_preInit);

ADDON = false;

GVAR(isInit) = false;

PREP(init_loop);

ADDON = true;

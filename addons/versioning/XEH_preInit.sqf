#include "script_component.hpp"
SCRIPT(XEH_preInit);

LOG(MSG_INIT);

ADDON = false;

#include "init_dependencies.sqf"

if (isNil "CBA_display_ingame_warnings") then {
    CBA_display_ingame_warnings = true;
};

GVAR(mismatch) = []

ADDON = true;



/*
    Basic, Generic Version Checking System - By Sickboy <sb_at_dev-heaven.net>

*/

PREP(version_check);

#include "script_component.hpp"

ADDON = false;

GVAR(hints) = [];

#include "initSettings.sqf"

#include "XEH_PREP.sqf"

ADDON = true;

GVAR(hintLayer) = [QUOTE(SoundHints)] call BIS_fnc_rscLayer;

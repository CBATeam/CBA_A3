#include "script_component.hpp"

//See usage in XEH_preInit
private _cfgPatches = configFile >> "CfgPatches";
private _allComponents = "true" configClasses _cfgPatches apply {configName _x};
uiNamespace setVariable [QGVAR(addons), compileFinal str _allComponents];

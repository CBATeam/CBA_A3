#include "script_component.hpp"

//See usage in XEH_preInit
private _cfgPatches = configFile >> "CfgPatches";
private _allComponents = "true" configClasses _cfgPatches apply {configName _x};

//Filter out addons that don't have any units defined as we don't need to activate these
private _unitAddons = _allComponents select {
    !(getArray (_cfgPatches >> _x >> "units") isEqualTo [])
};

//Filter out addons defined in CfgAddons as they are always activated
private _allAddons = "true" configClasses (configFile >> "CfgAddons");
private _preloadedAddons = [];

{
    _preloadedAddons append getArray (_x >> "list");
} forEach _allAddons;

_unitAddons = _unitAddons - _preloadedAddons;

uiNamespace setVariable [QGVAR(addons), compileFinal str _allComponents];
uiNamespace setVariable [QGVAR(unitAddons), compileFinal str _unitAddons];

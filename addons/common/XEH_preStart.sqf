#include "script_component.hpp"

//See usage in XEH_preInit
private _cfgPatches = configFile >> "CfgPatches";
private _addonsFull = ("true" configClasses _cfgPatches) apply {configName _x};

//Filter out addons that don't have any units defined as we don't need to activate these
private _addonsSparse = _addonsFull select {
    !(getArray(_cfgPatches >> _x >> "units") isEqualTo [])
};

//Filter out addons defined in CfgAddons as they are always activated
private _cfgAddonsCategories = "true" configClasses (configFile >> "CfgAddons");

private _cfgAddonsMods = [];

{
    _cfgAddonsMods append (getArray (_x >> "list"));
} forEach _cfgAddonsCategories;

_addonsSparse = _addonsSparse - _cfgAddonsMods;

uiNamespace setVariable [QGVAR(addons), _addonsFull];
uiNamespace setVariable [QGVAR(addonsSparse), _addonsSparse];

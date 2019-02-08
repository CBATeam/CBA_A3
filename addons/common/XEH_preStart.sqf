#include "script_component.hpp"

//See usage in XEH_preInit
private _cfgPatches = configFile >> "CfgPatches";
private _addonsFull = ("true" configClasses _cfgPatches) apply {configName _x};

LOG("addonsFull: " + str count _addonsFull);

//Filter out addons that don't have any units defined as we don't need to activate these
private _addonsSparse = _addonsFull select {
    !(getArray(_cfgPatches >> _x >> "units") isEqualTo [])
};
LOG("addonsSparse1: " + str count _addonsSparse);

//Filter out addons defined in CfgAddons as they are always activated
private _cfgAddonsCategories = ("true" configClasses (configFile >> "CfgAddons"));

private _cfgAddonsMods = [];

{
    _cfgAddonsMods append (getArray (_x >> "list"));
} forEach _cfgAddonsCategories;

LOG("addonsMods: " + str count _cfgAddonsMods);

_addonsSparse = _addonsSparse - _cfgAddonsMods;

LOG("addonsSparse2: " + str count _addonsSparse);

uiNamespace setVariable [QGVAR(addons), _addonsFull];
uiNamespace setVariable [QGVAR(addonsSparse), _addonsSparse];
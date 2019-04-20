#include "script_component.hpp"

params ["_display"];

private _fnc_update = {
    params ["_display"];
    private _control = _display displayCtrl IDC_FG_SW_MAGAZINE;

    private _unit = call CBA_fnc_currentUnit;
    _control ctrlEnable isNil {GVAR(LoadedLaunchers) getVariable secondaryWeapon _unit};
};

_display displayAddEventHandler ["MouseMoving", _fnc_update];
_display displayAddEventHandler ["MouseHolding", _fnc_update];

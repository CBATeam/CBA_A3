#include "script_component.hpp"

params ["_display"];

private _fnc_update = {
    params ["_display"];
    private _control = _display displayCtrl IDC_FG_SW_MAGAZINE;

    _control ctrlEnable (!GVAR(replaceDisposableLauncher) || {!((secondaryWeapon call CBA_fnc_currentUnit) in GVAR(LoadedLaunchers))});
};

_display displayAddEventHandler ["MouseMoving", _fnc_update];
_display displayAddEventHandler ["MouseHolding", _fnc_update];

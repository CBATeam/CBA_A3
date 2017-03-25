#include "script_component.hpp"

params [["_display", findDisplay 46, [displayNull]]];

// hide diary (usually on players list)
if (ctrlIDD _display in [IDD_INTEL_GETREADY, IDD_SERVER_GET_READY, IDD_CLIENT_GET_READY]) then {
    (_display displayCtrl 1001) lnbSetCurSelRow 0;
};

private _dlgSettings = _display createDisplay "RscDisplayGameOptions";

// switch to custom addons tab now
private _ctrlConfigureAddons = _dlgSettings displayCtrl IDC_BTN_CONFIGURE_ADDONS;
_ctrlConfigureAddons call FUNC(gui_configure);

// and hide the button to switch back
_ctrlConfigureAddons ctrlEnable false;
_ctrlConfigureAddons ctrlShow false;

// then switch right to missions tab if in 3den
if (ctrlIDD _display isEqualTo 313) then {
    private _ctrlMissionButton = _dlgSettings displayCtrl IDC_BTN_MISSION;

    if (ctrlEnabled _ctrlMissionButton) then {
        _ctrlMissionButton call FUNC(gui_sourceChanged);
    };
};

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

// replace BI's broken OK button with our own to fix https://github.com/CBATeam/CBA_A3/issues/1027
private _ctrlScriptedOK = _dlgSettings displayCtrl 999;
_ctrlScriptedOK ctrlEnable false;
_ctrlScriptedOK ctrlShow false;

private _ctrlConfirm = _dlgSettings ctrlCreate ["RscButtonMenuOK", IDC_CANCEL];
_ctrlConfirm ctrlSetPosition ctrlPosition _ctrlScriptedOK;
_ctrlConfirm ctrlCommit 0;
_ctrlConfirm ctrlAddEventHandler ["ButtonClick", {call FUNC(gui_saveTempData)}];

// Add keyDown EH for search bar
GVAR(AddonSearchbarFocus) = false;

_dlgSettings displayAddEventHandler ["KeyDown", {call FUNC(gui_onKeyDown)}];
_dlgSettings displayAddEventHandler ["Unload", {
    GVAR(AddonSearchbarFocus) = nil;
}];

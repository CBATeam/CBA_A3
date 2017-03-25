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

// then switch right to missions tab
if (ctrlIDD _display == 313) then {
    private _ctrlMissionButton = _dlgSettings displayCtrl IDC_BTN_MISSION;

    if (ctrlEnabled _ctrlMissionButton) then {
        _ctrlMissionButton call FUNC(gui_sourceChanged);
    };
};

if (ctrlIDD _display in [IDD_INTEL_GETREADY, IDD_SERVER_GET_READY, IDD_CLIENT_GET_READY]) then {
    private _ctrlButtonCancel = _display displayCtrl IDC_CANCEL;
    private _ctrlButtonConfigure = _display displayCtrl IDC_BTN_CONFIGURE;

    _ctrlButtonCancel ctrlEnable false;
    _ctrlButtonCancel ctrlShow false;
    _ctrlButtonConfigure ctrlEnable false;
    _ctrlButtonConfigure ctrlShow false;

    [_dlgSettings, "unload", {
        _thisArgs params ["_display"];

        private _ctrlButtonCancel = _display displayCtrl IDC_CANCEL;
        private _ctrlButtonConfigure = _display displayCtrl IDC_BTN_CONFIGURE;

        _ctrlButtonCancel ctrlEnable true;
        _ctrlButtonCancel ctrlShow true;
        _ctrlButtonConfigure ctrlEnable true;
        _ctrlButtonConfigure ctrlShow true;
    }, [_display]] call CBA_fnc_addBISEventHandler;
};

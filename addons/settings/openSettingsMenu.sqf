#include "script_component.hpp"

params [["_display", findDisplay 46, [displayNull]]];

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
    _ctrlMissionButton call FUNC(gui_sourceChanged);
};

if (ctrlIDD _display in [37, 52, 53]) then {
    private _ctrlButtonCancel = _display displayCtrl 2;
    private _ctrlButtonSettings = _display displayCtrl IDC_BTN_SETTINGS;

    _ctrlButtonCancel ctrlEnable false;
    _ctrlButtonCancel ctrlShow false;
    _ctrlButtonSettings ctrlEnable false;
    _ctrlButtonSettings ctrlShow false;

    [_dlgSettings, "unload", {
        _thisArgs params ["_display"];

        private _ctrlButtonCancel = _display displayCtrl 2;
        private _ctrlButtonSettings = _display displayCtrl IDC_BTN_SETTINGS;

        _ctrlButtonCancel ctrlEnable true;
        _ctrlButtonCancel ctrlShow true;
        _ctrlButtonSettings ctrlEnable true;
        _ctrlButtonSettings ctrlShow true;
    }, [_display]] call CBA_fnc_addBISEventHandler;
};

#include "script_component.hpp"

params ["_display", "_key", "_shift", "_ctrl"];

private _block = false;

switch (_key) do {
    case DIK_NUMPADENTER;
    case DIK_RETURN: {
        if (GVAR(AddonSearchbarFocus)) then {
            [_display, _display displayCtrl IDC_ADDONS_SEARCHBAR] call FUNC(gui_addonList_handleSearchbar);
            _block = true;
        };
        if (GVAR(SettingSearchbarFocus)) then {
            //[_display, _display displayCtrl IDC_SETTINGS_SEARCHBAR] call FUNC(gui_setting_handleSearchbar);
            _block = true;
        };
    };
    // Focus search bars
    case DIK_F: {
        if (_ctrl) then {
            if (GVAR(AddonSearchbarFocus)) then {
                ctrlSetFocus (_display displayCtrl IDC_SETTINGS_SEARCHBAR);
            } else {
                ctrlSetFocus (_display displayCtrl IDC_ADDONS_SEARCHBAR);
            };
            _block = true;
        };
    };
};

_block

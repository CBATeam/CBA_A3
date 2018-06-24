#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_gui_saveTempData

Description:
    Saves temporary settings after closing the ingame settings editor.

Parameters:
    None

Returns:
    None

Author:
    commy2
---------------------------------------------------------------------------- */

{
    private _setting = _x;

    {
        private _source = _x;

        if (!isNil {GET_TEMP_NAMESPACE(_source) getVariable _setting}) then {
            (GET_TEMP_NAMESPACE(_source) getVariable _setting) params ["_value", "_priority"];

            if (isNil "_value") then {
                _value = [_setting, _source] call FUNC(get);
            };

            if (isNil "_priority") then {
                _priority = [_setting, _source] call FUNC(priority);
            };

            [_setting, _value, _priority, _source, true] call FUNC(set);
        };
    } forEach ["client", "mission", "server"];
} forEach GVAR(allSettings);

/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_isOverwritten

Description:
    Check if setting is overwritten by higher priority source.

Parameters:
    _setting - Name of the setting <STRING>
    _source  - Can be "client", "server" or "mission" (optional, default: "client") <STRING>

Returns:
    _overwritten - Whether or not the setting is overwritten <BOOLEAN>

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_setting", "", [""]], ["_source", "client", [""]]];

switch (toLower _source) do {
    case ("client"): {
        [_setting, "mission"] call FUNC(getForced) || {[_setting, "server"] call FUNC(getForced)}
    };
    case ("server"): {
        (!([_setting, "server"] call FUNC(getForced))) && {[_setting, "mission"] call FUNC(getForced)}
    };
    case ("mission"): {
        (!([_setting, "mission"] call FUNC(getForced))) || {[_setting, "server"] call FUNC(getForced)}
    };
    default {nil};
};

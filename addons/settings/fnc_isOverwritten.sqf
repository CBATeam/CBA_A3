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
        [_setting, "mission"] call FUNC(isForced) || {[_setting, "server"] call FUNC(isForced)}
    };
    case ("server"): {
        (!([_setting, "server"] call FUNC(isForced))) && {[_setting, "mission"] call FUNC(isForced)}
    };
    case ("mission"): {
        (!([_setting, "mission"] call FUNC(isForced))) || {[_setting, "server"] call FUNC(isForced)}
    };
    default {nil};
};

/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_getForced

Description:
    Check if setting is forced.

Parameters:
    _setting - Name of the setting <STRING>
    _source  - Can be "client", "mission" or "server" (optional, default: "client") <STRING>

Returns:
    _forced - Whether or not the setting is forced <BOOLEAN>

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_setting", "", [""]], ["_source", "client", [""]]];

switch (toLower _source) do {
    case "client": {
        GET_FORCED(clientSettings,_setting);
    };
    case "mission": {
        GET_FORCED(missionSettings,_setting);
    };
    case "server": {
        GET_FORCED(serverSettings,_setting) || {(!GET_FORCED(missionSettings,_setting)) && {(isMultiplayer && {NAMESPACE_GETVAR(GVAR(defaultSettings),_setting,[]) param [7, false]})}};
    };
    default {nil};
};

/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_parse

Description:
    Copy all setting info into clipboard.

Parameters:
    _info - Content of file or clipboard to parse. <STRING>

Returns:
    Settings with values and forced states. <ARRAY>

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

#define KEYWORD_FORCE "force"

// parses bool, number, string
private _fnc_parseAny = {
    parseSimpleArray format ["[%1]", _this] select 0
};

params [["_info", "", [""]]];

private _result = [];

{
    private _statement = _x;

    private _force = false;
    if ((_statement splitString toString WHITE_SPACE) param [0, ""] == KEYWORD_FORCE) then {
        _force = true;
        _statement = _statement select [(toLower _statement find KEYWORD_FORCE) + count KEYWORD_FORCE];
    };

    private _setting = (_statement select [0, _statement find "="]) call CBA_fnc_trim;

    if (_setting != "") then {
        private _currentValue = [_setting, "default"] call FUNC(get);

        if (isNil "_currentValue") then {
            ERROR_1("Error parsing settings file. Setting %1 does not exist.",str _setting);
        } else {
            private _value = (_statement select [(_statement find "=") + 1]) call CBA_fnc_trim call _fnc_parseAny;

            if ([_setting, _value] call FUNC(check)) then {
                _result pushBack [_setting, _value, _force];
            } else {
                ERROR_2("Error parsing settings file. Value %1 is invalid for setting %2.",_value,str _setting);
            };
        };
    };
} forEach (_info splitString ";");

_result

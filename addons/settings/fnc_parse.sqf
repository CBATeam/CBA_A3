/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_parse

Description:
    Convert settings in file format into array.

Parameters:
    _info     - Content of file or clipboard to parse. <STRING>
    _validate - Check if settings are valid. (optional, default: false) <BOOL>

Returns:
    Settings with values and priority states. <ARRAY>

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

// parses bool, number, string
private _fnc_parseAny = {
    parseSimpleArray format ["[%1]", _this] select 0
};

params [["_info", "", [""]], ["_validate", false, [false]]];

private _result = [];

{
    private _expression = _x splitString "=";

    if (count _expression isEqualTo 2) then {
        private _label = (_expression select 0) splitString WHITESPACE;
        if !(count _label in [1,2]) exitWith {};

        _label params ["_priority", "_setting"];

        if (isNil "_setting") then {
            _setting = _priority;
            _priority = "";
        };

        if (_priority == "force") then {
            _priority = 1;
        } else {
            _priority = round parseNumber _priority max 0 min 2;
        };

        // remove whitespace for _fnc_parseAny
        private _value = (_expression select 1) splitString WHITESPACE joinString "";

        // replace single quotes with "escaped" double quotes for _fnc_parseAny
        _value = [_value, "'", """"] call CBA_fnc_replace;

        if (_setting != "") then {
            if (_validate && {isNil {[_setting, "default"] call FUNC(get)}}) then {
                ERROR_1("Error parsing settings file. Setting %1 does not exist.",_setting);
            } else {
                _value = _value call _fnc_parseAny;

                if (_validate && {!([_setting, _value] call FUNC(check))}) then {
                    ERROR_2("Error parsing settings file. Value %1 is invalid for setting %2.",TO_STRING(_value),_setting);
                } else {
                    _result pushBack [_setting, _value, _priority];
                };
            };
        };
    };
} forEach (_info splitString ";");

_result

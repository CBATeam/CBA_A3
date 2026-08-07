#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_gui_getLiveEdits

Description:
    The display names of every setting that would actually change if the menu
    were saved right now.

    Touching a setting leaves an entry in its temp namespace whether or not the
    value ended up different, so presence is not the question. This compares, the
    same way a row's name colour does, and a setting put back where it started
    does not count.

    A setting changed in more than one source is named once, the list reads as
    settings rather than as changes.

Parameters:
    None

Returns:
    Display names, sorted <ARRAY of STRING>

Examples:
    (begin example)
        private _edits = call CBA_settings_fnc_gui_getLiveEdits;
    (end)

Author:
    LinkIsGrim
---------------------------------------------------------------------------- */

private _settings = [];

{
    private _source = _x;
    private _namespace = GET_TEMP_NAMESPACE(_source);

    if (isNull _namespace) then {continue};

    {
        private _setting = _x;

        if (_setting in _settings) then {continue};

        if (
            (GET_TEMP_NAMESPACE_VALUE_OR_CURRENT(_setting,_source)) isNotEqualTo ([_setting, _source] call FUNC(get))
            || {(GET_TEMP_NAMESPACE_PRIORITY_OR_CURRENT(_setting,_source)) isNotEqualTo ([_setting, _source] call FUNC(priority))}
        ) then {
            _settings pushBack _setting;
        };
    } forEach (allVariables _namespace);
} forEach ["client", "mission", "server"];

// Display names are localised at registration, so they are ready to show
private _names = _settings apply {(GVAR(default) getVariable _x) param [5, _x]};
_names sort true;

_names

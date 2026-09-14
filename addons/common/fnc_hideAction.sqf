#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_hideAction

Description:
    Registers or unregisters a hideActions entry for an action index and updates the current hidden state.
    See https://community.bistudio.com/wiki/shownAction for CfgAction enums.

Parameters:
    _index        - The action index. <NUMBER>
    _key          - The key (case-sensitive). <STRING>
    _hide         - Whether to hide the action. <BOOL>
    _forceRemove  - Force remove if all keys have been removed. (optional, default: false) <BOOL>
                    This can cause unexpected behavior if the action was hidden on a previous unit and the player switches back to it.

Returns:
    <ARRAY> [hiddenIndices, unhiddenIndices] or empty array if no changes were made.

Examples:
    (begin example)
        [15, "noEngineAction", true] call CBA_fnc_hideAction;
    (end)

Author:
    PabstMirror
---------------------------------------------------------------------------- */

if (!hasInterface) exitWith { [] };

params [["_index", 0, [0]], ["_key", "", [""]], ["_hide", false, [false]], ["_forceRemove", false, [false]]];

private _fnc_update = {
    private _hideSelected = [];
    private _unhideSelected = [];
    {
        if (count _y == 0) then {
            _unhideSelected pushBack _x;
        } else {
            _hideSelected pushBack _x;
        };
    } forEach GVAR(hideActionHash);
    hideActions [false, _unhideSelected];
    hideActions [true, _hideSelected];
    [_hideSelected, _unhideSelected] // final return
};

if (isNil QGVAR(hideActionHash)) then {
    GVAR(hideActionHash) = createHashMap;
    // need to update whenever the focusOn changes (player or UAV)
    addMissionEventHandler ["PlayerViewChanged", _fnc_update];
};

if (!_hide && {!(_index in (GVAR(hideActionHash)))}) exitWith { [] }; // index has never been set, just exit
private _actionIndex = GVAR(hideActionHash) getOrDefault [_index, createHashMap, true];
if (_hide) then {
    _actionIndex set [_key, true];
} else {
    _actionIndex deleteAt _key;
};

private _return = call _fnc_update;

if (_forceRemove && {(count _actionIndex) == 0}) then {
    GVAR(hideActionHash) deleteAt _index;
};

_return

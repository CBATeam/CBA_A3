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
    _forceAdd     - Force add (even if hide is false and action is not hidden). (optional, default: false) <BOOL>

Returns:
    [hiddenIndices, unhiddenIndices] <ARRAY>

Examples:
    (begin example)
        [15, "noEngineAction", true] call CBA_fnc_hideAction;
    (end)

Author:
    PabstMirror
---------------------------------------------------------------------------- */

if (!hasInterface || {(productVersion # 2) < 222}) exitWith { [[], []] };

params [["_index", 0, [0]], ["_key", "", [""]], ["_hide", false, [false]], ["_forceAdd", false, [false]]];

private _addEH = if (isNil QGVAR(hideActionHash)) then {
    GVAR(hideActionHash) = createHashMap;
    true
} else {
    false
};

if (_hide || _forceAdd || {_index in GVAR(hideActionHash)}) then {
    private _actionIndex = GVAR(hideActionHash) getOrDefault [_index, createHashMap, true];
    if (_hide) then {
        _actionIndex set [_key, true];
    } else {
        _actionIndex deleteAt _key;
    };
};

private _fnc_update = {
    private _hideSelected= [];
    private _unhideSelected = [];
    {
        if (count _y == 0) then {
            _unhideSelected pushBack _x;
        } else {
            _hideSelected pushBack _x;
        };
    } forEach GVAR(hideActionHash);
    call compile "
    hideActions [false, _unhideSelected];
    hideActions [true, _hideSelected];
    "; // adds soft 2.22 req, remove after release
    [_hideSelected, _unhideSelected] // final return
};

if (_addEH) then {
    // need to update whenever the focusOn changes (player or UAV)
    addMissionEventHandler ["PlayerViewChanged", _fnc_update];
};
call _fnc_update

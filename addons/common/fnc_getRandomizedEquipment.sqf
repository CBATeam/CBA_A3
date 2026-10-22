#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getRandomizedEquipment
Description:
    Gets a unit's randomized items.

Parameters:
    _unit  - Unit <OBJECT>

Returns:
    Array of randomized items <ARRAY>

Examples
    (begin example)
        player call CBA_fnc_getRandomizedEquipment
    (end)

Author:
    DartRuffian
---------------------------------------------------------------------------- */

params ["_unit"];
TRACE_1("fnc_getRandomizedEquipment",_unit);

CBA_common_randomLoadoutUnits getOrDefaultCall [typeOf _unit, {
    private _unitConfig = configOf _unit;
    private _primaryList = getArray (_unitConfig >> "CBA_primaryList");
    private _launcherList = getArray (_unitConfig >> "CBA_launcherList");
    private _handgunList = getArray (_unitConfig >> "CBA_handgunList");
    private _uniformList = getArray (_unitConfig >> "CBA_uniformList");
    private _vestList = getArray (_unitConfig >> "CBA_vestList");
    private _backpackList = getArray (_unitConfig >> "CBA_backpackList");
    private _headgearList = getArray (_unitConfig >> "CBA_headgearList");
    private _facewearList = getArray (_unitConfig >> "CBA_facewearList");
    private _binocularList = getArray (_unitConfig >> "CBA_binocularList");
    private _nvgList = getArray (_unitConfig >> "CBA_nvgList");

    // If all arrays are empty, just cache `[false]` to not save a bunch of empty arrays
    if (
        [
            _primaryList, _launcherList, _handgunList,
            _uniformList, _vestList, _backpackList,
            _headgearList, _facewearList, _binocularList,
            _nvgList
        ] findIf { _x isEqualTo [] } > -1
    ) then {
        [
            true, _primaryList, _launcherList,
            _handgunList, _uniformList, _vestList,
            _backpackList, _headgearList, _facewearList,
            _binocularList, _nvgList
        ]
    } else { [false] };
}, true];

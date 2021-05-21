#include "script_component.hpp"

if (!hasInterface) exitWith {};

#include "XEH_PREP.sqf"

[ELSTRING(common,WeaponsCategory), "MRT_SwitchItemNextClass_R", [LSTRING(railNext), LSTRING(railNext_tooltip)], {
    [1, "next"] call FUNC(switchAttachment) // return
}, {}, [DIK_L, [false, true, false]]] call CBA_fnc_addKeybind;

[ELSTRING(common,WeaponsCategory), "MRT_SwitchItemPrevClass_R", [LSTRING(railPrev), LSTRING(railPrev_tooltip)], {
    [1, "prev"] call FUNC(switchAttachment) // return
}, {}, [DIK_L, [true, false, false]]] call CBA_fnc_addKeybind;

[ELSTRING(common,WeaponsCategory), "MRT_SwitchItemNextClass_O", [LSTRING(opticNext), LSTRING(opticNext_tooltip)], {
    [2, "next"] call FUNC(switchAttachment) // return
}, {}, [DIK_SUBTRACT, [false, true, false]]] call CBA_fnc_addKeybind;

[ELSTRING(common,WeaponsCategory), "MRT_SwitchItemPrevClass_O", [LSTRING(opticPrev), LSTRING(opticPrev_tooltip)], {
    [2, "prev"] call FUNC(switchAttachment) // return
}, {}, [DIK_SUBTRACT, [true, false, false]]] call CBA_fnc_addKeybind;

[
    "##AccessoryPointer", "ALL", [LSTRING(railNext), LSTRING(railNext_tooltip)], nil, nil, {
        params ["", "", "_item"];
        count (_item call CBA_fnc_switchableAttachments) > 1 // return
    }, {
        [1, "next"] call FUNC(switchAttachment);
        false
    }
] call CBA_fnc_addItemContextMenuOption;

[
    "##AccessorySights", "ALL", [LSTRING(opticNext), LSTRING(opticNext_tooltip)], nil, nil, {
        params ["", "", "_item"];
        count (_item call CBA_fnc_switchableAttachments) > 1 // return
    }, {
        [2, "next"] call FUNC(switchAttachment);
        false
    }
] call CBA_fnc_addItemContextMenuOption;

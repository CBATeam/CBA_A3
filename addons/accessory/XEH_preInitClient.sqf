#include "script_component.hpp"

#include "XEH_PREP.sqf"

["CBA Accessory Functions", "MRT_SwitchItemNextClass_R", [LSTRING(railNext), LSTRING(railNext_tooltip)], {[1, "next"] call FUNC(switchAttachment)}, {}, [38, [false, true, false]]] call CBA_fnc_addKeybind; //default ctrl + L
["CBA Accessory Functions", "MRT_SwitchItemPrevClass_R", [LSTRING(railPrev), LSTRING(railPrev_tooltip)], {[1, "prev"] call FUNC(switchAttachment)}, {}, [38, [true, false, false]]] call CBA_fnc_addKeybind; //default shift + L
["CBA Accessory Functions", "MRT_SwitchItemNextClass_O", [LSTRING(opticNext), LSTRING(opticNext_tooltip)], {[2, "next"] call FUNC(switchAttachment)}, {}, [181, [false, true, false]]] call CBA_fnc_addKeybind; //default ctlr + NUM-/
["CBA Accessory Functions", "MRT_SwitchItemPrevClass_O", [LSTRING(opticPrev), LSTRING(opticPrev_tooltip)], {[2, "prev"] call FUNC(switchAttachment)}, {}, [181, [true, false, false]]] call CBA_fnc_addKeybind; //default shift + NUM-/

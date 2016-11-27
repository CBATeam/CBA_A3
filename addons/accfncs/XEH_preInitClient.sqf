#include "script_component.hpp"

PREP(switchAttachment);

["CBA Accessory Functions", "MRT_SwitchItemNextClass_R", [localize LSTRING(railNext),localize LSTRING(railNext_tooltip)], {[1,"next"] call FUNC(switchAttachment)}, {}, [38, [false, true, false]]] call cba_fnc_addKeybind; //default ctrl + L
["CBA Accessory Functions", "MRT_SwitchItemPrevClass_R", [localize LSTRING(railPrev),localize LSTRING(railPrev_tooltip)], {[1,"prev"] call FUNC(switchAttachment)}, {}, [38, [true, false, false]]] call cba_fnc_addKeybind; //default shift + L
["CBA Accessory Functions", "MRT_SwitchItemNextClass_O", [localize LSTRING(opticNext),localize LSTRING(opticNext_tooltip)], {[2,"next"] call FUNC(switchAttachment)}, {}, [181, [false, true, false]]] call cba_fnc_addKeybind; //default ctlr + NUM-/
["CBA Accessory Functions", "MRT_SwitchItemPrevClass_O", [localize LSTRING(opticPrev),localize LSTRING(opticPrev_tooltip)], {[2,"prev"] call FUNC(switchAttachment)}, {}, [181, [true, false, false]]] call cba_fnc_addKeybind; //default shift + NUM-/

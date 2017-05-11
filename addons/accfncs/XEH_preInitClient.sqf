#include "script_component.hpp"

PREP(switchAttachment);

["CBA Accessory Functions", "MRT_SwitchItemNextClass_R", ["Next rail item state", "Cycles to the next mode available for your rail slot attachment"], {[1,"next"] call FUNC(switchAttachment)}, {}, [38, [false, true, false]]] call cba_fnc_addKeybind; //default ctrl + L
["CBA Accessory Functions", "MRT_SwitchItemPrevClass_R", ["Prev rail item state", "Cycles to the previous mode available for your rail slot attachment"], {[1,"prev"] call FUNC(switchAttachment)}, {}, [38, [true, false, false]]] call cba_fnc_addKeybind; //default shift + L
["CBA Accessory Functions", "MRT_SwitchItemNextClass_O", ["Next optics state", "Cycles to the next mode available for your optics slot attachment"], {[2,"next"] call FUNC(switchAttachment)}, {}, [181, [false, true, false]]] call cba_fnc_addKeybind; //default ctlr + NUM-/
["CBA Accessory Functions", "MRT_SwitchItemPrevClass_O", ["Prev optics state", "Cycles to the previous mode available for your optics slot attachment"], {[2,"prev"] call FUNC(switchAttachment)}, {}, [181, [true, false, false]]] call cba_fnc_addKeybind; //default shift + NUM-/

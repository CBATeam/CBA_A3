#include "script_component.hpp"
#include "\a3\ui_f\hpp\defineDIKCodes.inc"

SCRIPT(XEH_preInit);

ADDON = false;

[LSTRING(QTEKeybindGroup), QGVAR(qteUpKey), ["↑", LSTRING(QTEKeybindUpTooltip)], {
    ["↑"] call CBA_fnc_keyPressedQTE // return
}, {}, [DIK_UP, [false, true, false]]] call CBA_fnc_addKeybind;

[LSTRING(QTEKeybindGroup), QGVAR(qteDownKey), ["↓", LSTRING(QTEKeybindDownTooltip)], {
    ["↓"] call CBA_fnc_keyPressedQTE // return
}, {}, [DIK_DOWN, [false, true, false]]] call CBA_fnc_addKeybind;

[LSTRING(QTEKeybindGroup), QGVAR(qteLeftKey), ["←", LSTRING(QTEKeybindLeftTooltip)], {
    ["←"] call CBA_fnc_keyPressedQTE // return
}, {}, [DIK_LEFT, [false, true, false]]] call CBA_fnc_addKeybind;

[LSTRING(QTEKeybindGroup), QGVAR(qteRightKey), ["→", LSTRING(QTEKeybindRightTooltip)], {
    ["→"] call CBA_fnc_keyPressedQTE // return
}, {}, [DIK_RIGHT, [false, true, false]]] call CBA_fnc_addKeybind;

ADDON = true;

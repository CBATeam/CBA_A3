#include "script_component.hpp"
#include "\a3\ui_f\hpp\defineDIKCodes.inc"

SCRIPT(XEH_preInit);

ADDON = false;

[ELSTRING(quicktime,QTEKeybindGroup), QGVAR(qteUpKey), ["↑", LSTRING(QTEKeybindUpTooltip)], {}, {
    ["↑"] call CBA_fnc_keyPressedQTE;
}, [DIK_UP, [false, true, false]]] call CBA_fnc_addKeybind;

[ELSTRING(quicktime,QTEKeybindGroup), QGVAR(qteDownKey), ["↓", LSTRING(QTEKeybindDownTooltip)], {}, {
    ["↓"] call CBA_fnc_keyPressedQTE;
}, [DIK_DOWN, [false, true, false]]] call CBA_fnc_addKeybind;

[ELSTRING(quicktime,QTEKeybindGroup), QGVAR(qteLeftKey), ["←", LSTRING(QTEKeybindLeftTooltip)], {}, {
    ["←"] call CBA_fnc_keyPressedQTE;
}, [DIK_LEFT, [false, true, false]]] call CBA_fnc_addKeybind;

[ELSTRING(quicktime,QTEKeybindGroup), QGVAR(qteRightKey), ["→", LSTRING(QTEKeybindRightTooltip)], {}, {
    ["→"] call CBA_fnc_keyPressedQTE;
}, [DIK_RIGHT, [false, true, false]]] call CBA_fnc_addKeybind;

ADDON = true;

PREPMAIN(getKeybind);
PREPMAIN(registerKeybind);
PREPMAIN(addKeybind);
PREPMAIN(registerKeybindToFleximenu);
PREPMAIN(addKeybindToFleximenu);
PREPMAIN(registerKeybindModPrettyName);
PREPMAIN(localizeKey);

if (hasInterface) then {
    PREP(initDisplayConfigure);

    PREP(gui_configure);
    PREP(gui_update);
    PREP(gui_editKey);
};

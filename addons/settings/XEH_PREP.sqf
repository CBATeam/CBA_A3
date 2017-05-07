
PREP(init);
PREP(set);
PREP(get);
PREP(check);
PREP(parse);
PREP(import);
PREP(export);
PREP(clear);
PREP(priority);

if (hasInterface) then {
    PREP(openSettingsMenu);
    PREP(gui_addonChanged);
    PREP(gui_sourceChanged);
    PREP(gui_configure);
    PREP(gui_refresh);
    PREP(gui_preset);
    PREP(gui_saveTempData);

    PREP(gui_settingCheckbox);
    PREP(gui_settingEditbox);
    PREP(gui_settingList);
    PREP(gui_settingSlider);
    PREP(gui_settingColor);
    PREP(gui_SettingDefault);
    PREP(gui_settingOverwrite);
};

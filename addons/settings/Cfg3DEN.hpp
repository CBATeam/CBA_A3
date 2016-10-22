
class Cfg3DEN {
    class Attributes {
        class Default;
        class CBA_CategoryHider: Default {
            onLoad = "(ctrlParentControlsGroup ctrlParentControlsGroup (_this select 0)) ctrlShow false";
        };
    };

    class Mission {
        class Scenario {
            class AttributeCategories {
                class GVAR(category) {
                    collapsed = 1;
                    displayName = "";

                    class Attributes {
                        class GVAR(hash) {
                            property = QGVAR(hash);
                            value = 0;
                            control = "CBA_CategoryHider";
                            displayName = "";
                            tooltip = "";
                            defaultValue = QUOTE(HASH_NULL);
                            expression = "";
                            wikiType = "[[Array]]";
                        };
                        class GVAR(hasSettingsFile) {
                            property = QGVAR(hasSettingsFile);
                            value = 0;
                            control = "CBA_CategoryHider";
                            displayName = "";
                            tooltip = "";
                            defaultValue = "false";
                            expression = "";
                            wikiType = "[[BOOL]]";
                        };
                    };
                };
            };
        };
    };
};

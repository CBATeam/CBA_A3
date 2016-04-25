
class Cfg3DEN {
    class Mission {
        class Scenario {
            class AttributeCategories {
                class Presentation { // any existing
                    class Attributes {
                        class BriefingName;
                        class Author; // needed, to put blank space at the end. for looks
                        class GVAR(hash) {
                            property = QGVAR(hash);
                            value = 0;
                            control = "Default"; // blank space. not editable by hand
                            displayName = "";
                            tooltip = "";
                            defaultValue = QUOTE(NULL_HASH);
                            expression = QUOTE(missionNamespace setVariable [ARR_3(QUOTE(QGVAR(hash)),_value,true)]);
                            wikiType = "[[Array]]";
                        };
                    };
                };
            };
        };
    };
};

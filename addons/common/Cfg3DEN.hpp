
class Cfg3DEN {
    class Group {
        class AttributeCategories {
            class Init {
                class Attributes {
                    class Callsign {
                        expression = QUOTE([ARR_2(_this,_value)] call FUNC(setCallsign));
                    };
                };
            };
        };
    };
};

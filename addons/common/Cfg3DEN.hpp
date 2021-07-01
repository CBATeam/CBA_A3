class ctrlCombo;

class Cfg3DEN {
    class Attributes {
        class Default;
        class Title: Default {
            class Controls;
        };

        class Date: Title {
            class Controls: Controls {
                class ValueYear: ctrlCombo {
                    onLoad = "\
                        params ['_ctrlYear'];\
                        for '_y' from 1900 to 2050 do {\
                            _ctrlYear lbSetValue [_ctrlYear lbAdd str _y, _y];\
                        };\
                        _ctrlYear lbSetCurSel 53;\
                    ";
                };
            };
        };
    };

    class Group {
        class AttributeCategories {
            class Init {
                class Attributes {
                    class Callsign {
                        expression = "\
                            if (isNil 'CBA_fnc_setCallsign') then {\
                                _this setGroupID [_value];\
                            } else {\
                                [_this, _value] call CBA_fnc_setCallsign;\
                            };\
                        ";
                    };
                };
            };
        };
    };
};

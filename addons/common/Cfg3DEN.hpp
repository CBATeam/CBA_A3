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
                    onLoad = QUOTE(\
                        params [ARR_1('_ctrlYear')];\
                        for '_y' from 1900 to 2050 do {\
                            _ctrlYear lbSetValue [ARR_2(_ctrlYear lbAdd str _y,_y)];\
                        };\
                        _ctrlYear lbSetCurSel 53;);
                };
            };
        };
    };

    class Group {
        class AttributeCategories {
            class Init {
                class Attributes {
                    class Callsign {
                        expression = QUOTE(\
                            if (isNil 'CBA_fnc_setCallsign') then {\
                                _this setGroupID [ARR_1(_value)];\
                            } else {\
                                [ARR_2(_this,_value)] call CBA_fnc_setCallsign;\
                            };);
                    };
                };
            };
        };
    };
};

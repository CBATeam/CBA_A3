
#define POS_H_GROUP(N) (5 + N * 3.5) * (pixelH * pixelGrid * 0.50)
#define POS_H_BACKGROUND(N) (N * 3.5 + 0.6 * 5) * (pixelH * pixelGrid * 0.50)
#define POS_H_TITLE(N) (N * 3.5 + 1 * 5) * (pixelH * pixelGrid * 0.50)
#define POS_H_VALUE(N) N * 3.5 * (pixelH * pixelGrid * 0.50)

class Cfg3DEN {
    class Attributes {
        class Edit;
        class EditMulti3: Edit {
            class Controls;
        };

        class EditCodeMulti3: EditMulti3 {
            class Controls: Controls {
                class Background;
                class Title;
                class Value;
            };
        };

        class GVAR(EditCodeMulti3): EditCodeMulti3 {
            h = POS_H_GROUP(3);

            class Controls: Controls {
                class Background: Background {
                    h = POS_H_BACKGROUND(3);
                };
                class Title: Title {
                    h = POS_H_TITLE(3);
                };
                class Value: Value {
                    onLoad = "(_this select 0) ctrlEnable false;";
                    h = 0;
                };
                class GVAR(Value): Value {
                    // Copies contents of editable init box into the hidden
                    // variant. Automatically adds call-block wrapper to enable
                    // the usage of local variables and return values.
                    onLoad = "_this spawn {\
                        private _code = ctrlText (ctrlParentControlsGroup (_this select 0) controlsGroupCtrl 100);\
                        if (_code select [0, 5] == 'call{' && {_code select [count _code - 1] == '}'}) then {\
                            _code = _code select [5, count _code - 6];\
                        };\
                        (_this select 0) ctrlSetText _code;\
                    };";
                    onKillFocus = "\
                        private _code = ctrlText (_this select 0);\
                        if (_code != '') then {\
                            _code = 'call{' + _code + '}';\
                        };\
                        (ctrlParentControlsGroup (_this select 0) controlsGroupCtrl 100) ctrlSetText _code;\
                    ";

                    idc = -1;
                    h = POS_H_VALUE(3);
                };
            };
        };

        class GVAR(EditCodeMulti5): GVAR(EditCodeMulti3) {
            h = POS_H_GROUP(5);

            class Controls: Controls {
                class Background: Background {
                    h = POS_H_BACKGROUND(5);
                };
                class Title: Title {
                    h = POS_H_TITLE(5);
                };
                class Value: Value {};
                class GVAR(Value): GVAR(Value) {
                    h = POS_H_VALUE(5);
                };
            };
        };

        class GVAR(EditCodeMulti6): GVAR(EditCodeMulti3) {
            h = POS_H_GROUP(6);

            class Controls: Controls {
                class Background: Background {
                    h = POS_H_BACKGROUND(6);
                };
                class Title: Title {
                    h = POS_H_TITLE(6);
                };
                class Value: Value {};
                class GVAR(Value): GVAR(Value) {
                    h = POS_H_VALUE(6);
                };
            };
        };

        class GVAR(EditCodeMulti10): GVAR(EditCodeMulti3) {
            h = POS_H_GROUP(10);

            class Controls: Controls {
                class Background: Background {
                    h = POS_H_BACKGROUND(10);
                };
                class Title: Title {
                    h = POS_H_TITLE(10);
                };
                class Value: Value {};
                class GVAR(Value): GVAR(Value) {
                    h = POS_H_VALUE(10);
                };
            };
        };
    };

    class Object {
        class AttributeCategories {
            class Init {
                class Attributes {
                    class Init {
                        control = QGVAR(EditCodeMulti10);
                    };
                };
            };
        };
    };

    class Group {
        class AttributeCategories {
            class Init {
                class Attributes {
                    class Init {
                        control = QGVAR(EditCodeMulti6);
                    };
                    class Callsign {
                        expression = "[_this, _value] call CBA_fnc_setCallsign";
                    };
                };
            };
        };
    };

    class Trigger {
        class AttributeCategories {
            class Expression {
                class Attributes {
                    class Condition {
                        control = QGVAR(EditCodeMulti3);
                    };
                    class OnActivation {
                        control = QGVAR(EditCodeMulti5);
                    };
                    class OnDeactivation {
                        control = QGVAR(EditCodeMulti3);
                    };
                };
            };
        };
    };

    class Waypoint {
        class AttributeCategories {
            class Expression {
                class Attributes {
                    class Condition {
                        control = QGVAR(EditCodeMulti3);
                    };
                    class OnActivation {
                        control = QGVAR(EditCodeMulti5);
                    };
                };
            };
        };
    };

    class Logic {
        class AttributeCategories {
            class Init {
                class Attributes {
                    class Init {
                        control = QGVAR(EditCodeMulti6);
                    };
                };
            };
        };
    };
};

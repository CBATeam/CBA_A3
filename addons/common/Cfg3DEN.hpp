
class Cfg3DEN {
    class Attributes {
        class Default;
        class Title: Default {
            class Controls;
        };

        class Checkbox: Title {
            class Controls: Controls {
                class Title;
                class Value;
            };
        };

        // A special checkbox that can manipulate the invisible init box.
        class GVAR(ValidateToggleCheckbox): Checkbox {
            class Controls: Controls {
                class Title: Title {};
                class Value: Value {
                    onLoad = QUOTE(uiNamespace setVariable [ARR_2('GVAR(ctrlValidateToggleCheckbox)',_this select 0)]);

                    // Either deletes the code inside the invisible init box or
                    // fills it with a copy of the code of the visible variant.
                    onCheckedChanged = QUOTE(\
                        with uiNamespace do {\
                            private _code = '';\
                            if (cbChecked (_this select 0)) then {\
                                _code = ctrlText GVAR(ctrlInitBox);\
                            };\
                            GVAR(ctrlInitBox_hidden) ctrlSetText _code;\
                        };\
                    );
                };
            };
        };

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

        // invisible uneditable copy of the init box
        class GVAR(InitBox_hidden): EditCodeMulti3 {
            h = 0;

            class Controls: Controls {
                class Value: Value {
                    // Changing IDC would lead to a CTD and since we use two
                    // copies, the default IDC cannot be used to access the
                    // control via displayCtrl. Save control in a variable
                    // instead.
                    onLoad = QUOTE(uiNamespace setVariable [ARR_2('GVAR(ctrlInitBox_hidden)',_this select 0)]);
                };
            };
        };

        // editable copy of the init that has been doubled in size
        class GVAR(InitBox): EditCodeMulti3 {
            h = "(5 + 10 * 3.5) * (pixelH * pixelGrid * 0.50)";

            class Controls: Controls {
                class Background: Background {
                    h = "(10 * 3.5 + 0.6 * 5) * (pixelH * pixelGrid * 0.50)";
                };
                class Title: Title {
                    h = "(10 * 3.5 + 1 * 5) * (pixelH * pixelGrid * 0.50)";
                };
                class Value: Value {
                    // Changing IDC would lead to a CTD and since we use two
                    // copies, the default IDC cannot be used to access the
                    // control via displayCtrl. Save control in a variable
                    // instead.
                    onLoad = QUOTE(uiNamespace setVariable [ARR_2('GVAR(ctrlInitBox)',_this select 0)]);

                    // Copies contents of editable init box into the hidden
                    // variant that has code validation enabled, but only if the
                    // "Validate Init Expression" box is checked.
                    onKillFocus = QUOTE(\
                        with uiNamespace do {\
                            private _code = '';\
                            if (cbChecked GVAR(ctrlValidateToggleCheckbox)) then {\
                                _code = ctrlText GVAR(ctrlInitBox);\
                            };\
                            GVAR(ctrlInitBox_hidden) ctrlSetText _code;\
                        };\
                    );
                    h = "10 * 3.5 * (pixelH * pixelGrid * 0.50)";
                };
            };
        };
    };

    class Object {
        class AttributeCategories {
            class Init {
                class Attributes {
                    class Init {
                        // Only the last control with data = "Init" is used by
                        // the game to determine the objects init expression.
                        // This control cannot be edited by hand, but if the
                        // "Validate Init Expression" box is checked, the
                        // contents of the visible init box are copied into this
                        // control, which indirectly enables code validation.
                        // If "Validate Init Expression" is unchecked, this
                        // control is left blank, so any expression passes.
                        control = QGVAR(InitBox_hidden);
                    };
                    class GVAR(Init): Init {
                        // This disables code validation that prevents usage of
                        // local variables and return values.
                        validate = "";
                        control = QGVAR(InitBox);
                    };
                    class GVAR(ValidateToggle) {
                        // The "Validate Init Expression" attribute does
                        // nothing by itself. The variable is set by the
                        // controls interface eventhandlers instead, so the
                        // setting can be changed while the menu is opened.
                        property = QGVAR(ValidateToggle);
                        control = QGVAR(ValidateToggleCheckbox);
                        displayName = CSTRING(ValidateInitBox);
                        tooltip = CSTRING(ValidateInitBox_tooltip);
                        expression = "";
                        typeName = "BOOL";
                        defaultValue = "true";
                    };
                };
            };
        };
    };

    class Group {
        class AttributeCategories {
            class Init {
                class Attributes {
                    class Callsign {
                        expression = "[_this, _value] call CBA_fnc_setCallsign";
                    };
                };
            };
        };
    };
};

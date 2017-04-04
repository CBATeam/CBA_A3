
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

        // invisible uneditable copy of the init box
        class GVAR(InitBox_hidden): EditCodeMulti3 {
            h = 0;

            class Controls: Controls {
                class Value: Value {
                    // Changing IDC would lead to a CTD
                    onLoad = QUOTE(uiNamespace setVariable [ARR_2('GVAR(ctrlInitBox_hidden)',_this select 0)]);

                    // Makes this control not selectable without disabling it.
                    onSetFocus = QUOTE(0 spawn {ctrlSetFocus (uiNamespace getVariable 'GVAR(ctrlInitBox)')});
                };
            };
        };

        // editable copy of the init that has been doubled in size
        class GVAR(InitBox): EditCodeMulti3 {
            attributeLoad = QUOTE(\
                private _t = ctrlText (uiNamespace getVariable 'GVAR(ctrlInitBox_hidden)');\
                (_this controlsGroupCtrl 100) ctrlSetText (_t select [ARR_2(5,count _t - 6)]);\
            );
            attributeSave = "";
            h = "(5 + 10 * 3.5) * (pixelH * pixelGrid * 0.50)";

            class Controls: Controls {
                class Background: Background {
                    h = "(10 * 3.5 + 0.6 * 5) * (pixelH * pixelGrid * 0.50)";
                };
                class Title: Title {
                    h = "(10 * 3.5 + 1 * 5) * (pixelH * pixelGrid * 0.50)";
                };
                class Value: Value {
                    // Changing IDC would lead to a CTD
                    onLoad = QUOTE(uiNamespace setVariable [ARR_2('GVAR(ctrlInitBox)',_this select 0)]);

                    // Copies contents of editable init box into the hidden
                    // variant. Automatically adds call-block wrapper to enable
                    // the usage of local variables and return values.
                    onKillFocus = QUOTE((uiNamespace getVariable 'GVAR(ctrlInitBox_hidden)') ctrlSetText ('call{' + ctrlText (_this select 0) + '}'););
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
                        control = QGVAR(InitBox_hidden);
                    };
                    class GVAR(Init) {
                        property = QGVAR(Init);
                        value = 0;
                        control = QGVAR(InitBox);
                        displayName = "$STR_3DEN_Object_Attribute_Init_displayName";
                        tooltip = "$STR_3DEN_Object_Attribute_Init_tooltip";
                        expression = "";
                        defaultValue = "";
                        wikiType = "[[String]]";
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

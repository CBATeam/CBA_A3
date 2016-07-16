
class Cfg3DEN {
    class Object {
        class AttributeCategories {
            class State {
                class Attributes {
                    class GVAR(Stance) {
                        property = QGVAR(Stance);
                        control = QGVAR(Stance);
                        displayName = "$STR_3DEN_Object_Attribute_Stance_displayName";
                        expression = "_this setUnitPos _value";
                        defaultValue = "false";
                        wikiType = "[[String]]";
                    };
                };
            };
        };
    };

    class Attributes {
        class Default;
        class Title: Default {
            class Controls;
        };
        class Toolbox: Title {
            class Controls: Controls {
                class Title;
                class Value;
            };
        };
        class GVAR(Stance): Toolbox {
            attributeLoad = QUOTE((_this controlsGroupCtrl 100) lbSetCurSel ([ARR_4('auto','down','middle','up')] find _value););
            attributeSave = QUOTE([ARR_4('auto','down','middle','up')] select (missionNamespace getVariable [ARR_2('GVAR(Stance_value)',0)]););
            h = "8 * (pixelH * pixelGrid * 0.50)";

            class Controls: Controls {
                class Title: Title {
                    h = "8 * (pixelH * pixelGrid * 0.50)";
                };
                class Value: Value {
                    idc = 100;
                    style = "0x02 + 0x30 + 0x800";
                    h = "8 * (pixelH * pixelGrid * 0.50)";
                    rows = 1;
                    columns = 4;
                    strings[] = {"\a3\3DEN\Data\Attributes\default_ca.paa","\a3\3DEN\Data\Attributes\Stance\down_ca.paa","\a3\3DEN\Data\Attributes\Stance\middle_ca.paa","\a3\3DEN\Data\Attributes\Stance\up_ca.paa"};
                    tooltips[] = {"$STR_3den_attributes_stance_default","$STR_3den_attributes_stance_down","$STR_3den_attributes_stance_middle","$STR_3den_attributes_stance_up"};
                    values[] = {-1,0,1,2};
                    onToolboxSelChanged = QUOTE(missionNamespace setVariable [ARR_2('GVAR(Stance_value)',_this select 1)];);
                };
            };
        };
    };
};

class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class ArgumentsBaseUnits;
        class ModuleDescription;
    };

    class GVAR(start): Module_F {
        scope = 2;
        displayName = "Catenary";
        author = "$STR_CBA_Author";
        vehicleClass = "Modules";
        category = "CBA_Modules";
        function = QFUNC(module);
        functionPriority = 1;
        //isGlobal = 1;
        //isTriggerActivated = 1;
        isDisposable = 0;
        is3DEN = 1;

        class Arguments: ArgumentsBaseUnits {
            class ArcLength {
                displayName = "Arc Length";
                description = "Length of the catenary curve.\nPositive values mean absolute length.\nUse negative numbers to multiply this value with the distance between the two end points.";
                typeName = "NUMBER";
                defaultValue = -1.01;
            };

            class SegmentCount {
                displayName = "Segment Count";
                description = "Number of straight segments that approximate the catenary.\nUse negative values to generate a variable segment count with constant length.";
                typeName = "NUMBER";
                defaultValue = -0.3;
            };

            class Model {
                displayName = "Segment Classname";
                description = "Classname of a segment.";
                typeName = "STRING";
                defaultValue = "Rope";
            };

            class Upwards {
                displayName = "Model Points Upwards";
                description = "Yes: Model points upwards in Object Builder.\nNo: Model points forwards in Object Builder.";
                typeName = "BOOL";
                class Values {
                    class Yes {
                        name = "Yes";
                        value = 1;
                        default = 1;
                    };
                    class No {
                        name = "No";
                        value = 0;
                    };
                };
            };

            class IsSimple {
                displayName = "Segment Object Type";
                description = "Create simple object or 3DEN-Entity.";
                typeName = "BOOL";
                class Values {
                    class Yes {
                        name = "Simple";
                        value = 1;
                        default = 1;
                    };
                    class No {
                        name = "3DEN-Entity";
                        value = 0;
                    };
                };
            };
        };
    };
};

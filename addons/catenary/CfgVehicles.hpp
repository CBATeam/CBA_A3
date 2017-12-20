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
                defaultValue = -1;
            };
        };

        class ModuleDescription: ModuleDescription {
            description = "Press P to center the logic to the first intersection with the center of the screen.";
            sync[] = {"LocationArea_F"};

            class LocationArea_F {
                position = 0;
                optional = 0;
                duplicate = 1;
                synced[] = {"Anything"};
            };
        };
    };
};

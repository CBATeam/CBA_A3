
class CfgVehicles {
    class Static;
    class CBA_NamespaceDummy: Static {
        scope = 1;
        displayName = "";

        class EventHandlers {
            init = "(_this select 0) enableSimulation false";
        };
    };
};

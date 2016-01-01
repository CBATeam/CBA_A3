
class CfgFunctions {
    class CBA {
        class XEH {
            class isSheduled {
                description = "Check if the current scope is running in sheduled or unsheduled environment.";
                file = PATHTOF(fnc_isSheduled.sqf);
            };
            class isRecompileEnabled {
                description = "Check if recompiling is enabled.";
                file = PATHTOF(fnc_isRecompileEnabled.sqf);
            };
            class addClassEventHandler {
                description = "Add an eventhandler to a class and all children.";
                file = PATHTOF(fnc_addClassEventHandler.sqf);
            };
            class init {
                headerType = -1;
                description = "Runs Init and InitPost event handlers on this object.";
                file = PATHTOF(fnc_init.sqf);
            };
            class initEvents {
                headerType = -1;
                description = "Adds all event handlers to this object.";
                file = PATHTOF(fnc_initEvents.sqf);
            };
            class supportMonitor {
                description = "Iterate through all vehicle classes and find those who don't support extended event handlers.";
                file = PATHTOF(fnc_supportMonitor.sqf);
            };
            class compileEventHandlers {
                description = "Compiles all Extended EventHandlers in given config.";
                file = PATHTOF(fnc_compileEventHandlers.sqf);
            };
            class compileFunction {
                description = "Compiles a function into mission namespace and into ui namespace for caching purposes.";
                file = PATHTOF(fnc_compileFunction.sqf);
            };
            class preStart {
                preStart = 1;
                description = "Occurs once during game start.";
                file = PATHTOF(fnc_preStart.sqf);
            };
            class preInit {
                preInit = 1;
                description = "Occurs once per mission before objects are initialized.";
                file = PATHTOF(fnc_preInit.sqf);
            };
            class postInit {
                postInit = 1;
                description = "Occurs once per mission after objects and functions are initialized.";
                file = PATHTOF(fnc_postInit.sqf);
            };
            class postInit_unsheduled {
                description = "Occurs once per mission after objects and functions are initialized.";
                file = PATHTOF(fnc_postInit_unsheduled.sqf);
            };
            class getInMan {
                description = "Emulates GetInMan event handler by adding a GetIn event to all objects and rearranging parameters.";
                file = PATHTOF(fnc_getInMan.sqf);
            };
            class getOutMan {
                description = "Emulates GetOutMan event handler by adding a GetOut event to all objects and rearranging parameters.";
                file = PATHTOF(fnc_getOutMan.sqf);
            };
            class startFallbackLoop {
                description = "Starts a loop to iterate through all objects to initialize event handlers on XEH incompatible objects.";
                file = PATHTOF(fnc_startFallbackLoop.sqf);
            };
        };
    };
};

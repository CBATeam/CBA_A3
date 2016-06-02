class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class ArgumentsBaseUnits;
        class ModuleDescription;
    };

    class CBA_ModuleAttack: Module_F {
        scope = 2;
        displayName = "Attack"; // stringtable
        vehicleClass = "Modules";
        category = "CBA_Modules";
        function = "CBA_fnc_moduleAttack"; //stringtable
        functionPriority = 1;
        isGlobal = 2;
        isTriggerActivated = 1;
        isDisposable = 0;
        is3DEN = 0;
        curatorInfoType = "RscDisplayAttributeAttack";

        class Arguments: ArgumentsBaseUnits {
            class attackLocType{
                displayName = "Attack Location Type"; // stringtable
                description = "Leave empty to use module location as attack location"; // stringtable
                typeName = "STRING";
                class values {
                    class moduleLoc {
                        name = "Module Position"; //stringtable
                        value = "";
                        default = "";
                    };
                    class objectLoc {
                        name = "Object/Location"; //stringtable
                        value = "OBJECT";
                    };
                    class groupLoc {
                        name = "Group"; //stringtable
                        value = "GROUP";
                    };
                    class arrayLoc {
                        name = "Array"; //stringtable
                        value = "ARRAY";
                    };
                    class markerLoc {
                        name = "Marker"; //stringtable
                        value = "MARKER";
                    };
                    class taskLoc {
                        name = "Task"; //stringtable
                        value = "TASK";
                    };
                };
            };

            class attackPosition {
                displayName = "Attack Position"; //stringtable
                description = "Enter an array with brackets or name without quotes("")"; //stringtable
                typeName = "STRING";
            };

            class searchRadius {
                displayName = "Search Radius"; //stringtable
                description = "Enter a number for size of the radius to search"; //stringtable
                typeName = "NUMBER";
                defaultValue = 0;
            };
        };

        class ModuleDescription: ModuleDescription {
            description = "Sync to leader of group to attack a parsed location"; //stringtable
            sync[] = {"LocationArea_F"};

            class LocationArea_F {
                position = 0;
                optional = 0;
                duplicate = 1;
                synced[] = {"Anything"};
            };
        };
    };

    class CBA_ModuleDefend: Module_F {
        scope = 2;
        displayName = "Defend"; //stringtable
        vehicleClass = "Modules";
        category = "CBA_Modules";
        function = "CBA_fnc_moduleDefend"; //stringtable
        functionPriority = 1;
        isGlobal = 2;
        isTriggerActivated = 1;
        isDisposable = 0;
        is3DEN = 0;
        curatorInfoType = "RscDisplayAttributeDefend";
    
        class Arguments: ArgumentsBaseUnits {
            class defendLocType {
                displayName = "Defend Position Type"; //stringtable
                description = "Leave empty to use module location as defend location"; //stringtable
                typeName = "STRING";
                class values {
                    class setLoc {
                        name = "Set Position"; //stringtable
                        value = "";
                        default = "";
                    };
                    class objectLoc {
                        name = "Object/Location"; //stringtable
                        value = "OBJECT";
                    };
                    class groupLoc {
                        name = "Group"; //stringtable
                        value = "GROUP";
                    };
                    class arrayLoc {
                        name = "Array"; //stringtable
                        value = "ARRAY";
                    };
                    class markerLoc {
                        name = "Marker"; //stringtable
                        value = "MARKER";
                    };
                    class taskLoc {
                        name = "Task"; //stringtable
                        value = "TASK";
                    };
                };
            };
    
            class defendPosition {
                displayName = "Defend Position"; //stringtable
                description = "The center point of the defend area"; //stringtable
                typeName = "STRING";
            };
    
            class defendRadius {
                displayName = "Defend Radius"; //stringtable
                description = "The max distance to defend from the center point"; //stringtable
                typeName = "NUMBER";
                defaultValue = 25;
            };

            class threshold {
                displayName = "Building Size Threshold"; //stringtable
                description = "Smaller the number the more buildings available"; //stringtable
                typeName = "NUMBER";
                class values {
                    class two {
                        name = "2";
                        value = 2;
                        default = 2;
                    };
                    class one {
                        name = "1";
                        value = 1;
                    };
                    class three {
                        name = "3";
                        value = 3;
                    };
                    class four {
                        name = "4";
                        value = 4;
                    };
                    class five{
                        name = "5";
                        value = 5;
                    };
                    class six {
                        name = "6";
                        value = 6;
                    };
                };
            };
    
            class canPatrol {
                displayName = "Allow Patroling"; //stringtable
                description = "AI will be able to patrol the area they are defending"; //stringtable
                typeName = "BOOL";
                class values {
                    class yes {
                        name = "$STR_lib_info_yes";
                        value = 1;
                        default = 1;
                    };
                    class no {
                        name = "$STR_lib_info_no";
                        value = 0;
                    };
                };
            };
        };
        
        class ModuleDescription: ModuleDescription {
            description = "Sync to leader of group to defend a parsed location";
            sync[] = {"LocationArea_F"};
    
            class LocationArea_F {
                position = 0;
                optional = 0;
                duplicate = 1;
                synced[] = {"Anything"};
            };
        };
    };
    
    class CBA_ModulePatrol: Module_F {
        scope = 2;
        displayName = "Patrol"; //stringtable
        vehicleClass = "Modules";
        category = "CBA_Modules";
        function = "CBA_fnc_modulePatrol"; //stringtable
        functionPriority = 1;
        isGlobal = 2;
        isTriggerActivated = 1;
        isDisposable = 0;
        is3DEN = 0;
        curatorInfoType = "RscDisplayAttributePatrol";
        
        class Arguments: ArgumentsBaseUnits {
            class patrolLocType {
                displayName = "Patrol Center Type"; //stringtable
                description = "Select the type of position to pass"; //stringtable
                typeName = "STRING";
                class values {
                    class setLoc {
                        name = "Set Position"; //stringtable
                        value = "";
                        default = "";
                    };
                    class objectLoc {
                        name = "Object/Location"; //stringtable
                        value = "OBJECT";
                    };
                    class groupLoc {
                        name = "Group"; //stringtable
                        value = "GROUP";
                    };
                    class arrayLoc {
                        name = "Array"; //stringtable
                        value = "ARRAY";
                    };
                    class markerLoc {
                        name = "Marker"; //stringtable
                        value = "MARKER";
                    };
                    class taskLoc {
                        name = "Task"; //stringtable
                        value = "TASK";
                    };
                };
            };
            
            class patrolPosition {
                displayName = "Center point"; //stringtable
                description = "If using a position other than the spawn point"; //stringtable
                typeName = "STRING";
            };
            
            class patrolRadius {
                displayName = "Patrol Radius"; //stringtable
                description = "The distance to patrol from the center point"; //stringtable
                typeName = "NUMBER";
                defaultValue = 25;
            };

            class waypointCount {
                displayName = "Waypoint Count"; //stringtable
                description = "The amount of waypoints to create"; //stringtable
                typeName = "NUMBER";
                defaultValue = 4;
            };
            
            class waypointType {
                displayName = "Waypoint Type"; //stringtable
                description = "The type of waypoint to be used"; //stringtable
                typeName = "STRING";
                class values {
                    class move {
                        name = "Move"; //stringtable
                        value = "MOVE";
                        default = "";
                    };
                    class sad {
                        name = "Seek and Destroy"; //stringtable
                        value = "SAD";
                    };
                    class loiter {
                        name = "Loiter"; //stringtable
                        value = "LOITER";
                    };
                };
            };
            
            class behaviour {
                displayName = "Behaviour"; //stringtable
                description = "The behaviour of the group"; //stringtable
                typeName = "STRING";
                class values {
                    class careless {
                        name = "Careless"; //stringtable
                        value = "CARELESS";
                        default = "";
                    };
                    class safe {
                        name = "Safe"; //stringtable
                        value = "SAFE";
                    };
                    class aware {
                        name = "Aware"; //stringtable
                        value = "AWARE";
                    };
                    class combat {
                        name = "Combat"; //stringtable
                        value = "COMBAT";
                    };
                    class stealth {
                        name = "Stealth"; //stringtable
                        value = "STEALTH";
                    };
                };
            };
            
            class combatMode {
                displayName = "Combat Mode"; //stringtable
                description = "How fast the group is to engage"; //stringtable
                typeName = "STRING";
                class values {
                    class yellow {
                        name = "Yellow(Fire at will)"; //stringtable
                        value = "YELLOW";
                        default = "";
                    };
                    class blue {
                        name = "Blue(Never fire)"; //stringtable
                        value = "BLUE";
                    };
                    class green {
                        name = "Green(Hold Fire-Defend Only)"; //stringtable
                        value = "GREEN";
                    };
                    class white {
                        name = "White(Hold Fire-Engage at will)"; //stringtable
                        value = "WHITE";
                    };
                    class red {
                        name = "Red(Fire at will-Engage at will)"; //stringtable
                        value = "RED";
                    };
                };
            };
            
            class speedMode {
                displayName = "Speed Mode"; //stringtable
                description = "Walk, jog, or run to each waypoint"; //stringtable
                typeName = "STRING";
                class values {
                    class limited {
                        name = "Limited(Walking)"; //stringtable
                        value = "LIMITED";
                        default = "";
                    };
                    class normal {
                        name = "Normal(Jog-Stays in formation)"; //stringtable
                        value = "NORMAL";
                    };
                    class full {
                        name = "Full(Run-No formation)"; //stringtable
                        value = "FULL";
                    };
                };
            };
            
            class formation {
                displayName = "Formation"; //stringtable
                description = "The formation to be used when moving"; //stringtable
                typeName = "STRING";
                class values {
                    class column {
                        name = "Column"; //stringtable
                        value = "COLUMN";
                        default = "";
                    };
                    class stagColumn {
                        name = "Stag Column"; //stringtable
                        value = "STAG COLUMN";
                    };
                    class wedge {
                        name = "Wedge"; //stringtable
                        value = "WEDGE";
                    };
                    class echLeft {
                        name = "Ech Left"; //stringtable
                        value = "ECH LEFT";
                    };
                    class echRight {
                        name = "Ech Right"; //stringtable
                        value = "ECH RIGHT";
                    };
                    class vee {
                        name = "Vee"; //stringtable
                        value = "VEE";
                    };
                    class line {
                        name = "Line"; //stringtable
                        value = "LINE";
                    };
                    class file {
                        name = "File"; //stringtable
                        value = "FILE";
                    };
                    class diamond {
                        name = "Diamond"; //stringtable
                        value = "DIAMOND";
                    };
                };
            };
            
            class executableCode {
                displayName = "Code to Execute"; //stringtable
                description = "Any code to run at waypoints"; //stringtable
                typeName = "STRING";
            };
            
            class timeout {
                displayName = "Timeout"; //stringtable
                description = "[Min, Med, Max] Time to wait at waypoints"; //stringtable
                typeName = "STRING";
                defaultValue = "[1,5,10]";
            };
        };
        
        class ModuleDescription: ModuleDescription {
            description = "Sync to leader of group to patrol a parsed location"; //stringtable
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
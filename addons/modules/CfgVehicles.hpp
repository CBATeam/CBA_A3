class CfgVehicles{
    class Logic;
    class Module_F: Logic{
        class ArgumentsBaseUnits;
        class ModuleDescription;
    };

    class CBA_ModuleAttack: Module_F{
        scope = 2;
        displayName = "Attack";
        vehicleClass = "Modules";
        category = "CBA_Modules";
        function = "CBA_fnc_moduleAttack";
        functionPriority = 1;
        isGlobal = 2;
        isTriggerActivated = 1;
        isDisposable = 0;
        is3DEN = 0;
        curatorInfoType = "RscDisplayAttributeAttack";

        class Arguments: ArgumentsBaseUnits{
            class attackLocType{
                displayName = "Attack Location Type";
                description = "Leave empty to use module location as attack location";
                typeName = "NUMBER";
                class values{
                    class moduleLoc{
                        name = "Module Position";
                        value = 0;
                        default = 0;
                    };
                    class objectLoc{
                        name = "Object/Location";
                        value = 1;
                    };
                    class groupLoc{
                        name = "Group";
                        value = 2;
                    };
                    class arrayLoc{
                        name = "Array";
                        value = 3;
                    };
                    class markerLoc{
                        name = "Marker";
                        value = 4;
                    };
                    class taskLoc{
                        name = "Task";
                        value = 5;
                    };
                };
            };

            class attackPosition{
                displayName = "Attack Position";
                description = "Enter an array with brackets or name without quotes("")";
                typeName = "STRING";
            };

            class searchRadius{
                displayName = "Search Radius";
                description = "Enter a number for size of the radius to search";
                typeName = "NUMBER";
                defaultValue = 0;
            };
        };

        class ModuleDescription: ModuleDescription{
            description = "Sync to leader of group to attack a parsed location";
            sync[] = {"LocationArea_F"};

            class LocationArea_F{
                description[] = {
                    "Sync module to the group leader of any groups",
                    "that you want to have attack the position passed",
                    "to the module. The module may also be synced to a",
                    "trigger to have synced entities attack on a set condition."
                };
                position = 0;
                optional = 0;
                duplicate = 1;
                synced[] = {"Anything"};
            };
        };
    };

    class CBA_ModuleDefend: Module_F{
        scope = 2;
        displayName = "Defend";
        vehicleClass = "Modules";
        category = "CBA_Modules";
        function = "CBA_fnc_moduleDefend";
        functionPriority = 1;
        isGlobal = 2;
        isTriggerActivated = 1;
        isDisposable = 0;
        is3DEN = 0;
        curatorInfoType = "RscDisplayAttributeDefend";
    
        class Arguments: ArgumentsBaseUnits{
            class defendLocType{
                displayName = "Defend Position Type";
                description = "Leave empty to use module location as defend location";
                typeName = "NUMBER";
                class values{
                    class setLoc{
                        name = "Set Position";
                        value = 0;
                        default = 0;
                    };
                    class objectLoc{
                        name = "Object/Location";
                        value = 1;
                    };
                    class groupLoc{
                        name = "Group";
                        value = 2;
                    };
                    class arrayLoc{
                        name = "Array";
                        value = 3;
                    };
                    class markerLoc{
                        name = "Marker";
                        value = 4;
                    };
                    class taskLoc{
                        name = "Task";
                        value = 5;
                    };
                };
            };
    
            class defendPosition{
                displayName = "Defend Position";
                description = "The center point of the defend area";
                typeName = "STRING";
            };
    
            class defendRadius{
                displayName = "Defend Radius";
                description = "The max distance to defend from the center point";
                typeName = "NUMBER";
                defaultValue = 25;
            };

            class threshold{
                displayName = "Building Size Threshold";
                description = "Smaller the number the more buildings available";
                typeName = "NUMBER";
                class values{
                    class two{
                        name = "2";
                        value = 2;
                        default = 2;
                    };
                    class one{
                        name = "1";
                        value = 1;
                    };
                    class three{
                        name = "3";
                        value = 3;
                    };
                    class four{
                        name = "4";
                        value = 4;
                    };
                    class five{
                        name = "5";
                        value = 5;
                    };
                    class six{
                        name = "6";
                        value = 6;
                    };
                };
            };
    
            class canPatrol{
                displayName = "Allow Patroling";
                description = "AI will be able to patrol the area they are defending";
                typeName = "BOOL";
                class values{
                    class yes{
                        name = "$STR_lib_info_yes";
                        value = 1;
                        default = 1;
                    };
                    class no{
                        name = "$STR_lib_info_no";
                        value = 0;
                    };
                };
            };
        };
        
        class ModuleDescription: ModuleDescription{
            description = "Sync to leader of group to defend a parsed location";
            sync[] = {"LocationArea_F"};
    
            class LocationArea_F{
                description[] = {
                    "Sync the module to group leaders to have them defend a selected area.",
                    "The area can be passed through the module or where the groups spawn",
                    "at the start of the mission."
                };
                position = 0;
                optional = 0;
                duplicate = 1;
                synced[] = {"Anything"};
            };
        };
    };
    
    class CBA_ModulePatrol: Module_F{
        scope = 2;
        displayName = "Patrol";
        vehicleClass = "Modules";
        category = "CBA_Modules";
        function = "CBA_fnc_modulePatrol";
        functionPriority = 1;
        isGlobal = 2;
        isTriggerActivated = 1;
        isDisposable = 0;
        is3DEN = 0;
        curatorInfoType = "RscDisplayAttributePatrol";
        
        class Arguments: ArgumentsBaseUnits{
            class patrolLocType{
                displayName = "Patrol Center Type";
                description = "Select the type of position to pass";
                typeName = "NUMBER";
                class values{
                    class setLoc{
                        name = "Set Position";
                        value = 0;
                        default = 0;
                    };
                    class objectLoc{
                        name = "Object/Location";
                        value = 1;
                    };
                    class groupLoc{
                        name = "Group";
                        value = 2;
                    };
                    class arrayLoc{
                        name = "Array";
                        value = 3;
                    };
                    class markerLoc{
                        name = "Marker";
                        value = 4;
                    };
                    class taskLoc{
                        name = "Task";
                        value = 5;
                    };
                };
            };
            
            class patrolPosition{
                displayName = "Center point";
                description = "If using a position other than the spawn point";
                typeName = "STRING";
            };
            
            class patrolRadius{
                displayName = "Patrol Radius";
                description = "The distance to patrol from the center point";
                typeName = "NUMBER";
                defaultValue = 25;
            };

            class waypointCount{
                displayName = "Waypoint Count";
                description = "The amount of waypoints to create";
                typeName = "NUMBER";
                defaultValue = 4;
            };
            
            class waypointType{
                displayName = "Waypoint Type";
                description = "The type of waypoint to be used";
                typeName = "STRING";
                class values{
                    class move{
                        name = "Move";
                        value = "MOVE";
                        default = "";
                    };
                    class sad{
                        name = "Seek and Destroy";
                        value = "SAD";
                    };
                    class loiter{
                        name = "Loiter";
                        value = "LOITER";
                    };
                };
            };
            
            class behaviour{
                displayName = "Behaviour";
                description = "The behaviour of the group";
                typeName = "STRING";
                class values{
                    class careless{
                        name = "Careless";
                        value = "CARELESS";
                        default = "";
                    };
                    class safe{
                        name = "Safe";
                        value = "SAFE";
                    };
                    class aware{
                        name = "Aware";
                        value = "AWARE";
                    };
                    class combat{
                        name = "Combat";
                        value = "COMBAT";
                    };
                    class stealth{
                        name = "Stealth";
                        value = "STEALTH";
                    };
                };
            };
            
            class combatMode{
                displayName = "Combat Mode";
                description = "How fast the group is to engage";
                typeName = "STRING";
                class values{
                    class yellow{
                        name = "Yellow(Fire at will)";
                        value = "YELLOW";
                        default = "";
                    };
                    class blue{
                        name = "Blue(Never fire)";
                        value = "BLUE";
                    };
                    class green{
                        name = "Green(Hold Fire-Defend Only)";
                        value = "GREEN";
                    };
                    class white{
                        name = "White(Hold Fire-Engage at will)";
                        value = "WHITE";
                    };
                    class red{
                        name = "Red(Fire at will-Engage at will)";
                        value = "RED";
                    };
                };
            };
            
            class speedMode{
                displayName = "Speed Mode";
                description = "Walk, jog, or run to each waypoint";
                typeName = "STRING";
                class values{
                    class limited{
                        name = "Limited(Walking)";
                        value = "LIMITED";
                        default = "";
                    };
                    class normal{
                        name = "Normal(Jog-Stays in formation)";
                        value = "NORMAL";
                    };
                    class full{
                        name = "Full(Run-No formation)";
                        value = "FULL";
                    };
                };
            };
            
            class formation{
                displayName = "Formation";
                description = "The formation to be used when moving";
                typeName = "STRING";
                class values{
                    class column{
                        name = "Column";
                        value = "COLUMN";
                        default = "";
                    };
                    class stagColumn{
                        name = "Stag Column";
                        value = "STAG COLUMN";
                    };
                    class wedge{
                        name = "Wedge";
                        value = "WEDGE";
                    };
                    class echLeft{
                        name = "Ech Left";
                        value = "ECH LEFT";
                    };
                    class echRight{
                        name = "Ech Right";
                        value = "ECH RIGHT";
                    };
                    class vee{
                        name = "Vee";
                        value = "VEE";
                    };
                    class line{
                        name = "Line";
                        value = "LINE";
                    };
                    class file{
                        name = "File";
                        value = "FILE";
                    };
                    class diamond{
                        name = "Diamond";
                        value = "DIAMOND";
                    };
                };
            };
            
            class executableCode{
                displayName = "Code to Execute";
                description = "Any code to run at waypoints";
                typeName = "STRING";
            };
            
            class timeout{
                displayName = "Timeout";
                description = "[Min, Med, Max] Time to wait at waypoints";
                typeName = "STRING";
                defaultValue = "[1,5,10]";
            };
        };
        
        class ModuleDescription: ModuleDescription{
            description = "Sync to leader of group to patrol a parsed location";
            sync[] = {"LocationArea_F"};
    
            class LocationArea_F{
                description[] = {
                    "Sync the module to group leaders to have them patrol a selected area.",
                    "The area can be passed through the module or where the groups spawn",
                    "at the start of the mission."
                };
                position = 0;
                optional = 0;
                duplicate = 1;
                synced[] = {"Anything"};
            };
        };
    };
};
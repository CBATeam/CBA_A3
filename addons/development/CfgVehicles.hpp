class CfgVehicles{
    class Logic;
    class Module_F: Logic{
        class ArgumentsBaseUnits;
        class ModuleDescription;
    };

    class CBA_moduleAttack: Module_F{
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
                defaultValue = 0;
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
                    class zero{
                        name = "0";
                        value = 0;
                    };
                    class five{
                        name = "5";
                        value = 5;
                    };
                    class eight{
                        name = "8";
                        value = 8;
                    };
                    class twelve{
                        name = "12";
                        value = 12;
                    };
                    class twenty{
                        name = "20";
                        value = 20;
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
            description = "Sync to leader of group to attack a parsed location";
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
};
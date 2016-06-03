class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class ArgumentsBaseUnits;
        class ModuleDescription;
    };

    class CBA_ModuleAttack: Module_F {
        scope = 2;
        displayName = CSTRING(Attack); // stringtable
        vehicleClass = "Modules";
        category = "CBA_Modules";
        function = "CBA_fnc_moduleAttack";
        functionPriority = 1;
        isGlobal = 2;
        isTriggerActivated = 1;
        isDisposable = 0;
        is3DEN = 0;
        curatorInfoType = "RscDisplayAttributeAttack";

        class Arguments: ArgumentsBaseUnits {
            class attackLocType{
                displayName = CSTRING(AttackLocType); // stringtable
                description = CSTRING(AttackLocType_Desc); // stringtable
                typeName = "STRING";
                class values {
                    class moduleLoc {
                        name = CSTRING(ModuleLoc); //stringtable
                        value = "";
                        default = "";
                    };
                    class objectLoc {
                        name = CSTRING(ObjectLoc); //stringtable
                        value = "OBJECT";
                    };
                    class groupLoc {
                        name = CSTRING(GroupLoc); //stringtable
                        value = "GROUP";
                    };
                    class arrayLoc {
                        name = CSTRING(ArrayLoc); //stringtable
                        value = "ARRAY";
                    };
                    class markerLoc {
                        name = CSTRING(MarkerLoc); //stringtable
                        value = "MARKER";
                    };
                    class taskLoc {
                        name = CSTRING(TaskLoc); //stringtable
                        value = "TASK";
                    };
                };
            };

            class attackPosition {
                displayName = CSTRING(AttackPosition); //stringtable
                description = CSTRING(AttackPosition_Desc); //stringtable
                typeName = "STRING";
            };

            class searchRadius {
                displayName = CSTRING(SearchRadius); //stringtable
                description = CSTRING(SearchRadius_Desc); //stringtable
                typeName = "NUMBER";
                defaultValue = 0;
            };
        };

        class ModuleDescription: ModuleDescription {
            description = CSTRING(AttackModuleDescription); //stringtable
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
        displayName = CSTRING(Defend); //stringtable
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
                displayName = CSTRING(DefendPositionType); //stringtable
                description = CSTRING(DefendPositionType_Desc); //stringtable
                typeName = "STRING";
                class values {
                    class setLoc {
                        name = CSTRING(SetLoc); //stringtable
                        value = "";
                        default = "";
                    };
                    class objectLoc {
                        name = CSTRING(ObjectLoc); //stringtable
                        value = "OBJECT";
                    };
                    class groupLoc {
                        name = CSTRING(GroupLoc); //stringtable
                        value = "GROUP";
                    };
                    class arrayLoc {
                        name = CSTRING(ArrayLoc); //stringtable
                        value = "ARRAY";
                    };
                    class markerLoc {
                        name = CSTRING(MarkerLoc); //stringtable
                        value = "MARKER";
                    };
                    class taskLoc {
                        name = CSTRING(TaskLoc); //stringtable
                        value = "TASK";
                    };
                };
            };
    
            class defendPosition {
                displayName = CSTRING(DefendPosition); //stringtable
                description = CSTRING(DefendPosition_Desc); //stringtable
                typeName = "STRING";
            };
    
            class defendRadius {
                displayName = CSTRING(DefendRadius); //stringtable
                description = CSTRING(DefendRadius_Desc); //stringtable
                typeName = "NUMBER";
                defaultValue = 25;
            };

            class threshold {
                displayName = CSTRING(Threshold); //stringtable
                description = CSTRING(Threshold_Desc); //stringtable
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
                displayName = CSTRING(CanPatrol); //stringtable
                description = CSTRING(CanPatrol_Desc); //stringtable
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
            description = CSTRING(DefendModuleDescription);
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
        displayName = CSTRING(Patrol); //stringtable
        vehicleClass = "Modules";
        category = "CBA_Modules";
        function = "CBA_fnc_modulePatrol";
        functionPriority = 1;
        isGlobal = 2;
        isTriggerActivated = 1;
        isDisposable = 0;
        is3DEN = 0;
        curatorInfoType = "RscDisplayAttributePatrol";
        
        class Arguments: ArgumentsBaseUnits {
            class patrolLocType {
                displayName = CSTRING(PatrolCenterType); //stringtable
                description = CSTRING(PatrolCenterType_Desc); //stringtable
                typeName = "STRING";
                class values {
                    class setLoc {
                        name = CSTRING(SetLoc); //stringtable
                        value = "";
                        default = "";
                    };
                    class objectLoc {
                        name = CSTRING(ObjectLoc); //stringtable
                        value = "OBJECT";
                    };
                    class groupLoc {
                        name = CSTRING(GroupLoc); //stringtable
                        value = "GROUP";
                    };
                    class arrayLoc {
                        name = CSTRING(ArrayLoc); //stringtable
                        value = "ARRAY";
                    };
                    class markerLoc {
                        name = CSTRING(MarkerLoc); //stringtable
                        value = "MARKER";
                    };
                    class taskLoc {
                        name = CSTRING(TaskLoc); //stringtable
                        value = "TASK";
                    };
                };
            };
            
            class patrolPosition {
                displayName = CSTRING(PatrolPosition); //stringtable
                description = CSTRING(PatrolPosition_Desc); //stringtable
                typeName = "STRING";
            };
            
            class patrolRadius {
                displayName = CSTRING(PatrolRadius); //stringtable
                description = CSTRING(PatrolRadius_Desc); //stringtable
                typeName = "NUMBER";
                defaultValue = 25;
            };

            class waypointCount {
                displayName = CSTRING(WaypointCount); //stringtable
                description = CSTRING(WaypointCount_Desc); //stringtable
                typeName = "NUMBER";
                defaultValue = 4;
            };
            
            class waypointType {
                displayName = CSTRING(WaypointType); //stringtable
                description = CSTRING(WaypointType_Desc); //stringtable
                typeName = "STRING";
                class values {
                    class move {
                        name = CSTRING(Move); //stringtable
                        value = "MOVE";
                        default = "";
                    };
                    class sad {
                        name = CSTRING(SAD); //stringtable
                        value = "SAD";
                    };
                    class loiter {
                        name = CSTRING(Loiter); //stringtable
                        value = "LOITER";
                    };
                };
            };
            
            class behaviour {
                displayName = CSTRING(Behaviour); //stringtable
                description = CSTRING(Behaviour_Desc); //stringtable
                typeName = "STRING";
                class values {
                    class careless {
                        name = CSTRING(Careless); //stringtable
                        value = "CARELESS";
                        default = "";
                    };
                    class safe {
                        name = CSTRING(Safe); //stringtable
                        value = "SAFE";
                    };
                    class aware {
                        name = CSTRING(Aware); //stringtable
                        value = "AWARE";
                    };
                    class combat {
                        name = CSTRING(Combat); //stringtable
                        value = "COMBAT";
                    };
                    class stealth {
                        name = CSTRING(Stealth); //stringtable
                        value = "STEALTH";
                    };
                };
            };
            
            class combatMode {
                displayName = CSTRING(CombatMode); //stringtable
                description = CSTRING(CombatMode_Desc); //stringtable
                typeName = "STRING";
                class values {
                    class yellow {
                        name = CSTRING(CombatYellow); //stringtable
                        value = "YELLOW";
                        default = "";
                    };
                    class blue {
                        name = CSTRING(CombatBlue); //stringtable
                        value = "BLUE";
                    };
                    class green {
                        name = CSTRING(CombatGreen); //stringtable
                        value = "GREEN";
                    };
                    class white {
                        name = CSTRING(CombatWhite); //stringtable
                        value = "WHITE";
                    };
                    class red {
                        name = CSTRING(CombatRed); //stringtable
                        value = "RED";
                    };
                };
            };
            
            class speedMode {
                displayName = CSTRING(SpeedMode); //stringtable
                description = CSTRING(SpeedMode_Desc); //stringtable
                typeName = "STRING";
                class values {
                    class limited {
                        name = CSTRING(SpeedLimited); //stringtable
                        value = "LIMITED";
                        default = "";
                    };
                    class normal {
                        name = CSTRING(SpeedNormal); //stringtable
                        value = "NORMAL";
                    };
                    class full {
                        name = CSTRING(SpeedFull); //stringtable
                        value = "FULL";
                    };
                };
            };
            
            class formation {
                displayName = CSTRING(Formation); //stringtable
                description = CSTRING(Formation_Desc); //stringtable
                typeName = "STRING";
                class values {
                    class column {
                        name = CSTRING(Column); //stringtable
                        value = "COLUMN";
                        default = "";
                    };
                    class stagColumn {
                        name = CSTRING(StagColumn); //stringtable
                        value = "STAG COLUMN";
                    };
                    class wedge {
                        name = CSTRING(Wedge); //stringtable
                        value = "WEDGE";
                    };
                    class echLeft {
                        name = CSTRING(EchLeft); //stringtable
                        value = "ECH LEFT";
                    };
                    class echRight {
                        name = CSTRING(EchRight); //stringtable
                        value = "ECH RIGHT";
                    };
                    class vee {
                        name = CSTRING(Vee); //stringtable
                        value = "VEE";
                    };
                    class line {
                        name = CSTRING(Line); //stringtable
                        value = "LINE";
                    };
                    class file {
                        name = CSTRING(File); //stringtable
                        value = "FILE";
                    };
                    class diamond {
                        name = CSTRING(Diamond); //stringtable
                        value = "DIAMOND";
                    };
                };
            };
            
            class executableCode {
                displayName = CSTRING(ExecutableCode); //stringtable
                description = CSTRING(ExecutableCode_Desc); //stringtable
                typeName = "STRING";
            };
            
            class timeout {
                displayName = CSTRING(Timeout); //stringtable
                description = CSTRING(Timeout_Desc); //stringtable
                typeName = "STRING";
                defaultValue = "[1,5,10]";
            };
        };
        
        class ModuleDescription: ModuleDescription {
            description = CSTRING(PatrolModuleDescription); //stringtable
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
class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class ArgumentsBaseUnits;
        class ModuleDescription;
    };

    class CBA_ModuleAttack: Module_F {
        scope = 2;
        displayName = CSTRING(Attack);
        author = "WiredTiger";
        vehicleClass = "Modules";
        category = "CBA_Modules";
        function = "CBA_fnc_moduleAttack";
        functionPriority = 1;
        isGlobal = 1;
        isTriggerActivated = 1;
        isDisposable = 0;
        is3DEN = 0;

        class Arguments: ArgumentsBaseUnits {
            class attackLocType{
                displayName = CSTRING(AttackLocType);
                description = CSTRING(AttackLocType_Desc);
                typeName = "STRING";
                class values {
                    class moduleLoc {
                        name = CSTRING(ModuleLoc);
                        value = "";
                        default = 1;
                    };
                    class objectLoc {
                        name = CSTRING(ObjectLoc);
                        value = "OBJECT";
                    };
                    class groupLoc {
                        name = CSTRING(GroupLoc);
                        value = "GROUP";
                    };
                    class arrayLoc {
                        name = CSTRING(ArrayLoc);
                        value = "ARRAY";
                    };
                    class markerLoc {
                        name = CSTRING(MarkerLoc);
                        value = "MARKER";
                    };
                    class taskLoc {
                        name = CSTRING(TaskLoc);
                        value = "TASK";
                    };
                };
            };

            class attackPosition {
                displayName = CSTRING(AttackPosition);
                description = CSTRING(AttackPosition_Desc);
                typeName = "STRING";
            };

            class searchRadius {
                displayName = CSTRING(SearchRadius);
                description = CSTRING(SearchRadius_Desc);
                typeName = "NUMBER";
                defaultValue = 0;
            };

            class allowOverride {
                displayName = CSTRING(AllowOverride);
                description = CSTRING(AllowOverride_Desc);
                typeName = "BOOL";
                defaultValue = 0;
            };
        };

        class ModuleDescription: ModuleDescription {
            description = CSTRING(AttackModuleDescription);
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
        displayName = CSTRING(Defend);
        author = "WiredTiger";
        vehicleClass = "Modules";
        category = "CBA_Modules";
        function = "CBA_fnc_moduleDefend";
        functionPriority = 1;
        isGlobal = 1;
        isTriggerActivated = 1;
        isDisposable = 0;
        is3DEN = 0;

        class Arguments: ArgumentsBaseUnits {
            class defendLocType {
                displayName = CSTRING(DefendPositionType);
                description = CSTRING(DefendPositionType_Desc);
                typeName = "STRING";
                class values {
                    class setLoc {
                        name = CSTRING(ModuleLoc);
                        value = "";
                        default = 1;
                    };
                    class objectLoc {
                        name = CSTRING(ObjectLoc);
                        value = "OBJECT";
                    };
                    class groupLoc {
                        name = CSTRING(GroupLoc);
                        value = "GROUP";
                    };
                    class arrayLoc {
                        name = CSTRING(ArrayLoc);
                        value = "ARRAY";
                    };
                    class markerLoc {
                        name = CSTRING(MarkerLoc);
                        value = "MARKER";
                    };
                    class taskLoc {
                        name = CSTRING(TaskLoc);
                        value = "TASK";
                    };
                };
            };

            class defendPosition {
                displayName = CSTRING(DefendPosition);
                description = CSTRING(DefendPosition_Desc);
                typeName = "STRING";
            };

            class defendRadius {
                displayName = CSTRING(DefendRadius);
                description = CSTRING(DefendRadius_Desc);
                typeName = "NUMBER";
                defaultValue = 25;
            };

            class threshold {
                displayName = CSTRING(Threshold);
                description = CSTRING(Threshold_Desc);
                typeName = "NUMBER";
                class values {
                    class one {
                        name = "1";
                        value = 1;
                    };
                    class two {
                        name = "2";
                        value = 2;
                    };
                    class three {
                        name = "3";
                        value = 3;
                        default = 1;
                    };
                    class four {
                        name = "4";
                        value = 4;
                    };
                    class five {
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
                displayName = CSTRING(CanPatrol);
                description = CSTRING(CanPatrol_Desc);
                typeName = "NUMBER";
                defaultValue = 0.1;
            };

            class shouldHold {
                displayName = CSTRING(ShouldHold);
                description = CSTRING(ShouldHold_Desc);
                typeName = "NUMBER";
                defaultValue = 0;
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
        displayName = CSTRING(Patrol);
        author = "WiredTiger";
        vehicleClass = "Modules";
        category = "CBA_Modules";
        function = "CBA_fnc_modulePatrol";
        functionPriority = 1;
        isGlobal = 1;
        isTriggerActivated = 1;
        isDisposable = 0;
        is3DEN = 0;

        class Arguments: ArgumentsBaseUnits {
            class patrolLocType {
                displayName = CSTRING(PatrolCenterType);
                description = CSTRING(PatrolCenterType_Desc);
                typeName = "STRING";
                class values {
                    class setLoc {
                        name = CSTRING(ModuleLoc);
                        value = "";
                        default = 1;
                    };
                    class objectLoc {
                        name = CSTRING(ObjectLoc);
                        value = "OBJECT";
                    };
                    class groupLoc {
                        name = CSTRING(GroupLoc);
                        value = "GROUP";
                    };
                    class arrayLoc {
                        name = CSTRING(ArrayLoc);
                        value = "ARRAY";
                    };
                    class markerLoc {
                        name = CSTRING(MarkerLoc);
                        value = "MARKER";
                    };
                    class taskLoc {
                        name = CSTRING(TaskLoc);
                        value = "TASK";
                    };
                };
            };

            class patrolPosition {
                displayName = CSTRING(PatrolPosition);
                description = CSTRING(PatrolPosition_Desc);
                typeName = "STRING";
            };

            class patrolRadius {
                displayName = CSTRING(PatrolRadius);
                description = CSTRING(PatrolRadius_Desc);
                typeName = "NUMBER";
                defaultValue = 25;
            };

            class waypointCount {
                displayName = CSTRING(WaypointCount);
                description = CSTRING(WaypointCount_Desc);
                typeName = "NUMBER";
                defaultValue = 4;
            };

            class waypointType {
                displayName = CSTRING(WaypointType);
                description = CSTRING(WaypointType_Desc);
                typeName = "STRING";
                class values {
                    class move {
                        name = CSTRING(Move);
                        value = "MOVE";
                        default = 1;
                    };
                    class sad {
                        name = CSTRING(SAD);
                        value = "SAD";
                    };
                    class loiter {
                        name = CSTRING(Loiter);
                        value = "LOITER";
                    };
                };
            };

            class behaviour {
                displayName = CSTRING(Behaviour);
                description = CSTRING(Behaviour_Desc);
                typeName = "STRING";
                class values {
                    class careless {
                        name = "$str_combat_careless";
                        value = "CARELESS";
                        default = 1;
                    };
                    class safe {
                        name = "$str_combat_safe";
                        value = "SAFE";
                    };
                    class aware {
                        name = "$str_combat_aware";
                        value = "AWARE";
                    };
                    class combat {
                        name = "$str_combat_combat";
                        value = "COMBAT";
                    };
                    class stealth {
                        name = "$str_combat_stealth";
                        value = "STEALTH";
                    };
                };
            };

            class combatMode {
                displayName = CSTRING(CombatMode);
                description = CSTRING(CombatMode_Desc);
                typeName = "STRING";
                class values {
                    class yellow {
                        name = "$str_3den_attributes_combatmode_yellow_text";
                        value = "YELLOW";
                        default = 1;
                    };
                    class blue {
                        name = "$str_3den_attributes_combatmode_blue_text";
                        value = "BLUE";
                    };
                    class green {
                        name = "$str_3den_attributes_combatmode_green_text";
                        value = "GREEN";
                    };
                    class white {
                        name = "$str_3den_attributes_combatmode_white_text";
                        value = "WHITE";
                    };
                    class red {
                        name = "$str_3den_attributes_combatmode_red_text";
                        value = "RED";
                    };
                };
            };

            class speedMode {
                displayName = CSTRING(SpeedMode);
                description = CSTRING(SpeedMode_Desc);
                typeName = "STRING";
                class values {
                    class limited {
                        name = "$str_speed_limited";
                        value = "LIMITED";
                        default = 1;
                    };
                    class normal {
                        name = "$str_speed_normal";
                        value = "NORMAL";
                    };
                    class full {
                        name = "$str_speed_full";
                        value = "FULL";
                    };
                };
            };

            class formation {
                displayName = CSTRING(Formation);
                description = CSTRING(Formation_Desc);
                typeName = "STRING";
                class values {
                    class column {
                        name = "$str_column";
                        value = "COLUMN";
                        default = 1;
                    };
                    class stagColumn {
                        name = "$str_staggered";
                        value = "STAG COLUMN";
                    };
                    class wedge {
                        name = "$str_wedge";
                        value = "WEDGE";
                    };
                    class echLeft {
                        name = "$str_echl";
                        value = "ECH LEFT";
                    };
                    class echRight {
                        name = "$str_echr";
                        value = "ECH RIGHT";
                    };
                    class vee {
                        name = "$str_vee";
                        value = "VEE";
                    };
                    class line {
                        name = "$str_line";
                        value = "LINE";
                    };
                    class file {
                        name = "$str_file";
                        value = "FILE";
                    };
                    class diamond {
                        name = "$str_diamond";
                        value = "DIAMOND";
                    };
                };
            };

            class executableCode {
                displayName = CSTRING(ExecutableCode);
                description = CSTRING(ExecutableCode_Desc);
                typeName = "STRING";
            };

            class timeout {
                displayName = CSTRING(Timeout);
                description = CSTRING(Timeout_Desc);
                typeName = "STRING";
                defaultValue = "[1,5,10]";
            };
        };

        class ModuleDescription: ModuleDescription {
            description = CSTRING(PatrolModuleDescription);
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

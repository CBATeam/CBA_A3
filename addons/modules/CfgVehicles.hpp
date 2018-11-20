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
                displayName = "$STR_3DEN_GROUP_ATTRIBUTE_BEHAVIOUR_DISPLAYNAME";
                description = "$STR_3DEN_GROUP_ATTRIBUTE_BEHAVIOUR_TOOLTIP";
                typeName = "STRING";
                class values {
                    class careless {
                        name = "$STR_COMBAT_CARELESS";
                        value = "CARELESS";
                        default = 1;
                    };
                    class safe {
                        name = "$STR_COMBAT_SAFE";
                        value = "SAFE";
                    };
                    class aware {
                        name = "$STR_COMBAT_AWARE";
                        value = "AWARE";
                    };
                    class combat {
                        name = "$STR_COMBAT_COMBAT";
                        value = "COMBAT";
                    };
                    class stealth {
                        name = "$STR_COMBAT_STEALTH";
                        value = "STEALTH";
                    };
                };
            };

            class combatMode {
                displayName = "$STR_3DEN_GROUP_ATTRIBUTE_COMBATMODE_DISPLAYNAME";
                description = "$STR_3DEN_GROUP_ATTRIBUTE_COMBATMODE_TOOLTIP";
                typeName = "STRING";
                class values {
                    class yellow {
                        name = "$STR_3DEN_ATTRIBUTES_COMBATMODE_YELLOW_TEXT";
                        value = "YELLOW";
                        default = 1;
                    };
                    class blue {
                        name = "$STR_3DEN_ATTRIBUTES_COMBATMODE_BLUE_TEXT";
                        value = "BLUE";
                    };
                    class green {
                        name = "$STR_3DEN_ATTRIBUTES_COMBATMODE_GREEN_TEXT";
                        value = "GREEN";
                    };
                    class white {
                        name = "$STR_3DEN_ATTRIBUTES_COMBATMODE_WHITE_TEXT";
                        value = "WHITE";
                    };
                    class red {
                        name = "$STR_3DEN_ATTRIBUTES_COMBATMODE_RED_TEXT";
                        value = "RED";
                    };
                };
            };

            class speedMode {
                displayName = "$STR_3DEN_GROUP_ATTRIBUTE_SPEEDMODE_DISPLAYNAME";
                description = "$STR_3DEN_GROUP_ATTRIBUTE_SPEEDMODE_TOOLTIP";
                typeName = "STRING";
                class values {
                    class limited {
                        name = "$STR_SPEED_LIMITED";
                        value = "LIMITED";
                        default = 1;
                    };
                    class normal {
                        name = "$STR_SPEED_NORMAL";
                        value = "NORMAL";
                    };
                    class full {
                        name = "$STR_SPEED_FULL";
                        value = "FULL";
                    };
                };
            };

            class formation {
                displayName = "$STR_3DEN_GROUP_ATTRIBUTE_FORMATION_DISPLAYNAME";
                description = "$STR_3DEN_GROUP_ATTRIBUTE_FORMATION_TOOLTIP";
                typeName = "STRING";
                class values {
                    class column {
                        name = "$STR_COLUMN";
                        value = "COLUMN";
                        default = 1;
                    };
                    class stagColumn {
                        name = "$STR_STAGGERED";
                        value = "STAG COLUMN";
                    };
                    class wedge {
                        name = "$STR_WEDGE";
                        value = "WEDGE";
                    };
                    class echLeft {
                        name = "$STR_ECHL";
                        value = "ECH LEFT";
                    };
                    class echRight {
                        name = "$STR_ECHR";
                        value = "ECH RIGHT";
                    };
                    class vee {
                        name = "$STR_VEE";
                        value = "VEE";
                    };
                    class line {
                        name = "$STR_LINE";
                        value = "LINE";
                    };
                    class file {
                        name = "$STR_FILE";
                        value = "FILE";
                    };
                    class diamond {
                        name = "$STR_DIAMOND";
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

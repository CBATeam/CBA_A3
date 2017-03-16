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
                        name = CSTRING(SetLoc);
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
                        default = 1;
                    };
                    class three {
                        name = "3";
                        value = 3;
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
                typeName = "BOOL";
                defaultValue = 1;
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
                        name = CSTRING(SetLoc);
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
                        name = CSTRING(Careless);
                        value = "CARELESS";
                        default = 1;
                    };
                    class safe {
                        name = CSTRING(Safe);
                        value = "SAFE";
                    };
                    class aware {
                        name = CSTRING(Aware);
                        value = "AWARE";
                    };
                    class combat {
                        name = CSTRING(Combat);
                        value = "COMBAT";
                    };
                    class stealth {
                        name = CSTRING(Stealth);
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
                        name = CSTRING(CombatYellow);
                        value = "YELLOW";
                        default = 1;
                    };
                    class blue {
                        name = CSTRING(CombatBlue);
                        value = "BLUE";
                    };
                    class green {
                        name = CSTRING(CombatGreen);
                        value = "GREEN";
                    };
                    class white {
                        name = CSTRING(CombatWhite);
                        value = "WHITE";
                    };
                    class red {
                        name = CSTRING(CombatRed);
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
                        name = CSTRING(SpeedLimited);
                        value = "LIMITED";
                        default = 1;
                    };
                    class normal {
                        name = CSTRING(SpeedNormal);
                        value = "NORMAL";
                    };
                    class full {
                        name = CSTRING(SpeedFull);
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
                        name = CSTRING(Column);
                        value = "COLUMN";
                        default = 1;
                    };
                    class stagColumn {
                        name = CSTRING(StagColumn);
                        value = "STAG COLUMN";
                    };
                    class wedge {
                        name = CSTRING(Wedge);
                        value = "WEDGE";
                    };
                    class echLeft {
                        name = CSTRING(EchLeft);
                        value = "ECH LEFT";
                    };
                    class echRight {
                        name = CSTRING(EchRight);
                        value = "ECH RIGHT";
                    };
                    class vee {
                        name = CSTRING(Vee);
                        value = "VEE";
                    };
                    class line {
                        name = CSTRING(Line);
                        value = "LINE";
                    };
                    class file {
                        name = CSTRING(File);
                        value = "FILE";
                    };
                    class diamond {
                        name = CSTRING(Diamond);
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

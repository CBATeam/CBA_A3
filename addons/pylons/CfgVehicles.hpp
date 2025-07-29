#include "hardpoints.hpp"
class DefaultVehicleSystemsDisplayManagerLeft;
class DefaultVehicleSystemsDisplayManagerRight;

class CfgVehicles {
    class LandVehicle;
    class StaticWeapon: LandVehicle {
        class Turrets;
    };
    class StaticMGWeapon: StaticWeapon {
        class Turrets: Turrets {
            class MainTurret;
        };
    };
    class GVAR(pylon_base): StaticMGWeapon {
        scope = 1;
        author = "$STR_CBA_Author";
        mapSize = 0;
        side = 1;
        faction = "CIV_F";
        crew = "C_UAV_AI";
        editorSubcategory = QGVAR(EdSubcat_pylons);
        _generalMacro = "";
        displayName = "Pylon";
        model = QPATHTOF(pylon_single.p3d);
        icon = "\a3\static_f_gamma\data\UI\map_StaticTurret_AA_CA.paa";
        hasDriver = 0;
        vehicleClass = "Autonomous";
        isUav = 1;
        destrType = "DestructDefault";
        memoryPointTaskMarker = "TaskMarker_1_pos";
        getInRadius = 0;
        cost = 0;
        class HitPoints {};
        threat[] = {0, 0, 0};
        radarTargetSize = 0;
        visualTargetSize = 0;
        irTargetSize = 0;
        reportRemoteTargets = 1;
        reportOwnPosition = 1;
        maximumLoad = 0;
        uavCameraGunnerPos = "PiP_pos";
        uavCameraGunnerDir = "PiP_dir";

        class AnimationSources {};
        class Components;
        class Exhausts {};
        class Sounds {};
        class TransportItems {};
        class TransportMagazines {};
        class TransportWeapons {};
        class Turrets: Turrets {
            class MainTurret: MainTurret {
                minElev = -85;
                maxElev = 85;
                initElev = 0;
                minTurn = -360;
                maxTurn = 360;
                initTurn = 0;
                laserScanner = 1;
                showAllTargets = 4;
                enableManualFire = 1;
                stabilizedInAxes = 3;
                memoryPointGun = "PiP_pos";
                memoryPointGunnerOptics = "PiP_pos";
                isCopilot = 0;
                animationSourceBody = "MainTurret";
                animationSourceGun = "MainGun";
                body = "MainTurret";
                gun = "MainGun";
                weapons[] = {};
                magazines[] = {};
                commanding = -1;
                gunnerCompartments = "Compartment2";
                gunnerForceOptics = 1;
                gunnerOpticsModel = "\A3\Drones_F\Weapons_F_Gamma\Reticle\UGV_01_Optics_Gunner_F.p3d";
                outGunnerMayFire = 1;
                inGunnerMayFire = 1;
                primaryGunner = 1;
                soundServo[] = {"A3\Sounds_F\vehicles\air\noises\servo_drone_turret_2.wss", 0.1, 1, 10};
                soundServoVertical[] = {"A3\Sounds_F\vehicles\air\noises\servo_drone_turret_2.wss", 0.1, 1, 10};
                startEngine = 0;
                turretInfoType = "RscOptics_UAV_gunner";
                LODTurnedIn = -1;
                LODTurnedOut = -1;
                class OpticsIn {
                    class Wide {
                        initAngleX = 0;
                        minAngleX = -30;
                        maxAngleX = 30;
                        initAngleY = 0;
                        minAngleY = -100;
                        maxAngleY = 100;
                        initFov = 0.5;
                        minFov = 0.5;
                        maxFov = 0.5;
                        opticsDisplayName = "W";
                        directionStabilized = 1;
                        visionMode[] = {"Normal", "NVG", "Ti"};
                        thermalMode[] = {0, 1};
                        gunnerOpticsModel = "\A3\Drones_F\Weapons_F_Gamma\Reticle\UAV_Optics_Gunner_wide_F.p3d";
                    };
                    class Medium: Wide {
                        initFov = 0.1;
                        minFov = 0.1;
                        maxFov = 0.1;
                        opticsDisplayName = "M";
                        gunnerOpticsModel = "\A3\Drones_F\Weapons_F_Gamma\Reticle\UAV_Optics_Gunner_medium_F.p3d";
                    };
                    class Narrow: Wide {
                        initFov = 0.0286;
                        minFov = 0.0286;
                        maxFov = 0.0286;
                        opticsDisplayName = "N";
                        gunnerOpticsModel = "\A3\Drones_F\Weapons_F_Gamma\Reticle\UAV_Optics_Gunner_narrow_F.p3d";
                    };
                }; // OpticsIn
                class OpticsOut {
                    class Monocular {
                        initAngleX = 0;
                        minAngleX = -30;
                        maxAngleX = 30;
                        initAngleY = 0;
                        minAngleY = -100;
                        maxAngleY = 100;
                        initFov = 1.1;
                        minFov = 0.133;
                        maxFov = 1.1;
                        visionMode[] = {"Normal", "NVG"};
                        gunnerOpticsModel = "";
                        gunnerOpticsEffect[] = {};
                    };
                }; // OpticsOut
                class Components {
                    class VehicleSystemsDisplayManagerComponentLeft: DefaultVehicleSystemsDisplayManagerLeft {
                        class components {
                            class EmptyDisplay {
                                componentType = "EmptyDisplayComponent";
                            };
                            class MinimapDisplay {
                                componentType = "MinimapDisplayComponent";
                                resource = "RscCustomInfoAirborneMiniMap";
                            };
                            class UAVDisplay {
                                componentType = "UAVFeedDisplayComponent";
                            };
                            class SensorDisplay {
                                componentType = "SensorsDisplayComponent";
                                range[] = {4000, 2000, 1000, 8000};
                                resource = "RscCustomInfoSensors";
                            };
                        };
                    }; // VehicleSystemsDisplayManagerComponentLeft
                    class VehicleSystemsDisplayManagerComponentRight: DefaultVehicleSystemsDisplayManagerRight {
                        defaultDisplay = "SensorDisplay";
                        class components {
                            class EmptyDisplay {
                                componentType = "EmptyDisplayComponent";
                            };
                            class MinimapDisplay {
                                componentType = "MinimapDisplayComponent";
                                resource = "RscCustomInfoAirborneMiniMap";
                            };
                            class UAVDisplay {
                                componentType = "UAVFeedDisplayComponent";
                            };
                            class SensorDisplay {
                                componentType = "SensorsDisplayComponent";
                                range[] = {4000, 2000, 1000, 8000};
                                resource = "RscCustomInfoSensors";
                            };
                        };
                    }; // VehicleSystemsDisplayManagerComponentRight
                }; // Components
            }; // MainTurret
        }; // Turrets
        class UserActions {};

        ace_cargo_space = 0;
        ace_cargo_hasCargo = 0;
        ace_dragging_canDrag = 1;
        ace_dragging_canCarry = 1;
    }; // pylon_base

    class GVAR(camera_tgp): GVAR(pylon_base) {
        scope = 2;
        scopeCurator = 2;
        displayName = "Remote Camera (TGP)";

        class Turrets: Turrets {
            class MainTurret: MainTurret {
                weapons[] = {"Laserdesignator_mounted"};
                magazines[] = {"Laserbatteries"};
            };
        };
    }; // camera_tgp

    class GVAR(camera_turret): GVAR(camera_tgp) {
        displayName = "Remote Camera";

        class Components;
        class Turrets: Turrets {
            class MainTurret: MainTurret {
                weapons[] = {};
                magazines[] = {};
            };
        };
    }; // camera_turret

    class GVAR(camera_fixed): GVAR(camera_turret) {
        displayName = "Remote Camera (Fixed)";
        class Turrets: Turrets {
            class MainTurret: MainTurret {
                animationSourceBody = "";
                animationSourceGun = "";
            };
        };
    }; // camera_fixed

    class GVAR(pylon_single_tgp): GVAR(camera_tgp) {
        displayName = "Remote Pylon (TGP)";
        #include "AnimationSources.hpp"
        #include "Components_single.hpp"
    }; // pylon_single_turret

    class GVAR(pylon_single_turret): GVAR(camera_turret) {
        displayName = "Remote Pylon (Camera)";
        #include "AnimationSources.hpp"
        #include "Components_single.hpp"
    }; // pylon_single

    class GVAR(pylon_single_fixed): GVAR(camera_fixed) {
        displayName = "Remote Pylon";
        #include "AnimationSources.hpp"
        #include "Components_single.hpp"
    }; // pylon_single

    class GVAR(pylon_detached): GVAR(pylon_single_fixed)
    {
        scope = 1;
        displayName = "Pylon";
    };

    class GVAR(pylon_turret): GVAR(camera_turret) {
        displayName = "Remote Turret (Pylon)";
        model = QPATHTOF(pylon_turret.p3d);
        #include "AnimationSources.hpp"
        #include "Components_single.hpp"
    }; // pylon_turret

    class GVAR(pylon_turret_tgp): GVAR(camera_tgp) {
        displayName = "Remote Turret (Pylon, TGP)";
        model = QPATHTOF(pylon_turret.p3d);
        #include "AnimationSources.hpp"
        #include "Components_single.hpp"
    }; // pylon_turret_tgp

};

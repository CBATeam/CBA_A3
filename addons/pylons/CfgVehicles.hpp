#include "hardpoints.hpp"

class CfgVehicles {
    class LandVehicle;
    class StaticWeapon: LandVehicle {
        class Turrets;
    };
    class StaticMGWeapon: StaticWeapon {
        class Components;
        class Turrets: Turrets {
            class MainTurret;
        };
    };
    class GVAR(pylon_base): StaticMGWeapon {
        scope = 1;
        author = "$STR_CBA_Author";
        mapSize = 0;
        side = 3;
        faction = "CIV_F";
        crew = "C_UAV_AI_F";
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
        #include "Components_single.hpp"
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
                memoryPointGunnerOutOptics = "gunnerview";
                laserScanner = 1;
                showAllTargets = 4;
                enableManualFire = 1;
                stabilizedInAxes = 3;
            };
        };
        class UserActions {};
    }; // pylon_base

};

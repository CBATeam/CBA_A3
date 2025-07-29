class CfgWeapons
{
    class weapon_SDBLauncher;
    class GVAR(mortar_82mm): weapon_SDBLauncher {
        displayName = "82mm Mortar Shell";
        weaponLockDelay = 0.1;
        weaponLockSystem = "0";
        magazines[] = {QGVAR(PylonRack_Bomb_mortar_82mm)};
    };

    class rockets_230mm_GAT;
    class GVAR(6Rnd_230mm_rockets): rockets_230mm_GAT {
        magazines[] = {QGVAR(6Rnd_230mm_rockets), QGVAR(PylonRack_6Rnd_230mm_rockets)};
    };
    class GVAR(6Rnd_230mm_rockets_cluster): rockets_230mm_GAT {
        magazines[] = {QGVAR(6Rnd_230mm_rockets_cluster), QGVAR(PylonRack_6Rnd_230mm_rockets_cluster)};
    };

    class Rocket_03_HE_Plane_CAS_02_F;
    class GVAR(Rocket_03_HE): Rocket_03_HE_Plane_CAS_02_F {
        magazines[] = {QGVAR(PylonMissile_1Rnd_Rocket_03_HE)};
    };

    class weapon_mim145Launcher;
    class GVAR(weapon_mim145Launcher): weapon_mim145Launcher {
        magazines[] = {QGVAR(PylonRack_1Rnd_Missile_mim145)};
    };
    class weapon_s750Launcher;
    class GVAR(weapon_s750Launcher): weapon_s750Launcher {
        magazines[] = {QGVAR(PylonRack_1Rnd_Missile_s750)};
    };
    class weapon_rim162Launcher;
    class GVAR(weapon_rim162Launcher): weapon_rim162Launcher {
        magazines[] = {QGVAR(PylonRack_1Rnd_Missile_rim162)};
    };

    class weapon_VLS_01;
    class GVAR(weapon_VLS_01): weapon_VLS_01 {
        magazines[] = {QGVAR(PylonRack_1Rnd_Missile_Cruise_01), QGVAR(PylonRack_1Rnd_Missile_Cruise_01_Cluster)};
        magazineReloadTime = 0;
    };
};

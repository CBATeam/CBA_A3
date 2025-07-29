class CfgMagazines
{
    class 12Rnd_230mm_rockets;
    class 12Rnd_230mm_rockets_cluster;

    class GVAR(6Rnd_230mm_rockets): 12Rnd_230mm_rockets {
        count = 6;
    };
    class GVAR(PylonRack_6Rnd_230mm_rockets): GVAR(6Rnd_230mm_rockets) {
        displayName = "230mm 6x HE";
        model = QPATHTOF(data\pya_pylonRack_MRL.p3d);
        hardpoints[] = {"B_MISSILE_PYLON"};
        pylonWeapon = QGVAR(6Rnd_230mm_rockets);
        mass = 500;
    };

    class GVAR(6Rnd_230mm_rockets_cluster): 12Rnd_230mm_rockets_cluster {
        count = 6;
    };
    class GVAR(PylonRack_6Rnd_230mm_rockets_cluster): GVAR(6Rnd_230mm_rockets_cluster) {
        displayName = "230mm 6x Cluster";
//        descriptionShort = "Unguided rockets with cluster warhead";
        model = QPATHTOF(data\pya_pylonRack_MRL.p3d);
        hardpoints[] = {"pya_hardpoint", "B_MISSILE_PYLON"};
        pylonWeapon = QGVAR(6Rnd_230mm_rockets_cluster);
        mass = 500;
    };

    class PylonMissile_1Rnd_Missile_AA_04_F;
    class GVAR(PylonMissile_1Rnd_Rocket_03_HE): PylonMissile_1Rnd_Missile_AA_04_F {
        displayName = "Tratnyr 1x HE";
        hardpoints[] = {"pya_hardpoint"};
        pylonWeapon = QGVAR(Rocket_03_HE);
        ammo = "Rocket_03_HE_F";
        mass = 10;
    };

    class magazine_Missile_mim145_x4;
    class GVAR(PylonRack_1Rnd_Missile_mim145): magazine_Missile_mim145_x4 {
        count = 1;
        model = "\A3\Weapons_F\DynamicLoadout\PylonPod_1x_Missile_AA_04_F.p3d";
        hardpoints[] = {"pya_hardpoint", "B_MISSILE_PYLON", "B_HARM_RAIL"};
        pylonWeapon = QGVAR(weapon_mim145Launcher);
        mass = 315; // MIM-104F PAC-3
    };

    class magazine_Missile_s750_x4;
    class GVAR(PylonRack_1Rnd_Missile_s750): magazine_Missile_s750_x4 {
        count = 1;
        model = "\A3\Weapons_F\DynamicLoadout\PylonPod_1x_Missile_AA_04_F.p3d";
        hardpoints[] = {"pya_hardpoint", "B_MISSILE_PYLON", "B_HARM_RAIL"};
        pylonWeapon = QGVAR(weapon_s750Launcher);
        mass = 315; // MIM-104F PAC-3
    };

    class magazine_Missile_rim162_x8;
    class GVAR(PylonRack_1Rnd_Missile_rim162): magazine_Missile_rim162_x8 {
        count = 1;
        model = "\A3\Weapons_F\DynamicLoadout\PylonPod_1x_Missile_AA_04_F.p3d";
        hardpoints[] = {"pya_hardpoint", "B_MISSILE_PYLON", "B_HARM_RAIL"};
        pylonWeapon = QGVAR(weapon_rim162Launcher);
        mass = 100;
    };

    class magazine_Missiles_Cruise_01_x18;
    class GVAR(PylonRack_1Rnd_Missile_Cruise_01): magazine_Missiles_Cruise_01_x18 {
        ammo = QGVAR(ammo_Missile_Cruise_01);
        count = 1;
        model = QPATHTOF(data\pya_pylonRack_Cruise_01.p3d);
        hardpoints[] = {"pya_hardpoint", "B_MISSILE_PYLON", "B_HARM_RAIL"};
        pylonWeapon = QGVAR(weapon_VLS_01);
        mass = 100;
    };
    class magazine_Missiles_Cruise_01_Cluster_x18;
    class GVAR(PylonRack_1Rnd_Missile_Cruise_01_Cluster): magazine_Missiles_Cruise_01_Cluster_x18 {
        ammo = QGVAR(ammo_Missile_Cruise_01_Cluster);
        count = 1;
        model = QPATHTOF(data\pya_pylonRack_Cruise_01.p3d);
        hardpoints[] = {"pya_hardpoint", "B_MISSILE_PYLON", "B_HARM_RAIL"};
        pylonWeapon = QGVAR(weapon_VLS_01);
        mass = 100;
    };

    class magazine_Bomb_SDB_x1;
    class GVAR(PylonRack_Bomb_mortar_82mm): magazine_Bomb_SDB_x1 {
        ammo = QGVAR(Sh_82mm_AMOS);
        displayName = "82mm HE Mortar Shell";
        displayNameShort = "HE";
        descriptionShort = "82mm High-Explosive Mortar Shell";
        model = QPATHTOF(data\pya_pylonRack_82mm_Mortar_Shell.p3d);
        hardpoints[] = {"pya_hardpoint", "B_MISSILE_PYLON", "ANTIMINE_DRONE_PYLON"};
        pylonWeapon = QGVAR(mortar_82mm);
        mass = 3;
    };

};

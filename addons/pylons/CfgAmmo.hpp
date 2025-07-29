class CfgAmmo
{
    class ammo_Missile_Cruise_01;
    class GVAR(ammo_Missile_Cruise_01): ammo_Missile_Cruise_01 {
        proxyShape = "a3\weapons_f_destroyer\Ammo\Missile_Cruise_01_F.p3d";
    };
    class ammo_Missile_Cruise_01_Cluster;
    class GVAR(ammo_Missile_Cruise_01_Cluster): ammo_Missile_Cruise_01_Cluster {
        proxyShape = "a3\weapons_f_destroyer\Ammo\Missile_Cruise_01_F.p3d";
    };
    class Bo_Mk82;
    class GVAR(Sh_82mm_AMOS): Bo_Mk82 {
        proxyShape = "\A3\weapons_f\ammo\shell";
        hit = 165;
        indirectHit = 52;
        indirectHitRange = 18;
        cost = 200;
        muzzleEffect = "";
        soundHit1[] = {"A3\Sounds_F\arsenal\explosives\shells\Artillery_tank_shell_155mm_explosion_01.wss", 2.51189, 1, 1900};
        soundHit2[] = {"A3\Sounds_F\arsenal\explosives\shells\Artillery_tank_shell_155mm_explosion_02.wss", 2.51189, 1, 1900};
        soundHit3[] = {"A3\Sounds_F\arsenal\explosives\shells\Artillery_tank_shell_155mm_explosion_03.wss", 2.51189, 1, 1900};
        soundHit4[] = {"A3\Sounds_F\arsenal\explosives\shells\Artillery_tank_shell_155mm_explosion_04.wss", 2.51189, 1, 1900};
        multiSoundHit[] = {"soundHit1", 0.25, "soundHit2", 0.25, "soundHit3", 0.25, "soundHit4", 0.25};
        CraterEffects = "ArtyShellCrater";
        ExplosionEffects = "MortarExplosion";
        whistleDist = 60;
        SoundSetExplosion[] = {"Mortar_Exp_SoundSet", "Mortar_Tail_SoundSet", "Explosion_Debris_SoundSet"};
        ace_frag_charge = 420;
        ace_frag_metal = 2680;
        ace_frag_classes[] = {"ace_frag_medium", "ace_frag_medium_HD"};
        ace_rearm_caliber = 82;
        ace_vehicle_damage_incendiary = 0.1;
    };
}; // CfgAmmo

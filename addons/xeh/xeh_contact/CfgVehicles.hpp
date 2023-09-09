class CfgVehicles {
    class B_W_Soldier_F;
    class B_W_Story_Protagonist_01_F: B_W_Soldier_F {
        XEH_ENABLED;
    };
    class B_W_Story_Major_01_F: B_W_Soldier_F {
        XEH_ENABLED;
    };
    class B_W_Story_Instructor_01_F: B_W_Soldier_F {
        XEH_ENABLED;
    };
    class B_W_Story_Soldier_01_F: B_W_Soldier_F {
        XEH_ENABLED;
    };
    class B_W_Story_Leader_01_F: B_W_Soldier_F {
        XEH_ENABLED;
    };

    class Logic;
    class VirtualAISquad: Logic {
        XEH_ENABLED;
    };

    class Thing;
    class Particle_Base_F: Thing {
        XEH_ENABLED;
    };

    class Alien_Extractor_01_base_F;
    class Alien_Extractor_01_generic_base_F: Alien_Extractor_01_base_F {
        XEH_ENABLED;
    };

    class ThingX;
    class Alien_MatterBall_01_base_F: ThingX {
        XEH_ENABLED;
    };
    class Alien_MatterBall_01_falling_F: Alien_MatterBall_01_base_F {
        XEH_ENABLED;
    };
};

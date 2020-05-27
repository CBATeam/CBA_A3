#define UNLOCK_MALARIA_INFECTED_CIVILIAN  \
    editorSubcategory = "EdSubcat_Personnel_MalariaInfected"; \
    scope = 2; \
    scopeCurator = 2; \
    class EventHandlers { \
        init = "(_this select 0) setIdentity selectRandom [ \
            'BIS_Ambient01_sick', \
            'BIS_Ambient02_sick', \
            'BIS_Ambient03_sick', \
            'BIS_Arthur_sick', \
            'BIS_Howard_sick', \
            'BIS_John_sick', \
            'BIS_Lucas_sick', \
            'BIS_Renly_sick' \
        ]; \
        (_this select 0) setDamage 0.45"; \
    }

class CfgVehicles {
    class C_Man_casual_1_F_afro;
    class C_Man_casual_1_F_afro_sick: C_Man_casual_1_F_afro {
       UNLOCK_MALARIA_INFECTED_CIVILIAN;
    };

    class C_Man_casual_3_F_afro;
    class C_Man_casual_3_F_afro_sick: C_Man_casual_3_F_afro {
       UNLOCK_MALARIA_INFECTED_CIVILIAN;
    };

    class C_Man_casual_4_F_afro;
    class C_Man_casual_4_F_afro_sick: C_Man_casual_4_F_afro {
       UNLOCK_MALARIA_INFECTED_CIVILIAN;
    };

    class C_Man_casual_5_F_afro;
    class C_Man_casual_5_F_afro_sick: C_Man_casual_5_F_afro {
       UNLOCK_MALARIA_INFECTED_CIVILIAN;
    };

    class C_Man_casual_6_F_afro;
    class C_Man_casual_6_F_afro_sick: C_Man_casual_6_F_afro {
       UNLOCK_MALARIA_INFECTED_CIVILIAN;
    };

    class C_man_polo_1_F_afro;
    class C_man_polo_1_F_afro_sick: C_man_polo_1_F_afro {
       UNLOCK_MALARIA_INFECTED_CIVILIAN;
    };

    class C_man_polo_2_F_afro;
    class C_man_polo_2_F_afro_sick: C_man_polo_2_F_afro {
       UNLOCK_MALARIA_INFECTED_CIVILIAN;
    };

    class C_man_polo_3_F_afro;
    class C_man_polo_3_F_afro_sick: C_man_polo_3_F_afro {
       UNLOCK_MALARIA_INFECTED_CIVILIAN;
    };

    class C_man_polo_6_F_afro;
    class C_man_polo_6_F_afro_sick: C_man_polo_6_F_afro {
       UNLOCK_MALARIA_INFECTED_CIVILIAN;
    };

    class C_man_sport_2_F_afro;
    class C_man_sport_2_F_afro_sick: C_man_sport_2_F_afro {
       UNLOCK_MALARIA_INFECTED_CIVILIAN;
    };
};

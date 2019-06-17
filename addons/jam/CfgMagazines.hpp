class CfgMagazines {
    class CA_Magazine;
    class 150Rnd_762x51_Box: CA_Magazine {
        descriptionShort = "$STR_CBA_JAM_150rnd_762x51_box_description";
    };

    class 150Rnd_762x51_Box_Tracer: 150Rnd_762x51_Box {
        descriptionShort = "$STR_CBA_JAM_150rnd_762x51_box_tracer_description";
    };

    class 150Rnd_762x54_Box: 150Rnd_762x51_Box {
        descriptionShort = "$STR_A3_CfgMagazines_150Rnd_762x51_Box_Tracer1"; // Was inherited from 150Rnd_762x51_Box in vanilla
    };
};

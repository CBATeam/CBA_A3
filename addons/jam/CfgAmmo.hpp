class CfgAmmo {

    class B_556x45_Ball;

    class CBA_B_556x45_M855: B_556x45_Ball {
        model = "\A3\Weapons_f\Data\bullettracer\tracer_red";
    };

    class CBA_B_556x45_M855A1: CBA_B_556x45_M855 {                      // EPR, HLC
        hit = 8.114581;
        typicalSpeed = 905.256;
        airFriction = -0.0011543788;
        caliber = 0.855;
        deflecting = 21;
    };

    class CBA_B_556x45_M856A1: CBA_B_556x45_M855A1 {                    // EPR Tracer
        nvgOnly = 0;
    };

    class CBA_B_556x45_Mk262: CBA_B_556x45_M855 {                       // SPR, ACE
        hit = 11;
        typicalSpeed = 836;
        airFriction = -0.00109563;
        caliber = 0.8;
        deflecting = 18;
    };

    class CBA_B_556x45_Mk318: CBA_B_556x45_M855 {                       // SOST, ACE
        hit = 9;
        typicalSpeed = 886;
        airFriction = -0.00123318;
        caliber = 0.8;
        deflecting = 18;
    };

    class CBA_B_556x45_M995: CBA_B_556x45_M855 {                        // AP, ACE
        hit = 6;
        typicalSpeed = 869;
        airFriction = -0.00123272;
        caliber = 1.6;
        deflecting = 18;
    };

    class CBA_B_556x45_M996: CBA_B_556x45_M855 {                        // IR-DIM Tracer
        nvgOnly = 1;
    };




    class B_762x51_Ball;
    class CBA_B_762x51_M80A1: B_762x51_Ball {
        hit = 10.038876;
        typicalSpeed = 938.784;
        airFriction = -0.00083981;
        caliber = 1.075;
        deflecting = 21;
    };
    class CBA_B_762x51_Mk316: B_762x51_Ball {
        hit = 15.153877;
        typicalSpeed = 804.672;
        airFriction = -0.00077031;
        caliber = 0.449;
        deflecting = 18;
    };
    class CBA_B_762x51_LFMJBTSUB: B_762x51_Ball {
        hit = 5.7958393;
        typicalSpeed = 359.664;
        airFriction = -0.00057641;
        caliber = 0.649;
        deflecting = 15;
        audibleFire = 1;
        dangerRadiusBulletClose = 1;
        suppressionRadiusBulletClose = 1;
    };

    class B_9x21_Ball;
    class CBA_B_9x19_Ball : B_9x21_Ball {
        hit = 6;
        typicalSpeed = 370;
        airFriction = -0.0018577;
    };

};

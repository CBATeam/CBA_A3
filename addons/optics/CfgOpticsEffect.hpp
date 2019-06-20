class CfgOpticsEffect {
    class CBA_OpticsRadBlur1 {
        type = "radialblur";
        params[] = {0.005,0.005,"0.35/(getResolution select 4)",0.35};
        priority = 950;
    };
    class CBA_OpticsRadBlur2 {
        type = "radialblur";
        params[] = {0.01,0.01,"0.35/(getResolution select 4)",0.35};
        priority = 950;
    };
    class CBA_OpticsRadBlur3 {
        type = "radialblur";
        params[] = {0.015,0.015,"0.35/(getResolution select 4)",0.35};
        priority = 950;
    };
};

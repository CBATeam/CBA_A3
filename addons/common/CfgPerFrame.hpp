
class RscMapControl {
    class Task;
    class CustomMark;
    class Legend;
    class Bunker;
    class Bush;
    class Busstop;
    class Command;
    class Cross;
    class Fortress;
    class Fuelstation;
    class Fountain;
    class Hospital;
    class Chapel;
    class Church;
    class Lighthouse;
    class Quay;
    class Rock;
    class Ruin;
    class SmallTree;
    class Stack;
    class Tree;
    class Tourism;
    class Transmitter;
    class ViewTower;
    class WaterTower;
    class Waypoint;
    class WaypointCompleted;
    class ActiveMarker;
};

class CBA_Dummy_Map: RscMapControl {
    idc = -1;

    type=100;
    style=48;

    x = -10;
    y = -10;
    w = 1;
    h = 1;

    colorBackground[] = {1.00, 1.00, 1.00, 0};
    colorText[] = {0.00, 0.00, 0.00, 0};
    colorSea[] = {0.56, 0.80, 0.98, 0};
    colorForest[] = {0.60, 0.80, 0.20, 0};
    colorRocks[] = {0.50, 0.50, 0.50, 0};
    colorCountlines[] = {0.65, 0.45, 0.27, 0};
    colorMainCountlines[] = {0.65, 0.45, 0.27, 0};
    colorCountlinesWater[] = {0.00, 0.53, 1.00, 0};
    colorMainCountlinesWater[] = {0.00, 0.53, 1.00, 0};
    colorForestBorder[] = {0.40, 0.80, 0.00, 0};
    colorRocksBorder[] = {0.50, 0.50, 0.50, 0};
    colorPowerLines[] = {0.00, 0.00, 0.00, 0};
    colorNames[] = {0.00, 0.00, 0.00, 0};
    colorInactive[] = {1.00, 1.00, 1.00, 0};
    colorLevels[] = {0.00, 0.00, 0.00, 0};
    colorRailWay[] = {0.00, 0.00, 0.00, 0};
    colorOutside[] = {0.56, 0.80, 0.98, 0};

    font = "TahomaB";
    sizeEx = 0.00;

    stickX[] = {0.0, {"Gamma", 1.00, 1.50} };
    stickY[] = {0.0, {"Gamma", 1.00, 1.50} };
    ptsPerSquareSea = 0;
    ptsPerSquareTxt = 0;
    ptsPerSquareCLn = 0;
    ptsPerSquareExp = 0;
    ptsPerSquareCost = 0;
    ptsPerSquareFor = "0f";
    ptsPerSquareForEdge = "0f";
    ptsPerSquareRoad = 0;
    ptsPerSquareObj = 0;

    fontLabel = "PuristaMedium";
    sizeExLabel = 0.0;
    fontGrid = "PuristaMedium";
    sizeExGrid = 0.0;
    fontUnits = "PuristaMedium";
    sizeExUnits = 0.0;
    fontNames = "PuristaMedium";
    sizeExNames = 0.0;
    fontInfo = "PuristaMedium";
    sizeExInfo = 0.0;
    fontLevel = "PuristaMedium";
    sizeExLevel = 0.0;
    scaleMax = 1;
    scaleMin = 0.125;
    text = "";

    maxSatelliteAlpha = 0;     // Alpha to 0 by default
    alphaFadeStartScale = 1.0;
    alphaFadeEndScale = 1.1;   // Prevent div/0

    showCountourInterval=1;
    scaleDefault = 2;

    class Task: Task {
        //icon = "\A3\ui_f\data\map\mapcontrol\taskIcon_CA.paa";
        color[] = {1, 0.537000, 0, 0};
        size = 27;
        importance = 1;
        coefMin = 1;
        coefMax = 1;
        iconCreated = "";
        iconCanceled = "";
        iconDone = "";
        iconFailed = "";
        colorCreated[] = {1, 1, 1, 0};
        colorCanceled[] = {1, 1, 1, 0};
        colorDone[] = {1, 1, 1, 0};
        colorFailed[] = {1, 1, 1, 0};
    };

    class CustomMark: CustomMark {
        //icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
        color[] = {0.647100, 0.670600, 0.623500, 0};
        size = 18;
        importance = 1;
        coefMin = 1;
        coefMax = 1;
    };

    class Legend: Legend {
        x = "SafeZoneX";
        y = "SafeZoneY";
        w = 0.340000;
        h = 0.152000;
        font = "PuristaMedium";
        sizeEx = 0.039210;
        colorBackground[] = {0.906000, 0.901000, 0.880000, 0};
        color[] = {0, 0, 0, 0};
    };

    class Bunker: Bunker {
        //icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
        color[] = {0.550000, 0.640000, 0.430000, 0};
        size = 14;
        importance = "1.5 * 14 * 0.05";
        coefMin = 0.250000;
        coefMax = 4;
    };

    class Bush: Bush {
        //icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
        color[] = {0.450000, 0.640000, 0.330000, 0.0};
        size = 14;
        importance = "0.2 * 14 * 0.05";
        coefMin = 0.250000;
        coefMax = 4;
    };

    class BusStop: BusStop {
        //icon = "\A3\ui_f\data\map\mapcontrol\busstop_ca.paa";
        color[] = {0.150000, 0.260000, 0.870000, 0};
        size = 12;
        importance = "1 * 10 * 0.05";
        coefMin = 0.250000;
        coefMax = 4;
    };

    class Command: Command {
        //icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
        color[] = {0, 0.900000, 0, 0};
        size = 18;
        importance = 1;
        coefMin = 1;
        coefMax = 1;
    };

    class Cross: Cross {
        //icon = "\A3\ui_f\data\map\mapcontrol\cross_ca.paa";
        size = 16;
        color[] = {0, 0.900000, 0, 0};
        importance = "0.7 * 16 * 0.05";
        coefMin = 0.250000;
        coefMax = 4;
    };

    class Fortress: Fortress {
        //icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
        size = 16;
        color[] = {0, 0.900000, 0, 0};
        importance = "2 * 16 * 0.05";
        coefMin = 0.250000;
        coefMax = 4;
    };

    class Fuelstation: Fuelstation {
        //icon = "\A3\ui_f\data\map\mapcontrol\fuelstation_ca.paa";
        size = 16;
        color[] = {0, 0.900000, 0, 0};
        importance = "2 * 16 * 0.05";
        coefMin = 0.750000;
        coefMax = 4;
    };

    class Fountain: Fountain {
        //icon = "\A3\ui_f\data\map\mapcontrol\fountain_ca.paa";
        color[] = {0.200000, 0.450000, 0.700000, 0};
        size = 11;
        importance = "1 * 12 * 0.05";
        coefMin = 0.250000;
        coefMax = 4;
    };

    class Hospital: Hospital {
        //icon = "\A3\ui_f\data\map\mapcontrol\hospital_ca.paa";
        color[] = {0.780000, 0, 0.050000, 0};
        size = 16;
        importance = "2 * 16 * 0.05";
        coefMin = 0.500000;
        coefMax = 4;
    };

    class Chapel: Chapel {
        //icon = "\A3\ui_f\data\map\mapcontrol\chapel_ca.paa";
        color[] = {0.550000, 0.640000, 0.430000, 0};
        size = 16;
        importance = "1 * 16 * 0.05";
        coefMin = 0.900000;
        coefMax = 4;
    };

    class Church: Church {
        //icon = "\A3\ui_f\data\map\mapcontrol\church_ca.paa";
        size = 16;
        color[] = {0, 0.900000, 0, 0};
        importance = "2 * 16 * 0.05";
        coefMin = 0.900000;
        coefMax = 4;
    };

    class Lighthouse: Lighthouse {
        //icon = "\A3\ui_f\data\map\mapcontrol\lighthouse_ca.paa";
        size = 14;
        color[] = {0, 0.900000, 0, 0};
        importance = "3 * 16 * 0.05";
        coefMin = 0.900000;
        coefMax = 4;
    };

    class Quay: Quay {
        //icon = "\A3\ui_f\data\map\mapcontrol\quay_ca.paa";
        size = 16;
        color[] = {0, 0.900000, 0, 0};
        importance = "2 * 16 * 0.05";
        coefMin = 0.500000;
        coefMax = 4;
    };

    class Rock: Rock {
        //icon = "\A3\ui_f\data\map\mapcontrol\rock_ca.paa";
        color[] = {0.100000, 0.100000, 0.100000, 0.0};
        size = 12;
        importance = "0.5 * 12 * 0.05";
        coefMin = 0.250000;
        coefMax = 4;
    };

    class Ruin: Ruin {
        //icon = "\A3\ui_f\data\map\mapcontrol\ruin_ca.paa";
        size = 16;
        color[] = {0, 0.900000, 0, 0};
        importance = "1.2 * 16 * 0.05";
        coefMin = 1;
        coefMax = 4;
    };

    class SmallTree: SmallTree {
        //icon = "\A3\ui_f\data\map\mapcontrol\smalltree_ca.paa";
        color[] = {0.450000, 0.640000, 0.330000, 0.0};
        size = 12;
        importance = "0.6 * 12 * 0.05";
        coefMin = 0.250000;
        coefMax = 4;
    };

    class Stack: Stack {
        //icon = "\A3\ui_f\data\map\mapcontrol\stack_ca.paa";
        size = 20;
        color[] = {0, 0.900000, 0, 0};
        importance = "2 * 16 * 0.05";
        coefMin = 0.900000;
        coefMax = 4;
    };

    class Tree: Tree {
        //icon = "\A3\ui_f\data\map\mapcontrol\tree_ca.paa";
        color[] = {0.450000, 0.640000, 0.330000, 0.0};
        size = 12;
        importance = "0.9 * 16 * 0.05";
        coefMin = 0.250000;
        coefMax = 4;
    };

    class Tourism: Tourism {
        //icon = "\A3\ui_f\data\map\mapcontrol\tourism_ca.paa";
        color[] = {0.780000, 0, 0.050000, 0};
        size = 16;
        importance = "1 * 16 * 0.05";
        coefMin = 0.700000;
        coefMax = 4;
    };

    class Transmitter: Transmitter {
        //icon = "\A3\ui_f\data\map\mapcontrol\transmitter_ca.paa";
        color[] = {0, 0.900000, 0, 0};
        size = 20;
        importance = "2 * 16 * 0.05";
        coefMin = 0.900000;
        coefMax = 4;
    };

    class ViewTower: ViewTower {
        //icon = "\A3\ui_f\data\map\mapcontrol\viewtower_ca.paa";
        color[] = {0, 0.900000, 0, 0};
        size = 16;
        importance = "2.5 * 16 * 0.05";
        coefMin = 0.500000;
        coefMax = 4;
    };

    class Watertower: Watertower {
        //icon = "\A3\ui_f\data\map\mapcontrol\watertower_ca.paa";
        color[] = {0.200000, 0.450000, 0.700000, 0};
        size = 20;
        importance = "1.2 * 16 * 0.05";
        coefMin = 0.900000;
        coefMax = 4;
    };

    class Waypoint: Waypoint {
        //icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
        color[] = {0, 0.350000, 0.700000, 0};
        size = 16;
        importance = "2.5 * 16 * 0.05";
        coefMin = 0.500000;
        coefMax = 4;
    };

    class WaypointCompleted: WaypointCompleted {
        //icon = "\A3\ui_f\data\map\mapcontrol\waypoint_completed_ca.paa";
        color[] = {0, 0.350000, 0.700000, 0};
        size = 16;
        importance = "2.5 * 16 * 0.05";
        coefMin = 0.500000;
        coefMax = 4;
    };

    class ActiveMarker: ActiveMarker {
        color[] = {0.300000, 0.100000, 0.900000, 0};
        size = 50;
    };
};

class RscTitles {
    class CBA_FrameHandlerTitle {
        idd = 40121;
        movingEnable = 1;
        enableSimulation = 1;
        enableDisplay = 1;

        onLoad = QUOTE(_this call FUNC(perFrameEngine));

        duration = 99999999;
        fadein  = 0;
        fadeout = 0;
        name = "CBA_FrameHandlerTitle";
        class controlsBackground {
            class dummy_map: CBA_Dummy_Map {
                idc = 40122;
                x = -10;
                y = -10;
                w = 0;
                h = 0;
            };
        };
        class objects {};
        class controls {};
    };
};

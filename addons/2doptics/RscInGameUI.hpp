class RscOpticsValue;
class RscPicture;
class RscText;
class RscControlsGroupNoScrollbars;

class RscInGameUI {
    class RscUnitInfo;
    class RscWeaponZeroing: RscUnitInfo {
        class CA_Zeroing;
    };

    class CBA_ScriptedOptic: RscWeaponZeroing {
        onLoad = QUOTE(call FUNC(loadScriptedScope));
        controls[] = {"CA_FOVMode","ScopeBlack","Reticle","BodyNight","BodyDay","TrippleHeadLeft","TrippleHeadRight","CA_Zeroing","Magnification"};

        class CA_FOVMode: RscOpticsValue {
            idc = 154;
            w = 0;
            h = 0;
        };

        class Reticle: RscPicture {
            idc = IDC_RETICLE;
            w = 0;
            h = 0;
        };

        class BodyDay: RscPicture {
            idc = IDC_BODY;
            w = 0;
            h = 0;
        };

        class BodyNight: BodyDay {
            idc = IDC_BODY_NIGHT;
        };

        class ScopeBlack: RscPicture {
            idc = IDC_BLACK_SCOPE;
            text = QPATHTOF(reticles\scopeblack_ca.paa);
            x = POS_X(2);
            y = POS_Y(2);
            w = POS_W(2);
            h = POS_H(2);
        };

        // These are just black side panels to cover the areas that the optics p3d doesn't cover
        // It will ONLY effect tripple head users as (safeZoneX == safeZoneXAbs) for everyone else
        class TrippleHeadLeft: RscText {
            idc = IDC_BLACK_LEFT;
            x = "safeZoneXAbs";
            y = "safeZoneY";
            w = "(safeZoneX - safeZoneXAbs) * ((getResolution select 4)/(16/3))";
            h = "safeZoneH";
            colorBackground[] = {0,0,0,1};
        };

        class TrippleHeadRight: TrippleHeadLeft {
            idc = IDC_BLACK_RIGHT;
            x = "safeZoneXAbs + safeZoneWAbs - (safeZoneX - safeZoneXAbs) * ((getResolution select 4)/(16/3))";
        };

        class Magnification: CA_Zeroing {
            idc = IDC_MAGNIFICATION;
            text = "";
        };
    };

    class CBA_ScriptedOptic_zooming: CBA_ScriptedOptic {
        controls[] = {"CA_FOVMode","ScopeBlack","ReticleSafeZone","RedDot","BodyNight","BodyDay","TrippleHeadLeft","TrippleHeadRight","EnableAutoZoom","CA_Zeroing","Magnification"};

        class RedDot: RscPicture {
            idc = IDC_RED_DOT;
            text = "\a3\weapons_f\acc\data\collimdot_red_ca.paa"; // alt: green
            x = POS_X(0.025);
            y = POS_Y(0.025);
            w = POS_W(0.025);
            h = POS_H(0.025);
        };

        class ReticleSafeZone: RscControlsGroupNoScrollbars {
            idc = IDC_RETICLE_SAFEZONE;
            x = RETICLE_SAFEZONE_LEFT;
            y = RETICLE_SAFEZONE_TOP;
            w = RETICLE_SAFEZONE_WIDTH;
            h = RETICLE_SAFEZONE_HEIGHT;

            class controls {
                class Reticle: Reticle {};
            };
        };

        class EnableAutoZoom: RscText { // idea by Taosenai. Apparently this can be used via isNil check to determine wheter the scope or the kolimator is used
            idc = IDC_ENABLE_ZOOM;
            w = 0;
            h = 0;
        };
    };
};

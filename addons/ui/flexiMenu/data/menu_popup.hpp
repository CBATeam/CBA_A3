//#include "\x\cba\addons\ui\script_component.hpp"

#define _imagePath(TOKEN) QUOTE(PATHTOF(flexiMenu)\data\popup\TOKEN.paa)
#define _SX (safeZoneX+safeZoneW/2) // screen centre x
#define _SY (safeZoneY+safeZoneH/2) // screen centre y
#define _BW 0.21*safeZoneW // button width
#define _BH 0.033*safeZoneH // button height
#define _BH_overlap 0.0375*safeZoneH // button height with 1 pixel overlap for type "popup" menu
#define _gapH 0.01*safeZoneH
#define _buttonsBeforeCenter 7 // buttons above screen centre, allowing menu to appear centred.
#define _captionColorBG 58/256, 80/256, 55/256 // BIS mid green (button over colour)
#define _captionColorFG 138/256, 146/256, 105/256 // BIS greenish text
#define _captionHgt 1//0.75

class CBA_flexiMenu_rscPopup { //: _flexiMenu_rscRose
    idd = -1; //_flexiMenu_IDD;
    movingEnable = 0;
    onLoad = QUOTE(with uiNamespace do {GVAR(display) = _this select 0};);
    onUnload = QUOTE(with uiNamespace do {GVAR(display) = displayNull};);
    class controlsBackground {};
    class objects {};

    flexiMenu_primaryMenuControlWidth = _BW;
    flexiMenu_subMenuControlWidth = _BW;
    flexiMenu_subMenuCaptionWidth = _BW;

//#include "common_listClass.hpp"

    class listButton: _flexiMenu_RscShortcutButton {
        x = _SX-_BW;
        y = safeZoneY+0.30*safeZoneH;
        w = 0; //_BW; // hide initially
    h = _BH_overlap;
        sizeEx = _BH;
        size = _BH*0.75;

        color[] = {_captionColorFG, 1};
        color2[] = {1, 1, 1, 0.8}; //{1, 1, 1, 0.4};
        colorBackground[] = {1, 1, 1, 1};
        colorbackground2[] = {1, 1, 1, 1}; //{1, 1, 1, 0.4};
        colorDisabled[] = {1, 1, 1, 0.25};
        class TextPos {
            left = 0.02;
            top = 0.005;
            right = 0.02;
            bottom = 0.005;
        };
        class Attributes {
            font = "PuristaMedium";
            color = "#E5E5E5";
            align = "left";
            shadow = "true";
        };
    animTextureNormal = _imagePath(normal);
    animTextureDisabled = _imagePath(disabled);
    animTextureOver = _imagePath(over);
    animTextureFocused = _imagePath(focused);
    animTexturePressed = _imagePath(down);
    animTextureDefault = _imagePath(default);
    animTextureNoShortcut = _imagePath(normal);
    };
    //---------------------------------
    class controls {
        class caption: rscText {
            idc = _flexiMenu_IDC_menuDesc;
            x = _SX-_BW;
            y = safeZoneY+0.30*safeZoneH-_BH*_captionHgt;
            w = _BW;
            h = _BH*_captionHgt;
            sizeEx = _BH*_captionHgt;
            colorText[] = {_captionColorFG, 1};
            colorBackground[] = {_captionColorBG, 1};
            text = "";
        };

#define ExpandMacro_RowControls(ID) \
    class button##ID: listButton\
    {\
        idc = _flexiMenu_baseIDC_button+ID;\
        y = safeZoneY+0.30*safeZoneH+##ID*_BH;\
    }

        ExpandMacro_RowControls(00);
        ExpandMacro_RowControls(01);
        ExpandMacro_RowControls(02);
        ExpandMacro_RowControls(03);
        ExpandMacro_RowControls(04);
        ExpandMacro_RowControls(05);
        ExpandMacro_RowControls(06);
        ExpandMacro_RowControls(07);
        ExpandMacro_RowControls(08);
        ExpandMacro_RowControls(09);
        ExpandMacro_RowControls(10);
        ExpandMacro_RowControls(11);
        ExpandMacro_RowControls(12);
        ExpandMacro_RowControls(13);
        ExpandMacro_RowControls(14);
        ExpandMacro_RowControls(15);
        ExpandMacro_RowControls(16);
        ExpandMacro_RowControls(17);
        ExpandMacro_RowControls(18);
        ExpandMacro_RowControls(19);
        //-----------------------
        class caption2: caption {
            idc = _flexiMenu_IDC_listMenuDesc;
            x = _SX;
            y = safeZoneY+0.30*safeZoneH+_BH-_BH*_captionHgt;
            w = 0; //flexiMenu_subMenuCaptionWidth; // hide initially
        };

//#include "common_listControls.hpp"
#define ExpandMacro_ListControls(ID)\
    class listButton##ID: listButton\
    {\
        idc = _flexiMenu_baseIDC_listButton+ID;\
        x = _SX;\
        y = safeZoneY+0.30*safeZoneH+_BH+##ID*_BH;\
    }

        ExpandMacro_ListControls(00);
        ExpandMacro_ListControls(01);
        ExpandMacro_ListControls(02);
        ExpandMacro_ListControls(03);
        ExpandMacro_ListControls(04);
        ExpandMacro_ListControls(05);
        ExpandMacro_ListControls(06);
        ExpandMacro_ListControls(07);
        ExpandMacro_ListControls(08);
        ExpandMacro_ListControls(09);
        ExpandMacro_ListControls(10);
        ExpandMacro_ListControls(11);
        ExpandMacro_ListControls(12);
        ExpandMacro_ListControls(13);
        ExpandMacro_ListControls(14);
        ExpandMacro_ListControls(15);
        ExpandMacro_ListControls(16);
        ExpandMacro_ListControls(17);
        ExpandMacro_ListControls(18);
        ExpandMacro_ListControls(19);
    };
};

#undef _imagePath
#undef _SX
#undef _SY
#undef _BW
#undef _BH
#undef _BH_overlap
#undef _gapH
#undef _buttonsBeforeCenter
#undef _captionColorBG
#undef _captionColorFG
#undef _captionHgt
#undef ExpandMacro_RowControls
#undef ExpandMacro_ListControls

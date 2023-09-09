//#define DEBUG_MODE_FULL
//#include "..\..\script_component.hpp"

#define _DefaultAspectRatio 3 / 4
#define _SX (safeZoneX + safeZoneW / 2) //screen centre x
#define _SY (safeZoneY + safeZoneH / 2) //screen centre y
#define _BW 0.21 * safeZoneW  //button width
#define _BH (_CH / 5.5) //button height
#define _CX_correction 0.011 * safeZoneW
#define _CW 0.15 * safeZoneW * _DefaultAspectRatio //_CH  //exception  //0.10 * safeZoneW  //circle (button) width
#define _CH 0.15 * safeZoneH //0.15 * safeZoneW //exception safeZoneH  //circle (button) height
#define _SMW 0.21 * safeZoneW //sub-menu width
#define _LBH 0.033 * safeZoneH //list button height
#define _LBH_overlap 0.0375 * safeZoneH //button height with 1 pixel overlap for type "popup" menu
#define _listButtonsPerRow 10
//#define _captionColorBG 58 / 256, 80 / 256, 55 / 256 //BIS mid green (button over colour)
#define _captionColorFG "138 / 256", "146 / 256", "105 / 256" //BIS greenish text
#define _captionHgt 0.85
#define _gapW 0.01 * safeZoneW //Horizontal gap "width" between circle button and side buttons
#define _gapH ((_CH / 2-2 * _BH) * 2 / 3) //Button "height" vertical spacing
#define _imagePath(TOKEN) QUOTE(PATHTOF(flexiMenu)\data\rose\TOKEN.paa)
#define _imagePath2(TOKEN) QUOTE(PATHTOF(flexiMenu)\data\buttonList\TOKEN.paa)

#define _gapWLevel1 (-0.025 * safeZoneW) //extra indentation required for side buttons on row 1 and 4 to reach circle edge
#define _gapWLevel2 (-0.015 * safeZoneW) //extra indentation required for side buttons on row 2 and 3 to reach circle edge
#define _gapWRight (-0.00 * safeZoneW) //extra indentation required for all right side buttons to reach circle edge

#define _leftButtonLevel1X (_SX - (_CW / 2 + _gapW + _gapWLevel1) - _BW - _gapWRight)
#define _leftButtonLevel2X (_SX - (_CW / 2 + _gapW + _gapWLevel2) - _BW - _gapWRight)
#define _rightButtonLevel1X (_SX + (_CW / 2 + _gapW + _gapWLevel1) + _gapWRight)
#define _rightButtonLevel2X (_SX + (_CW / 2 + _gapW + _gapWLevel2) + _gapWRight)

class CBA_flexiMenu_rscRose {
    idd = -1; // _flexiMenu_IDD;
    movingEnable = 0;
    onLoad = QUOTE(with uiNamespace do {GVAR(display) = _this select 0};);
    onUnload = QUOTE(with uiNamespace do {GVAR(display) = displayNull};);
    class controlsBackground {};
    class objects {};

    // custom flexiMenu properties
    flexiMenu_primaryMenuControlWidth = QUOTE(_BW);
    flexiMenu_subMenuControlWidth = QUOTE(_SMW);
    flexiMenu_subMenuCaptionWidth = 0.40;
    flexiMenu_hotKeyColor = "#f07EB27E";

    // #include "common_listClass.hpp"
    class listButton: _flexiMenu_RscShortcutButton {
        x = 0.5;
        y = 0.5;
        w = 0; //_SMW; //hide initially
        // w = _SMW;
        h = QUOTE(_LBH_overlap);
        sizeEx = QUOTE(_LBH);
        size = QUOTE(_LBH * 0.75);

        color[] = {_captionColorFG, 1};
        color2[] = {1, 1, 1, 0.8}; // {1, 1, 1, 0.4};
        colorBackground[] = {1, 1, 1, 1};
        colorbackground2[] = {1, 1, 1, 1}; // {1, 1, 1, 0.4};
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
        animTextureNormal = _imagePath2(normal);
        animTextureDisabled = _imagePath2(disabled);
        animTextureOver = _imagePath2(over);
        animTextureFocused = _imagePath2(focused);
        animTexturePressed = _imagePath2(down);
        animTextureDefault = _imagePath2(default);
        animTextureNoShortcut = _imagePath2(normal);
    };

    class button: _flexiMenu_RscShortcutButton {
        w = 0; //QUOTE(_BW); //hide initially
        h = QUOTE(_BH);
        sizeEx = QUOTE(_BH);
        size = QUOTE(_BH * 0.85);

        color[] = {_captionColorFG, 1};
        color2[] = {1, 1, 1, 0.8}; // {1, 1, 1, 0.4};
        colorBackground[] = {1, 1, 1, 1};
        colorbackground2[] = {1, 1, 1, 1}; // {1, 1, 1, 0.4};
        colorDisabled[] = {1, 1, 1, 0.25};
        //action = _eval_action(-1);

        class Attributes {
            font = "PuristaMedium";
            color = "#E5E5E5";
            align = "center";
            shadow = "true";
        };
    };
    //---------------------------------
    class controls {
        class caption: rscText {
            idc = _flexiMenu_IDC_menuDesc;
            //x = QUOTE(_SX - _BW);
            x = QUOTE(_leftButtonLevel1X);
            //y = QUOTE(_SY - _buttonsBeforeCenter * _BH -_ gapH - _BH * _captionHgt);
            y = QUOTE(_SY - (_CH / 2 + _gapH) - _BH - _gapH - _BH * _captionHgt);
            w = QUOTE(0.50 * safeZoneW);
            h = QUOTE(_BH * _captionHgt);
            sizeEx = QUOTE(_BH * _captionHgt);
            colorText[] = {_captionColorFG, 1};
            text = "";
        };

        class button01: button {
            idc = QUOTE(_flexiMenu_baseIDC_button + 0);
            x = QUOTE(_SX-_CW / 2 + _CX_correction);
            y = QUOTE(_SY-_CH / 2);
            w = QUOTE(_CW);
            h = QUOTE(_CH);
            sizeEx = QUOTE(_CH);
            //size = QUOTE(_BH * 0.8);
            class TextPos {
                left = QUOTE(-_CX_correction * 2);  //not sure if logic is correct, but seems close enough  //0.008
                top = QUOTE(_CH / 2 - _BH / 2);
                right = 0; // 0.002;
                bottom = 0.0;
            };
            animTextureNormal = _imagePath(DOUBLES(normal,circle));
            animTextureDisabled = _imagePath(DOUBLES(disabled,circle));
            animTextureOver = _imagePath(DOUBLES(over,circle));
            animTextureFocused = _imagePath(DOUBLES(focused,circle));
            animTexturePressed = _imagePath(DOUBLES(down,circle));
            animTextureDefault = _imagePath(DOUBLES(normal,circle));  //used?
            animTextureNoShortcut = _imagePath(DOUBLES(normal,circle));  //used?
        };

        #define ExpandMacro_RowControls(ID,newX,newY,imageTag)\
        class button##ID: button {\
            idc = QUOTE(_flexiMenu_baseIDC_button + (ID-1));\
            x = QUOTE(newX);\
            y = QUOTE(newY);\
            text = "";\
            action = "";\
            animTextureNormal = _imagePath(DOUBLES(normal,imageTag));\
            animTextureDisabled = _imagePath(DOUBLES(disabled,imageTag));\
            animTextureOver = _imagePath(DOUBLES(over,imageTag));\
            animTextureFocused = _imagePath(DOUBLES(focused,imageTag));\
            animTexturePressed = _imagePath(DOUBLES(down,imageTag));\
            animTextureDefault = _imagePath(DOUBLES(normal,imageTag));\
            animTextureNoShortcut = _imagePath(DOUBLES(normal,imageTag));\
        }

        ExpandMacro_RowControls(02,_SX - _BW / 2,_SY - (_CH / 2 + _gapH) - _BH,top);
        ExpandMacro_RowControls(03,_SX - _BW / 2,_SY + (_CH / 2 + _gapH),bottom);
        ExpandMacro_RowControls(04,_leftButtonLevel1X,_SY - _gapH / 2 - _BH - _gapH - _BH,L01);
        ExpandMacro_RowControls(05,_leftButtonLevel2X,_SY - _gapH / 2 - _BH,L02);
        ExpandMacro_RowControls(06,_leftButtonLevel2X,_SY + _gapH / 2,L03);
        ExpandMacro_RowControls(07,_leftButtonLevel1X,_SY + _gapH / 2 + _BH + _gapH,L04);
        ExpandMacro_RowControls(08,_rightButtonLevel1X,_SY - _gapH / 2 - _BH - _gapH - _BH,R01);
        ExpandMacro_RowControls(09,_rightButtonLevel2X,_SY - _gapH / 2 - _BH,R02);
        ExpandMacro_RowControls(10,_rightButtonLevel2X,_SY + _gapH / 2,R03);
        ExpandMacro_RowControls(11,_rightButtonLevel1X,_SY + _gapH / 2 + _BH + _gapH,R04);
        //-----------------------
        class caption2: caption {
            idc = _flexiMenu_IDC_listMenuDesc;
            x = QUOTE(_SX - (_SMW / 2));
            y = QUOTE(_SY + (_CH / 2 + _gapH) + _BH + _gapH + 0 * _LBH);
            w = 0; //flexiMenu_subMenuCaptionWidth;  //hide initially
        };

    //#include "common_listControls.hpp"
    //Note: x pos will be 3 columns, with first column centred, 2nd on right, 3rd on left.
    #define ExpandMacro_ListControls(ID)\
    class listButton##ID: listButton {\
        idc = QUOTE(_flexiMenu_baseIDC_listButton + ID);\
        x = QUOTE(_SX - ((_SMW + _gapW) * 1.5) + floor(((##ID + _listButtonsPerRow) / _listButtonsPerRow) mod 3) * (_SMW + _gapW));\
        y = QUOTE(_SY + (_CH / 2 + _gapH) + _BH + _gapH + (1 + (##ID mod _listButtonsPerRow)) * _LBH);\
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
        ExpandMacro_ListControls(20);
        ExpandMacro_ListControls(21);
        ExpandMacro_ListControls(22);
        ExpandMacro_ListControls(23);
        ExpandMacro_ListControls(24);
        ExpandMacro_ListControls(25);
        ExpandMacro_ListControls(26);
        ExpandMacro_ListControls(27);
        ExpandMacro_ListControls(28);
        ExpandMacro_ListControls(29);
    };
};

#undef _DefaultAspectRatio
#undef _SX
#undef _SY
#undef _BW
#undef _BH
#undef _CX_correction
#undef _CW
#undef _CH
#undef _SMW
#undef _LBH
#undef _LBH_overlap
#undef _listButtonsPerRow
#undef _captionColorFG
#undef _captionHgt
#undef _gapW
#undef _gapH
#undef _imagePath
#undef _imagePath2
#undef _gapWLevel1
#undef _gapWLevel2
#undef _gapWRight
#undef _leftButtonLevel1X
#undef _leftButtonLevel2X
#undef _rightButtonLevel1X
#undef _rightButtonLevel2X
#undef ExpandMacro_RowControls
#undef ExpandMacro_ListControls

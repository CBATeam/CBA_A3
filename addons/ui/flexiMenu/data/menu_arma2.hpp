#include "\x\cba\addons\ui\script_component.hpp"

#define _DefaultAspectRatio 3/4
#define _SX (safeZoneX+safeZoneW/2) // screen centre x
#define _SY (safeZoneY+safeZoneH/2) // screen centre y
#define _BW 0.21*safeZoneW // button width
#define _BH (_CH/5.5) // button height
#define _CX_correction 0.011*safeZoneW
#define _CW 0.15*safeZoneW*_DefaultAspectRatio // _CH // exception // 0.10*safeZoneW // circle (button) width
#define _CH 0.15*safeZoneH // 0.15*safeZoneW // exception safeZoneH // circle (button) height

#ifdef _SMW
#undef _SMW
#endif  
#define _SMW 0.21*safeZoneW // sub-menu width

#define _listButtonsPerRow 10
//#define _captionColorBG 58/256, 80/256, 55/256 // BIS mid green (button over colour)
#define _captionColorFG 138/256, 146/256, 105/256 // BIS greenish text
#define _captionHgt 0.85

#define _gapW 0.01*safeZoneW // Horizontal gap "width" between circle button and side buttons
#define _gapH ((_CH/2-2*_BH)*2/3) // Button "height" vertical spacing

#define _imagePath(TOKEN) QUOTE(PATHTOF(flexiMenu)\data\arma2\TOKEN.paa)
#define _imagePathCA(TOKEN) QUOTE(\ca\ui\data\TOKEN.paa)

#ifdef _gapWLevel1
#undef _gapWLevel1
#endif  
#define _gapWLevel1 (0.01*safeZoneW) // extra indentation required for side buttons on row 1 and 4 to reach circle edge

#ifdef _gapWLevel2
#undef _gapWLevel2
#endif  
#define _gapWLevel2 (0.01*safeZoneW) // extra indentation required for side buttons on row 2 and 3 to reach circle edge

#ifdef _gapWRight
#undef _gapWRight
#endif  
#define _gapWRight (-0.015*safeZoneW-_gapW) // extra indentation required for all right side buttons to reach circle edge

#define _leftButtonLevel1X (_SX-(_CW/2+_gapW+_gapWLevel1)-_BW-_gapWRight)
#define _leftButtonLevel2X (_SX-(_CW/2+_gapW+_gapWLevel2)-_BW-_gapWRight)
#define _rightButtonLevel1X (_SX+(_CW/2+_gapW+_gapWLevel1)+_gapWRight)
#define _rightButtonLevel2X (_SX+(_CW/2+_gapW+_gapWLevel2)+_gapWRight)

class CBA_flexiMenu_rscArma2 {
	idd = -1; //_flexiMenu_IDD;
	movingEnable = 0;
	onLoad = QUOTE(with uiNamespace do {GVAR(display) = _this select 0};);
	onUnload = QUOTE(with uiNamespace do {GVAR(display) = displayNull};);
	class controlsBackground {};
	class objects {};

	// custom flexiMenu properties
	flexiMenu_primaryMenuControlWidth = _BW;
	flexiMenu_subMenuControlWidth = _SMW;
	flexiMenu_subMenuCaptionWidth = 0.40;

	//class listButton; // external ref
	//#include "common_listClass.hpp"
	#define _imagePath2(TOKEN) QUOTE(PATHTOF(flexiMenu)\data\buttonList\TOKEN.paa)

	class listButton: _flexiMenu_RscShortcutButton {
		x = 0.5;
		y = 0.5;
		w = 0; //_SMW; // hide initially
		//w = _SMW;
		h = _LBH_overlap;
		sizeEx = _LBH;
		size = _LBH*0.75;

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
    animTextureNormal = _imagePath2(normal);
    animTextureDisabled = _imagePath2(disabled);
    animTextureOver = _imagePath2(over);
    animTextureFocused = _imagePath2(focused);
    animTexturePressed = _imagePath2(down);
    animTextureDefault = _imagePath2(default);
    animTextureNoShortcut = _imagePath2(normal);
	};

	class button: _flexiMenu_RscShortcutButton {
		w = 0; //_BW; // hide initially
		h = _BH*1.52; // paa's only use 66% of hgt
		sizeEx = _BH;
		size = _BH*0.85;

		color[] = {_captionColorFG, 1};
		color2[] = {1, 1, 1, 0.8}; //{1, 1, 1, 0.4};
		colorBackground[] = {1, 1, 1, 1};
		colorbackground2[] = {1, 1, 1, 1}; //{1, 1, 1, 0.4};
		colorDisabled[] = {1, 1, 1, 0.25};
		//action = _eval_action(-1);

		class ShortcutPos {
			left = 0;
			top = 0;
			w = 0.1;
			h = 0.1;
		};
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
			//x = _SX-_BW;
			x = _leftButtonLevel1X;
			//y = _SY-_buttonsBeforeCenter*_BH-_gapH-_BH*_captionHgt;
			y = _SY-(_CH/2+_gapH)-_BH-_gapH-_BH*_captionHgt;
      w = 0.50*safeZoneW;
			h = _BH*_captionHgt;
			sizeEx = _BH*_captionHgt;
			colorText[] = {_captionColorFG, 1};
			text = "";
		};

		class button01: button {
			idc = _flexiMenu_baseIDC_button+0;
			x = _SX-_CW/2+_CX_correction;
			y = _SY-_CH/2;
			w = _CW;
			h = _CH;
			sizeEx = _CH;
			//size = _BH*0.8;
			class TextPos {
				left = -_CX_correction*2; // not sure if logic is correct, but seems close enough
				top = _CH/2-_BH/2;
				right = 0; //0.002;
				bottom = 0.0;
			};
			/*
			class Attributes {
				font = "PuristaMedium";
				color = "#E5E5E5";
				align = "left";
				shadow = "true";
			};
			*/
      animTextureNormal = _imagePath(mid_button_normal);
      animTextureDisabled = _imagePath(mid_button_disabled);
      animTextureOver = _imagePath(mid_button_over);
      animTextureFocused = _imagePath(mid_button_focus);
      animTexturePressed = _imagePath(mid_button_down);
      animTextureDefault = _imagePath(mid_button_normal); // used?
      animTextureNoShortcut = _imagePath(mid_button_normal); // used?
		};
		class button02: button {
			idc = _flexiMenu_baseIDC_button+1;
			x = _SX-_BW/2;
			y = _SY-(_CH/2+_gapH)-_BH;
      animTextureNormal = _imagePathCA(igui_button_normal_ca);
      animTextureDisabled = _imagePathCA(igui_button_disabled_ca);
      animTextureOver = _imagePathCA(igui_button_over_ca);
      animTextureFocused = _imagePathCA(igui_button_focus_ca);
      animTexturePressed = _imagePathCA(igui_button_down_ca);
      animTextureDefault = _imagePathCA(igui_button_normal_ca);
      animTextureNoShortcut = _imagePathCA(igui_button_normal_ca);
		};
		class button03: button02 {
			idc = _flexiMenu_baseIDC_button+2;
			x = _SX-_BW/2;
			y = _SY+(_CH/2+_gapH);
		};
		//---------------------------------
		class button04: button02 {
			idc = _flexiMenu_baseIDC_button+3;
			x = _leftButtonLevel1X;
			y = _SY-_gapH/2-_BH-_gapH-_BH;
		};
		class button05: button02 {
			idc = _flexiMenu_baseIDC_button+4;
			x = _leftButtonLevel2X;
			y = _SY-_gapH/2-_BH;
		};
		class button06: button02 {
			idc = _flexiMenu_baseIDC_button+5;
			x = _leftButtonLevel2X;
			y = _SY+_gapH/2;
		};
		class button07: button02 {
			idc = _flexiMenu_baseIDC_button+6;
			x = _leftButtonLevel1X;
			y = _SY+_gapH/2+_BH+_gapH;
		};
		//---------------------------------
		class button08: button02 {
			idc = _flexiMenu_baseIDC_button+7;
			x = _rightButtonLevel1X;
			y = _SY-_gapH/2-_BH-_gapH-_BH;
		};
		class button09: button02 {
			idc = _flexiMenu_baseIDC_button+8;
			x = _rightButtonLevel2X;
			y = _SY-_gapH/2-_BH;
		};
		class button10: button02 {
			idc = _flexiMenu_baseIDC_button+9;
			x = _rightButtonLevel2X;
			y = _SY+_gapH/2;
		};
		class button11: button02 {
			idc = _flexiMenu_baseIDC_button+10;
			x = _rightButtonLevel1X;
			y = _SY+_gapH/2+_BH+_gapH;
		};
		//-----------------------
		class caption2: caption {
			idc = _flexiMenu_IDC_listMenuDesc;
			x = _SX-(_SMW/2);
			y = _SY+(_CH/2+_gapH)+_BH+_gapH+0*_LBH;
			w = 0; //flexiMenu_subMenuCaptionWidth; // hide initially
		};

//#include "common_listControls.hpp"
// Note: x pos will be 3 columns, with first column centred, 2nd on right, 3rd on left.
#define ExpandMacro_ListControls(ID)\
	class listButton##ID: listButton\
	{\
		idc = _flexiMenu_baseIDC_listButton+ID;\
      x = _SX - ((_SMW+_gapW) * 1.5) + floor(((##ID + _listButtonsPerRow) / _listButtonsPerRow) mod 3)*(_SMW+_gapW);\
			y = _SY+(_CH/2+_gapH)+_BH+_gapH+(1+(##ID mod _listButtonsPerRow))*_LBH;\
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

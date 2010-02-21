#include "common.hpp"

#define _eval_image(_param) __EVAL(format ["%1\data\arma2\mid_button_%2.paa", _flexiMenu_path, ##_param])

#define _SX (safeZoneX+safeZoneW/2) // screen centre x
#define _SY (safeZoneY+safeZoneH/2) // screen centre y
#define _BW 0.04*safeZoneW // button width
#define _BH 0.04*safeZoneH // button height
#define _BH2 _BH*1.52 // button height adjust for some paa's which only use 66% of hgt
#define _StandardBH 0.033*safeZoneH // button height
#define _SMW 0.15*safeZoneW // sub-menu width
#define _gapW 0.01*safeZoneW
#define _gapH 0.01*safeZoneH
#define _buttonsBeforeCenter 6 // buttons before screen centre, allowing menu to appear centred.
#define _buttonsPerRow 5
#define _captionColorBG 58/256, 80/256, 55/256 // BIS mid green (button over colour)
#define _captionColorFG 138/256, 146/256, 105/256 // BIS greenish text
#define _captionHgt 0.75

class CBA_flexiMenu_rscIconRow //: _flexiMenu_rscRose
{
  idd = -1; //_flexiMenu_IDD;
  movingEnable = 0;
  onLoad = __EVAL(format["uiNamespace setVariable ['%1', _this select 0]", QUOTE(GVAR(display))]);
  onUnload = __EVAL(format["uiNamespace setVariable ['%1', displayNull]", QUOTE(GVAR(display))]);
  class controlsBackground {};
  class objects {};

	// custom flexiMenu properties
	flexiMenu_primaryMenuControlWidth = _BW;
	flexiMenu_subMenuControlWidth = _SMW;
	flexiMenu_subMenuCaptionWidth = 0.40;

//class listButton; // external ref
//#include "common_listClass.hpp"
#define _eval_image2(_param) __EVAL(format ["%1\data\buttonList\%2.paa", _flexiMenu_path, ##_param])

  class listButton: _flexiMenu_RscShortcutButton
  {
    x = 0.5;
    y = 0.5;
		w = 0; //_SMW; // hide initially
    h = _LBH;
    sizeEx = _LBH;
    size = _LBH*0.75;

    color[] = {_captionColorFG, 1};
    color2[] = {1, 1, 1, 0.8}; //{1, 1, 1, 0.4};
    colorBackground[] = {1, 1, 1, 1};
    colorbackground2[] = {1, 1, 1, 1}; //{1, 1, 1, 0.4};
    colorDisabled[] = {1, 1, 1, 0.25};
    class TextPos
    {
			left = 0.02;
			top = 0.005;
			right = 0.02;
			bottom = 0.005;
    };
    class Attributes
    {
      font = "Zeppelin32";
      color = "#E5E5E5";
      align = "left";
      shadow = "true";
    };
    animTextureNormal = _eval_image2("normal");
    animTextureDisabled = _eval_image2("disabled");
    animTextureOver = _eval_image2("over");
    animTextureFocused = _eval_image2("focused");
    animTexturePressed = _eval_image2("down");
    animTextureDefault = _eval_image2("default");
    animTextureNoShortcut = _eval_image2("normal");
  };

  class button: _flexiMenu_RscShortcutButton
  {
    x = _SX-_BW;
    y = _SY;
		w = 0; //_BW; // hide initially
    h = _BH2;
    sizeEx = _BH;
    size = _BH; //*0.85;

    color[] = {_captionColorFG, 1};
    color2[] = {1, 1, 1, 0.8}; //{1, 1, 1, 0.4};
    colorBackground[] = {1, 1, 1, 1};
    colorbackground2[] = {1, 1, 1, 1}; //{1, 1, 1, 0.4};
    colorDisabled[] = {1, 1, 1, 0.25};
    class TextPos
    {
      left = 0.0055;
      top = 0.009;
      right = 0.00;
      bottom = 0.000;
    };
    class Attributes
    {
      font = "Zeppelin32";
      color = "#E5E5E5";
      align = "center";
      shadow = "true";
    };
		animTextureNormal = _eval_image("normal");
		animTextureDisabled = _eval_image("disabled");
		animTextureOver = _eval_image("over");
		animTextureFocused = _eval_image("focus");
		animTexturePressed = _eval_image("down");
		animTextureDefault = _eval_image("normal"); // used?
		animTextureNoShortcut = _eval_image("normal"); // used?
    //action = _eval_action(-1);
  };
  //---------------------------------
  class controls
  {
    class caption: rscText
    {
			idc = _flexiMenu_IDC_menuDesc;
      x = _SX-_buttonsBeforeCenter*_BW;
			y = _SY-_gapH-_StandardBH*_captionHgt;
      w = 0.40;
			h = _StandardBH*_captionHgt;
			sizeEx = _StandardBH*_captionHgt;
			color[] = {_captionColorFG, 1};
			text = "";
    };

#define ExpandMacro_RowControls(ID)\
    class button##ID: button\
    {\
			idc = __EVAL(_flexiMenu_IDC);\
			__EXEC(_flexiMenu_IDC = _flexiMenu_IDC+1);\
      x = _SX-_buttonsBeforeCenter*_BW+(##ID mod _buttonsPerRow)*_BW;\
			y = _SY+floor(##ID / _buttonsPerRow)*(_gapH+_BH2);\
    }

		__EXEC(_flexiMenu_IDC = _flexiMenu_baseIDC_button);
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
    class caption2: caption
    {
			idc = _flexiMenu_IDC_listMenuDesc;
      x = _SX-_buttonsBeforeCenter*_BW+(_buttonsPerRow+1)*_BW;
			y = _SY;
      w = 0; //flexiMenu_subMenuCaptionWidth; // hide initially
    };

//#include "common_listControls.hpp"
#define ExpandMacro_ListControls(ID)\
    class listButton##ID: listButton\
    {\
			idc = __EVAL(_flexiMenu_IDC);\
			__EXEC(_flexiMenu_IDC = _flexiMenu_IDC+1);\
      x = _SX-_buttonsBeforeCenter*_BW+(_buttonsPerRow+1)*_BW;\
			y = _SY+##ID*_LBH;\
    }

		__EXEC(_flexiMenu_IDC = _flexiMenu_baseIDC_listButton);
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
  };
};

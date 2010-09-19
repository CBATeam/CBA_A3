#include "common.hpp"
//#include "common_rose.hpp"

#define _DefaultAspectRatio 3/4
#define _SX (safeZoneX+safeZoneW/2) // screen centre x
#define _SY (safeZoneY+safeZoneH/2) // screen centre y
#define _BW 0.18*safeZoneW // button width
#define _BH (_CH/5.5) // button height
#define _CX_correction 0.011*safeZoneW
#define _CW 0.15*safeZoneW*_DefaultAspectRatio // _CH // exception // 0.10*safeZoneW // circle (button) width
#define _CH 0.15*safeZoneH // 0.15*safeZoneW // exception safeZoneH // circle (button) height
#define _SMW 0.15*safeZoneW // sub-menu width
//#define _captionColorBG 58/256, 80/256, 55/256 // BIS mid green (button over colour)
#define _captionColorFG 138/256, 146/256, 105/256 // BIS greenish text
#define _captionHgt 0.85

#define _gapW 0.01*safeZoneW // Horizontal gap "width" between circle button and side buttons
#define _gapH ((_CH/2-2*_BH)*2/3) // Button "height" vertical spacing

#define _flexiMenu_PATH \x\cba\addons\ui\flexiMenu
#define IMAGE(A,B) QUOTE(_flexiMenu_PATH\A\B.paa)
#define _eval_image(_param) IMAGE(data\rose,_param)


#define _gapWLevel1 (-0.025*safeZoneW) // extra indentation required for side buttons on row 1 and 4 to reach circle edge
#define _gapWLevel2 (-0.015*safeZoneW) // extra indentation required for side buttons on row 2 and 3 to reach circle edge
#define _gapWRight (-0.00*safeZoneW) // extra indentation required for all right side buttons to reach circle edge

#define _leftButtonLevel1X (_SX-(_CW/2+_gapW+_gapWLevel1)-_BW-_gapWRight)
#define _leftButtonLevel2X (_SX-(_CW/2+_gapW+_gapWLevel2)-_BW-_gapWRight)
#define _rightButtonLevel1X (_SX+(_CW/2+_gapW+_gapWLevel1)+_gapWRight)
#define _rightButtonLevel2X (_SX+(_CW/2+_gapW+_gapWLevel2)+_gapWRight)

class CBA_flexiMenu_rscRose
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
#define _eval_image2(_param) IMAGE(data\buttonList,_param)

  class listButton: _flexiMenu_RscShortcutButton
  {
    x = 0.5;
    y = 0.5;
		w = 0; //_SMW; // hide initially
    //w = _SMW;
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
	animTextureNormal = _eval_image2(normal);
	animTextureDisabled = _eval_image2(disabled);
	animTextureOver = _eval_image2(over);
	animTextureFocused = _eval_image2(focused);
	animTexturePressed = _eval_image2(down);
	animTextureDefault = _eval_image2(default);
	animTextureNoShortcut = _eval_image2(normal);
  };

  class button: _flexiMenu_RscShortcutButton
  {
		w = 0; //_BW; // hide initially
    h = _BH;
    sizeEx = _BH;
    size = _BH*0.85;

    color[] = {_captionColorFG, 1};
    color2[] = {1, 1, 1, 0.8}; //{1, 1, 1, 0.4};
    colorBackground[] = {1, 1, 1, 1};
    colorbackground2[] = {1, 1, 1, 1}; //{1, 1, 1, 0.4};
    colorDisabled[] = {1, 1, 1, 0.25};
    //action = _eval_action(-1);

		class Attributes
		{
			font = "Zeppelin32";
			color = "#E5E5E5";
			align = "center";
			shadow = "true";
		};
  };
  //---------------------------------
  class controls
  {
    class caption: rscText
    {
			idc = _flexiMenu_IDC_menuDesc;
      //x = _SX-_BW;
      x = _leftButtonLevel1X;
			//y = _SY-_buttonsBeforeCenter*_BH-_gapH-_BH*_captionHgt;
      y = _SY-(_CH/2+_gapH)-_BH-_gapH-_BH*_captionHgt;
      w = 0.40;
			h = _BH*_captionHgt;
			sizeEx = _BH*_captionHgt;
			color[] = {_captionColorFG, 1};
			text = "";
    };

		__EXEC(_flexiMenu_IDC = _flexiMenu_baseIDC_button);
    class button01: button
    {
			idc = __EVAL(_flexiMenu_IDC);
			__EXEC(_flexiMenu_IDC = _flexiMenu_IDC+1);
      x = _SX-_CW/2+_CX_correction;
      y = _SY-_CH/2;
      w = _CW;
      h = _CH;
      sizeEx = _CH;
      //size = _BH*0.8;
      class TextPos
      {
        left = -_CX_correction*2; // not sure if logic is correct, but seems close enough // 0.008
        top = _CH/2-_BH/2;
        right = 0; //0.002;
        bottom = 0.0;
      };
		animTextureNormal = _eval_image(DOUBLES(normal,circle));
		animTextureDisabled = _eval_image(DOUBLES(disabled,circle));
		animTextureOver = _eval_image(DOUBLES(over,circle));
		animTextureFocused = _eval_image(DOUBLES(focused,circle));
		animTexturePressed = _eval_image(DOUBLES(down,circle));
		animTextureDefault = _eval_image(DOUBLES(normal,circle)); // used?
		animTextureNoShortcut = _eval_image(DOUBLES(normal,circle)); // used?
    };

		#define ExpandMacro_RowControls(ID,newX,newY,imageTag) \
		class button##ID: button {\
			idc = __EVAL(_flexiMenu_IDCi);\
			__EXEC(_flexiMenu_IDCi = _flexiMenu_IDCi+1);\
			x = ##newX;\
			y = ##newY;\
			text = "";\
			action = "";\
			animTextureNormal = _eval_image(DOUBLES(normal,imageTag));\
			animTextureDisabled = _eval_image(DOUBLES(disabled,imageTag));\
			animTextureOver = _eval_image(DOUBLES(over,imageTag));\
			animTextureFocused = _eval_image(DOUBLES(focused,imageTag));\
			animTexturePressed = _eval_image(DOUBLES(down,imageTag));\
			animTextureDefault = _eval_image(DOUBLES(normal,imageTag));\
			animTextureNoShortcut = _eval_image(DOUBLES(normal,imageTag));\
		}

		ExpandMacro_RowControls(02, _SX-_BW/2, _SY-(_CH/2+_gapH)-_BH,top);
		ExpandMacro_RowControls(03, _SX-_BW/2, _SY+(_CH/2+_gapH),bottom);
		ExpandMacro_RowControls(04, _leftButtonLevel1X, _SY-_gapH/2-_BH-_gapH-_BH,L01);
		ExpandMacro_RowControls(05, _leftButtonLevel2X, _SY-_gapH/2-_BH,L02);
		ExpandMacro_RowControls(06, _leftButtonLevel2X, _SY+_gapH/2,L03);
		ExpandMacro_RowControls(07, _leftButtonLevel1X, _SY+_gapH/2+_BH+_gapH,L04);
		ExpandMacro_RowControls(08, _rightButtonLevel1X, _SY-_gapH/2-_BH-_gapH-_BH,R01);
		ExpandMacro_RowControls(09, _rightButtonLevel2X, _SY-_gapH/2-_BH,R02);
		ExpandMacro_RowControls(10, _rightButtonLevel2X, _SY+_gapH/2,R03);
		ExpandMacro_RowControls(11, _rightButtonLevel1X, _SY+_gapH/2+_BH+_gapH,R04);
		//-----------------------
    class caption2: caption
    {
			idc = _flexiMenu_IDC_listMenuDesc;
      x = _SX-(_SMW/2);
			y = _SY+(_CH/2+_gapH)+_BH+_gapH+0*_LBH;
      w = 0; //flexiMenu_subMenuCaptionWidth; // hide initially
    };

//#include "common_listControls.hpp"
#define ExpandMacro_ListControls(ID)\
    class listButton##ID: listButton\
    {\
			idc = __EVAL(_flexiMenu_IDC);\
			__EXEC(_flexiMenu_IDC = _flexiMenu_IDC+1);\
      x = _SX-(_SMW/2);\
			y = _SY+(_CH/2+_gapH)+_BH+_gapH+(1+##ID)*_LBH;\
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

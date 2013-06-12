#include "script_dialog_defines.hpp"

class RscStandardDisplay;
class RscStructuredText;
class RscActiveText;
class RscButton;
class CA_Version;
class VersionText;
class VersionNumber;
class RscControlsGroupNoScrollbars;

class CBA_CREDITS_CONT: RscStructuredText {
	idc = -1; //template
	colorBackground[] = { 0, 0, 0, 0 };
	__SX(25);
	__SY(23);
	__SW(30);
	__SH(1);
	class Attributes {
		font = "PuristaLight";
		align = "center";
		valign = "bottom";
		color = "#bdcc9c";
		size = 0.8;
	};
};

class CBA_CREDITS_M: RscActiveText { //mouse trap, blocks screen until disabled onMouseEnter (automatic)
	style = 48;
	idc = -1; //template
	__FSX(0);
	__FSY(0);
	__FSW(1);
	__FSH(1);
	text = "#(argb,8,8,3)color(1,1,1,0)";
	onMouseEnter = "(_this select 0) ctrlEnable false; (_this select 0) ctrlShow false; _this call compile preprocessFileLineNumbers '\x\cba\addons\help\mm_spc_init.sqf';";
};

class CBA_CREDITS_VER_BTN: RscButton {
	idc = -1; //template
	colorText[] = {1, 1, 1, 0};
	colorDisabled[] = {1, 1, 1, 0};
	colorBackground[] = {1, 1, 1, 0};
	colorBackgroundDisabled[] = {1, 1, 1, 0};
	colorBackgroundActive[] = {1, 1, 1, 0};
	colorShadow[] = {1, 1, 1, 0};
	colorFocused[] = {1, 1, 1, 0};
	soundClick[] = {"", 0.1, 1};
	x = -1;
	y = -1;
	w = 0;
	h = 0;
	text = "";
};

class RscDisplayMain: RscStandardDisplay {
	class controls {
		class VersionNumber;
		
		class ModIcons: RscControlsGroupNoScrollbars
		{
			class Controls
			{
			};
			idc = 141;
			//__SW_Right_Justifide(15);
			//__SX_Right_Justifide(90);
			//x = "safezonX + safezoneW - (16 * (((safezoneW / safezoneH) min 1.2) / 40))";
			//__SY(9.3);
			//__SH(2);
			x = "safezoneX + safezoneW - (16 * 			(			((safezoneW / safezoneH) min 1.2) / 40))";
			y = "safezoneY + (20.8 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "20 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			
		};
		class CBA_CREDITS_VER: VersionNumber {
			idc = CBA_CREDITS_VER_IDC;
			y = -1;
		};
		class CBA_CREDITS_VER_BTN: CBA_CREDITS_VER_BTN {
			idc = CBA_CREDITS_VER_BTN_IDC;
			onMouseButtonClick = "_this call compile preprocessFileLineNumbers '\x\cba\addons\help\ver_line.sqf';";
			onMouseEnter = QUOTE(GVAR(VerPause) = true);
			onMouseExit = QUOTE(GVAR(VerPause) = nil);
		};
		class CBA_CREDITS_CONT_C : CBA_CREDITS_CONT {
			idc = CBA_CREDITS_CONT_IDC;
		};
	};
	class controlsBackground {
		class CBA_CREDITS_M_M: CBA_CREDITS_M {
			idc = CBA_CREDITS_M_IDC;
		};	
	};
};

class RscDisplayInterrupt: RscStandardDisplay {
	class controls {
		class CBA_CREDITS_CONT_C: CBA_CREDITS_CONT {
			idc = CBA_CREDITS_CONT_IDC;
		};
		class CBA_CREDITS_M_P: CBA_CREDITS_M {
			idc = CBA_CREDITS_M_P_IDC;
		};
	};
};

class RscDisplayMPInterrupt: RscStandardDisplay {
	class controls {
		class CBA_CREDITS_CONT_C: CBA_CREDITS_CONT {
			idc = CBA_CREDITS_CONT_IDC;
		};
		class CBA_CREDITS_M_P: CBA_CREDITS_M {
			idc = CBA_CREDITS_M_P_IDC;
		};
	};
};


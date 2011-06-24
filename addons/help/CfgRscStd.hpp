#include "script_dialog_defines.hpp"

class RscStandardDisplay;
class RscStructuredText;
class RscActiveText;
class RscButton;

class CBA_CREDITS_CONT: RscStructuredText {
	idc = -1; //template
	colorBackground[] = { 0, 0, 0, 0 };
	__SX(0.025);
	__SY(0.964);
	__SW(0.725);
	__SH(0.025);
	size = "0.025 * SafeZoneH";
	class Attributes {
		font = "TahomaB";
		color = "#E0D8A6";
		align = "left";
		valign = "top";
		shadow = true;
		shadowColor = "#191970";
		size = "1";
	};
};

class CBA_CREDITS_M: RscActiveText { //mouse trap
	idc = -1; //template
	style = 48;
	__SX(0);
	__SY(0);
	__SW(1);
	__SH(1);
	default = 0;
	text = "#(argb,8,8,3)color(1,1,1,1)";
	color[] = {0,0,0,0};
	colorActive[] = {0,0,0,0};
	onMouseEnter = "(_this select 0) ctrlEnable false; (_this select 0) ctrlShow false; [_this] call compile preprocessFile '\x\cba\addons\help\show.sqf';";
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
		class CA_Version;
		class CBA_CREDITS_VER: CA_Version {
			idc = CBA_CREDITS_VER_IDC;
			y = -1;
		};
		class CBA_CREDITS_VER_BTN: CBA_CREDITS_VER_BTN {
			idc = CBA_CREDITS_VER_BTN_IDC;
			onMouseButtonClick = "[_this] call compile preprocessFile '\x\cba\addons\help\showver.sqf';";
			onMouseEnter = QUOTE(GVAR(VerTime) = 20);
			onMouseExit = QUOTE(GVAR(VerTime) = 2);
		};
		class CBA_CREDITS_M: CBA_CREDITS_M {
			idc = CBA_CREDITS_M_IDC;
			onMouseEnter = "(_this select 0) ctrlEnable false; (_this select 0) ctrlShow false; [_this, true] call compile preprocessFile '\x\cba\addons\help\showver.sqf';";
		};
	};
};

class RscDisplayInterrupt: RscStandardDisplay {
	class controls {
		class CBA_CREDITS_CONT : CBA_CREDITS_CONT {
			idc = CBA_CREDITS_CONT_IDC;
		};
		class CBA_CREDITS_M : CBA_CREDITS_M {
			idc = CBA_CREDITS_M_IDC;
		};
	};
};

class RscDisplayMPInterrupt: RscStandardDisplay {
	class controls {
		class CBA_CREDITS_CONT : CBA_CREDITS_CONT {
			idc = CBA_CREDITS_CONT_IDC;
		};
		class CBA_CREDITS_M : CBA_CREDITS_M {
			idc = CBA_CREDITS_M_IDC;
		};
	};
};


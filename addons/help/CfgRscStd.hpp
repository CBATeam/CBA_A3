#include "script_dialog_defines.hpp"

class RscStandardDisplay;
class RscStructuredText;
class RscActiveText;

class CBA_CREDITS_CONT : RscStructuredText {
	idc = CBA_CREDITS_CONT_IDC;
	colorBackground[] = { 0, 0, 0, 0 };
	__SX(0.25);
	__SY(0.01);
	__SW(0.74);
	__SH(0.025);
	size = "0.025 * SafeZoneH";
	class Attributes {
		font = "TahomaB";
		color = "#C8C8C8";
		align = "right";
		valign = "top";
		shadow = true;
		shadowColor = "#191970";
		size = "1";
	};
};

class CBA_CREDITS_M: RscActiveText {
	idc = CBA_CREDITS_M_IDC;
	style = 48;
	__SX(0);
	__SY(0);
	__SW(1);
	__SH(1);
	default = 0;
	text = "#(argb,8,8,3)color(1,1,1,1)";
	color[] = {0,0,0,0};
	colorActive[] = {0,0,0,0};
	onMouseEnter = "[_this] call compile preprocessFile '\x\cba\addons\help\show.sqf';";
};

class RscDisplayMain: RscStandardDisplay {
	class controlsBackground {
		class CBA_CREDITS_CONT : CBA_CREDITS_CONT {
			idc = CBA_CREDITS_CONT_IDC;
		};
	};
	class controls {
		class CBA_CREDITS_M : CBA_CREDITS_M {
			idc = CBA_CREDITS_M_IDC;
		};
	};
};

class RscDisplayInterrupt: RscStandardDisplay {
	class controlsBackground {
		class CBA_CREDITS_CONT : CBA_CREDITS_CONT {
			idc = CBA_CREDITS_CONT_IDC;
		};
	};
	class controls {
		class CBA_CREDITS_M : CBA_CREDITS_M {
			idc = CBA_CREDITS_M_IDC;
		};
	};
};

class RscDisplayMPInterrupt: RscStandardDisplay {
	class controlsBackground {
		class CBA_CREDITS_CONT : CBA_CREDITS_CONT {
			idc = CBA_CREDITS_CONT_IDC;
		};
	};
	class controls {
		class CBA_CREDITS_M : CBA_CREDITS_M {
			idc = CBA_CREDITS_M_IDC;
		};
	};
};


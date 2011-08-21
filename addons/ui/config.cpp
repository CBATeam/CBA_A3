#include "script_component.hpp"

class CfgPatches {
	class cba_ui {
		units[] = {};
		requiredVersion = 1;
		requiredAddons[] = { "CBA_common" };
		version = VERSION;
		author[] = {"Dr Eyeball"};
		authorUrl = "http://dev-heaven.net/projects/cca";
	};
};

#include "CfgFunctions.hpp"

class Extended_PreInit_EventHandlers {
	class cba_ui {
		clientInit = QUOTE(call COMPILE_FILE(XEH_preClientInit));
	};
};

//-----------------------------------------------------------------------------
// TODO: Delete these rsc/_flexiMenu_RscShortcutButton classes soon and transfer properties to menu classes, if any.
class RscText;
class RscShortcutButton;
//-------------------------------------
class _flexiMenu_RscShortcutButton: RscShortcutButton {
	class HitZone {
		left = 0.002;
		top = 0.003;
		right = 0.002;
		bottom = 0.003; //0.016;
	};
	class ShortcutPos {
		left = -0.006;
		top = -0.007;
		w = 0.0392157;
		h = 2*(safeZoneH/36); //0.0522876;
	};
	class TextPos {
		left = 0.01; // indent
		top = 0.002;
		right = 0.01;
		bottom = 0.002; //0.016;
	};
};
//-----------------------------------------------------------------------------
#include "flexiMenu\data\menu_rose.hpp"
#include "flexiMenu\data\menu_arma2.hpp"
#include "flexiMenu\data\menu_buttonList.hpp"
#include "flexiMenu\data\menu_iconRow.hpp"
#include "flexiMenu\data\menu_popup.hpp"

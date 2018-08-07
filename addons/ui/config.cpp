#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        requiredVersion = 1;
        requiredAddons[] = {"cba_common", "cba_arrays"};
        version = VERSION;
        authors[] = {"Dr Eyeball", "commy2"};
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"
#include "RscTitles.hpp"
#include "CfgUIGrids.hpp"

// Fixes Layout Editor only having 22 repositionable controls
class RscDisplayOptionsLayout {
    class controlsBackground {
        class Element021;
        #define ADD_ELEMENT(var1) class Element##var1: Element021 {\
            idc = __EVAL(12000 + var1);\
            onMouseEnter = "with uinamespace do {['mouseEnter',_this,''] call RscDisplayOptionsLayout_script;};";\
            onMouseExit = "with uinamespace do {['mouseExit',_this,''] call RscDisplayOptionsLayout_script;};";\
            onMouseHolding = "with uinamespace do {['mouseMoving',_this,''] call RscDisplayOptionsLayout_script;};";\
            onMouseMoving = "with uinamespace do {['mouseMoving',_this,''] call RscDisplayOptionsLayout_script;};";\
            onMouseButtonDown = "with uinamespace do {['mouseButtonDown',_this,''] call RscDisplayOptionsLayout_script;};";\
            onMouseButtonUp = "with uinamespace do {['mouseButtonUp',_this,''] call RscDisplayOptionsLayout_script;};";\
        }
        ADD_ELEMENT(022);
        ADD_ELEMENT(023);
        ADD_ELEMENT(024);
        ADD_ELEMENT(025);
        ADD_ELEMENT(026);
        ADD_ELEMENT(027);
        ADD_ELEMENT(028);
        ADD_ELEMENT(029);
        ADD_ELEMENT(030);
        ADD_ELEMENT(031);
        ADD_ELEMENT(032);
        ADD_ELEMENT(033);
        ADD_ELEMENT(034);
        ADD_ELEMENT(035);
        ADD_ELEMENT(036);
        ADD_ELEMENT(037);
        ADD_ELEMENT(038);
        ADD_ELEMENT(039);
        ADD_ELEMENT(040);
        ADD_ELEMENT(041);
        ADD_ELEMENT(042);
        ADD_ELEMENT(043);
        ADD_ELEMENT(044);
        ADD_ELEMENT(045);
        ADD_ELEMENT(046);
        ADD_ELEMENT(047);
        ADD_ELEMENT(048);
        ADD_ELEMENT(049);
        ADD_ELEMENT(050);
        ADD_ELEMENT(051);
        ADD_ELEMENT(052);
        ADD_ELEMENT(053);
        ADD_ELEMENT(054);
        ADD_ELEMENT(055);
        ADD_ELEMENT(056);
        ADD_ELEMENT(057);
        ADD_ELEMENT(058);
        ADD_ELEMENT(059);
        ADD_ELEMENT(060);
        ADD_ELEMENT(061);
        ADD_ELEMENT(062);
        ADD_ELEMENT(063);
        ADD_ELEMENT(064);
        ADD_ELEMENT(065);
        ADD_ELEMENT(066);
        ADD_ELEMENT(067);
        ADD_ELEMENT(068);
        ADD_ELEMENT(069);
        ADD_ELEMENT(070);
        ADD_ELEMENT(071);
        ADD_ELEMENT(072);
        ADD_ELEMENT(073);
        ADD_ELEMENT(074);
        ADD_ELEMENT(075);
        ADD_ELEMENT(076);
        ADD_ELEMENT(077);
        ADD_ELEMENT(078);
        ADD_ELEMENT(079);
        ADD_ELEMENT(080);
        ADD_ELEMENT(081);
        ADD_ELEMENT(082);
        ADD_ELEMENT(083);
        ADD_ELEMENT(084);
        ADD_ELEMENT(085);
        ADD_ELEMENT(086);
        ADD_ELEMENT(087);
        ADD_ELEMENT(088);
        ADD_ELEMENT(089);
        ADD_ELEMENT(090);
        ADD_ELEMENT(091);
        ADD_ELEMENT(092);
        ADD_ELEMENT(093);
        ADD_ELEMENT(094);
        ADD_ELEMENT(095);
        ADD_ELEMENT(096);
        ADD_ELEMENT(097);
        ADD_ELEMENT(098);
        ADD_ELEMENT(099);
    };
};

//-----------------------------------------------------------------------------
// TODO: Delete these rsc/_flexiMenu_RscShortcutButton classes soon and transfer properties to menu classes, if any.
class RscShortcutButton;
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

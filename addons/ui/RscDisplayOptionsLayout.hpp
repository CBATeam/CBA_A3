// Fixes Layout Editor only having 22 repositionable controls
class RscDisplayOptionsLayout {
    class controlsBackground {
        class Element021;
        class Element022: Element021 {
            idc = 12022;
            onMouseEnter = "with uiNamespace do {['mouseEnter',_this,''] call RscDisplayOptionsLayout_script;};";
            onMouseExit = "with uiNamespace do {['mouseExit',_this,''] call RscDisplayOptionsLayout_script;};";
            onMouseHolding = "with uiNamespace do {['mouseMoving',_this,''] call RscDisplayOptionsLayout_script;};";
            onMouseMoving = "with uiNamespace do {['mouseMoving',_this,''] call RscDisplayOptionsLayout_script;};";
            onMouseButtonDown = "with uiNamespace do {['mouseButtonDown',_this,''] call RscDisplayOptionsLayout_script;};";
            onMouseButtonUp = "with uiNamespace do {['mouseButtonUp',_this,''] call RscDisplayOptionsLayout_script;};";
        };
        #define ADD_ELEMENT(var1) class Element##var1: Element022 {\
            idc = 12##var1;\
        }
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

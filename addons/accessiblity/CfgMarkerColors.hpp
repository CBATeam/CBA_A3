#define GET_COLOR(index,varName,defaultR,defaultG,defaultB) QUOTE((missionNamespace getVariable [ARR_2(QQGVAR(varName), [ARR_3(defaultR,defaultG,defaultB)])]) select index)

class CfgMarkerColors {
    class Default;
    class ColorRed: Default {
        color[] = {GET_COLOR(0,red,1,0,0), GET_COLOR(1,red,1,0,0), GET_COLOR(2,red,1,0,0), 1};
    };
    class ColorGreen: Default {
        color[] = {GET_COLOR(0,green,0,1,0), GET_COLOR(1,green,0,1,0), GET_COLOR(2,green,0,1,0), 1};
    };
    class ColorBlue: Default {
        color[] = {GET_COLOR(0,blue,0,0,1), GET_COLOR(1,blue,0,0,1), GET_COLOR(2,blue,0,0,1), 1};
    };
};

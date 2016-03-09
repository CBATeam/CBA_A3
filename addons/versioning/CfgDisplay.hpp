
class RscDisplayCommonMessage;
class CBA_DisplayMessage: RscDisplayCommonMessage {
    idd = -1;
    movingEnable = 1;
    onLoad = "['onLoad', _this, 'CBA_DisplayMessage',''] call (uiNamespace getVariable 'BIS_fnc_initDisplay')";
    onUnload = "['onUnload', _this, 'CBA_DisplayMessage',''] call (uiNamespace getVariable 'BIS_fnc_initDisplay')";
};

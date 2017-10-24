class RscListBox;
class RscButtonMenuOK;

class RscStandardDisplay;
class RscDisplayMultiplayer: RscStandardDisplay {
    class Controls {
        class CA_Join: RscButtonMenuOK {
            onMouseButtonDown = "uiNamespace setVariable ['CBA_isCached', nil]";
            onKeyDown = "uiNamespace setVariable ['CBA_isCached', nil]";
        };
        class CA_ValueSessions: RscListBox {
            onMouseButtonDown = "uiNamespace setVariable ['CBA_isCached', nil]";
        };
    };
};

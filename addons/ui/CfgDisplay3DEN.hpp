class ctrlMenuStrip;

class Display3DEN {
    class Controls {
        class MenuStrip: ctrlMenuStrip {
            class Items {
                class Tools {
                    text = "Tools";
                    items[] += {QGVAR(LobbyManager)};
                };
                class GVAR(LobbyManager) {
                    text = CSTRING(LobbyManager);
                    data = QGVAR(LobbyManager);
                    shortcuts[] = {INPUT_CTRL_OFFSET + DIK_L};
                    action = "call (uiNamespace getVariable 'CBA_fnc_openLobbyManager')";
                    enable = 1;
                    opensNewWindow = 1;
                };
            };
        };
    };
};

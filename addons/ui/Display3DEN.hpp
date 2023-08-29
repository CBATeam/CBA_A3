class Display3DEN {
    class Controls {
        class MenuStrip: ctrlMenuStrip {
            class Items {
                class Tools {
                    items[] += {QGVAR(LobbyManager)};
                };
                class GVAR(LobbyManager) {
                    text = CSTRING(LobbyManager);
                    data = QGVAR(LobbyManager);
                    shortcuts[] = {QUOTE(INPUT_CTRL_OFFSET + DIK_L)};
                    action = QUOTE(call (uiNamespace getVariable 'CBA_fnc_openLobbyManager'));
                    enable = 1;
                    opensNewWindow = 1;
                };
            };
        };
    };
};

class ctrlMenuStrip;

class Display3DEN {
    class Controls {
        class MenuStrip: ctrlMenuStrip {
            class Items {
                class DebugConsole {
                    shortcuts[] = {QUOTE(INPUT_CTRL_OFFSET + DIK_D)};
                };
                class FunctionsViewer {
                    shortcuts[] = {QUOTE(INPUT_ALT_OFFSET + DIK_F)};
                };
                class ConfigViewer {
                    shortcuts[] = {QUOTE(INPUT_ALT_OFFSET + DIK_G)};
                };
            };
        };
    };
};


class ctrlMenuStrip;

class Display3DEN {
    class Controls {
        class MenuStrip: ctrlMenuStrip {
            class Items {
                class Options {
                    items[] += {QUOTE(ADDON)};
                };
                class ADDON {
                    text = CSTRING(3den_shortcut);
                    action = QUOTE(findDisplay 313 call COMPILE_FILE(openSettingsMenu));
                    data = QUOTE(ADDON);
                    shortcuts[] = {INPUT_CTRL_OFFSET + INPUT_ALT_OFFSET + DIK_S};
                };
            };
        };
    };
};

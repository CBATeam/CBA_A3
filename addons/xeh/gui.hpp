
class RscControlsGroup;
class RscText;
class RscCheckBox;

class RscDisplayGameOptions {
    class controls {
        class GeneralGroup: RscControlsGroup {
            class controls {
                class CBA_EnableDebugText: RscText {
                    style = 1;
                    idc = IDC_ENABLE_DEBUG_TEXT;
                    text = "Debug Mode:";
                    x = 18 * GUI_GRID_W;
                    y = 16 * GUI_GRID_H;
                    w = 9.5 * GUI_GRID_W;
                    h = 1 * GUI_GRID_H;
                };
                class CBA_EnableDebugOption: RscCheckBox {
                    onLoad = QUOTE(\
                        params ['_control'];\
                        _control cbSetChecked (uiNamespace getVariable [ARR_2('GVAR(debugEnabled)',false)]);\
                        private _ctrlBtnOK = ctrlParent _control displayCtrl 999;\
                        _ctrlBtnOK ctrlAddEventHandler [ARR_2('ButtonClick',{\
                            params ['_ctrlBtnOK'];\
                            private _control = ctrlParent _ctrlBtnOK displayCtrl IDC_ENABLE_DEBUG_OPTION;\
                            private _state = _control getVariable [ARR_2('GVAR(debugEnabled)',false)];\
                            if (!isNil '_state') then {\
                                uiNamespace setVariable [ARR_2('GVAR(debugEnabled)',_state)];\
                            };\
                        })];\
                    );
                    onCheckedChanged = QUOTE(\
                        params [ARR_2('_control','_state')];\
                        _state = _state == 1;\
                        _control setVariable [ARR_2('GVAR(debugEnabled)',_state)];\
                    );
                    idc = IDC_ENABLE_DEBUG_OPTION;
                    x = 29.5 * GUI_GRID_W;
                    y = 16 * GUI_GRID_H;
                    w = 1 * GUI_GRID_W;
                    h = 1 * GUI_GRID_H;
                    tooltip = "";
                };
            };
        };
    };
};

class RscStandardDisplay;
class RscDisplayPassword: RscStandardDisplay {
    class controlsbackground {
        class GVAR(initScript): RscText {
            onLoad = QUOTE(ctrlParent (_this select 0) call (uiNamespace getVariable 'FUNC(initDisplayPassword)'));
            w = 0;
            h = 0;
        };
    };
};

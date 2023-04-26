class RscControlsGroupNoScrollbars;
class RscTitles {
    class GVAR(hintDisplay) {
        idd = -1;
        duration = 1e+99;
        fadeIn = 0;
        fadeOut = 0;
        movingEnable = 0;

        class controls {
            class HintContainer: RscControlsGroupNoScrollbars {
                idc = -1;

                x = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(hints),X)', HINT_CONTAINER_X];
                y = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(hints),Y)', HINT_CONTAINER_Y];
                w = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(hints),W)', HINT_CONTAINER_W];
                h = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(hints),H)', HINT_CONTAINER_H];

                onLoad = QUOTE(call FUNC(onLoadHintsContainer));
                onUnload = QUOTE(call FUNC(onUnloadHintsContainer));

                class controls {};
            };
        };
    };
};

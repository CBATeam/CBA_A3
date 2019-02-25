#include "script_component.hpp"
// execVM "\x\cba\addons\ui\test_preload.sqf";

isNil {
    with uiNamespace do {
        TEST_DEFINED(QFUNC(preload3DEN),"");

        AmmoBox_list = nil;
        ["onLoad", [controlNull]] call compile preprocessFile "\a3\3den\UI\Attributes\AmmoBox.sqf";
        private _vanilla = AmmoBox_list;

        AmmoBox_list = nil;
        call FUNC(preload3DEN);
        private _cba = AmmoBox_list;

        TEST_TRUE(_vanilla isEqualTo _cba,QFUNC(preload3DEN));
    };
};

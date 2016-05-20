
class Extended_PreStart_EventHandlers {
    class cba_events {
        init = __EVAL(call compile "[""call compile preProcessFileLineNumbers '\x\cba\addons\events\XEH_preStart.sqf'"",""call compile preProcessFileLineNumbers '\x\cba\addons\events\XEH_preStart_Linux.sqf'""] select (productVersion select 2 <= 154)");
    };
};

class Extended_PreInit_EventHandlers {
    class cba_common {
        init = __EVAL(call compile "[""call compile preProcessFileLineNumbers '\x\cba\addons\common\XEH_preInit.sqf'"",""call compile preProcessFileLineNumbers '\x\cba\addons\common\XEH_preInit_Linux.sqf'""] select (productVersion select 2 <= 154)");
    };
    class cba_events {
        init = __EVAL(call compile "[""call compile preProcessFileLineNumbers '\x\cba\addons\events\XEH_preInit.sqf'"",""call compile preProcessFileLineNumbers '\x\cba\addons\events\XEH_preInit_Linux.sqf'""] select (productVersion select 2 <= 154)");
    };
};

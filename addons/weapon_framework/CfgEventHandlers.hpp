class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};

class Extended_FiredBIS_Eventhandlers {
	class CAManBase
	{
		class ADDON {
			firedBIS = QUOTE(call FUNC(unit_fired));
		};
	};
};

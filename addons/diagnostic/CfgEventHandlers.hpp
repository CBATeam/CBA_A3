class Extended_PreInit_EventHandlers
{
	class ADDON
	{
		init = QUOTE(CALLF(XEH_PreInit_Once));
	};
};

class Extended_PostInit_EventHandlers
{
	class ADDON
	{
		init = QUOTE(CALLF(XEH_PostInit_Once));
	};
};

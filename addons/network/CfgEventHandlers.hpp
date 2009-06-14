class Extended_PreInit_EventHandlers
{
	class ADDON
	{
		init = STR(CALLF(XEH_PreInit_Once));
	};
};

class Extended_PostInit_EventHandlers
{
	class ADDON
	{
		clientInit = STR(EXECF(XEH_ClientInit_Once));
	};
};
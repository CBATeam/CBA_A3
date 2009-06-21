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
		clientInit = QUOTE(EXECF(XEH_ClientInit_Once));
	};
};

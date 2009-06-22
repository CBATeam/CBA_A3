class Extended_PreInit_EventHandlers
{
	class ADDON
	{
		init = QUOTE(CALLF(XEH_PreInit_Once));
		clientInit = QUOTE(EXECF(XEH_ClientInit_Once));
	};
};
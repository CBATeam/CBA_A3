class Extended_PreInit_EventHandlers
{
	class ADDON
	{
		init = STR(CALLF(XEH_PreInit_Once));
		clientInit = STR(EXECF(XEH_ClientInit_Once));
	};
};
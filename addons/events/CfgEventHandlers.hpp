class Extended_PreInit_EventHandlers
{
	class ADDON
	{
		init = QUOTE(call COMPILE_FILE(XEH_PreInit_Once));
		clientInit = QUOTE(execVM COMPILE_FILE(XEH_ClientInit_Once));
	};
};
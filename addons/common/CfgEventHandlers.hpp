// TODO: Find better way to schedule which addon inits first, does not seem to be alphabetic, but when the addon loads (probably filename/prefixname/other loading order)
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
		clientInit = QUOTE(CALLF(XEH_ClientInit_Once));
	};
};
// TODO: Find better way to schedule which addon inits first, does not seem to be alphabetic, but when the addon loads (probably filename/prefixname/other loading order)
class Extended_PreInit_EventHandlers
{
	class ADDON
	{
		init = QUOTE(call COMPILE_FILE(XEH_preInit));
		clientInit = QUOTE(call COMPILE_FILE(XEH_preClientInit));
	};
};

class Extended_PostInit_EventHandlers
{
	class ADDON
	{
		init = QUOTE(call COMPILE_FILE(XEH_postInit));
	};
};

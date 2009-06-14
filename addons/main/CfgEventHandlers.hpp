#ifndef CBA_MAIN_EVENT_HANDLERS_INCLUDED
#define CBA_MAIN_EVENT_HANDLERS_INCLUDED

#include "script_component.hpp"

// TODO: Find better way to schedule which addon inits first, does not seem to be alphabetic, but when the addon loads (probably filename/prefixname/other loading order)
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
		init = STR(CALLF(XEH_PostInit_Once));
		clientInit = STR(CALLF(XEH_ClientInit_Once));
	};
};

#endif
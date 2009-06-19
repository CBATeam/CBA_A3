/*  PostInit.sqf

    Compile code strings in the Extended_PostInit_EventHandlers class and call
    them. This is done once per mission and after all the extended init event
    handler code is run. An addon maker can put run-once, late initialisation
    code in such a post-init "EH" rather than in a normal XEH init EH which
     might be called several times.
*/

// On Server + Non JIP Client, we are now after all objects have inited
// and at the briefing, still time == 0

if (isNull player) then
{
	if !(isServer) then
	{
		SLX_XEH_MACHINE set [1, true]; // set JIP
		waitUntil { !(isNull player) };
		waitUntil { local player };
		/*
		// For JIP players only: Usually we are now a few ms/seconds into
		// the game. Test for JIP players
		_i = 0;
		while { _i < 20 } do
		{
			_i = _i + 1;
			sleep 1;
		};
		*/
	};
};

if !(isNull player) then
{
	if (isNull (group player)) then
	{
		// DEBUG TEST: Crashing due to JIP, or when going from briefing
		//             into game
		waitUntil { !(isNull (group player)) };
	};
	SLX_XEH_rmon = execVM "extended_eventhandlers\RespawnMonitor.sqf";
};
SLX_XEH_MACHINE set [5, true]; // set player check = complete

// General InitPosts
(configFile/"Extended_PostInit_EventHandlers") call SLX_XEH_F_INIT;


// we set this BEFORE executing the inits, so that any unit created in another
// thread still gets their InitPost ran
SLX_XEH_MACHINE set [7, true];
{ _x call SLX_XEH_init } forEach SLX_XEH_OBJECTS; // Run InitPosts

nil;

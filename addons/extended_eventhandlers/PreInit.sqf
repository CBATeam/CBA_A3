/*  PreInit.sqf

	Compile code strings in the Extended_PreInit_EventHandlers class and call
	them. This is done once per mission and before any extended init event
	handler code is run. An addon maker can put run-once initialisation code
	in such a pre-init "EH" rather than in a normal XEH init EH which might be
	called several times.
*/
{
	(_x/"Extended_PreInit_EventHandlers") call SLX_XEH_F_INIT;
} forEach [configFile, campaignConfigFile, missionConfigFile];

nil;

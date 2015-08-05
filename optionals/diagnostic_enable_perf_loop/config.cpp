////////////////////////////////////////////////////////////////////
//DeRap: Produced from mikero's Dos Tools Dll version 5.16
//Produced on Mon Jun 07 03:11:11 2010 : Created on Mon Jun 07 03:11:11 2010
//http://dev-heaven.net/projects/list_files/mikero-pbodll
////////////////////////////////////////////////////////////////////

#define _ARMA_

//Class cba_diagnostic_enable_perf_loop : config.bin{
class CfgPatches
{
	class cba_diagnostic_enable_perf_loop
	{
		units[] = {};
		requiredVersion = 1.02;
		requiredAddons[] = {"CBA_common","CBA_diagnostic"};
		version = "0.4.1.101";
		author[] = {"Spooner","Sickboy"};
		authorUrl = "http://dev-heaven.net/projects/cca";
	};
};
class Extended_postInit_EventHandlers
{
	class cba_diagnostic_enable_perf_loop
	{
		init = "[] spawn cba_diagnostic_fnc_perf_loop";
	};
};
//};

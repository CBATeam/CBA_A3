CBA: Community Base Addons - OPTIONAL ADDONS
============================================

cba_cache_disable.pbo                  => Dev Tool. Copy this to your cba\addons if you want to disable CBA's caching of functions.
cba_diagnostic_disable_xeh_logging.pbo => Copy this to your cba\addons if you want to disable all the extra RPT logging.
cba_diagnostic_enable_logging.pbo      => DEV Tool. Copy this to your cba\addons if you want to enable more logging.


Background on CBA Caching
=========================
CBA implements a cache for all compile preProcessFile'd scripts (incl CfgFunctions, BIS functions module etc), and for all XEH events 
on CfgVehicle classes. This cache is stored in the uiNamespace and is therefore available throughout the whole lifetime of the running 
game (game start, till terminate game). Each class is only cached once, while mission and campaignConfigfile events are obviously 
evaluated every mission, but also only once per CfgVehicle class.

The performance gains are seen in feature heavy mods like ACE or AGM which release on scripting to make their features possible. 
Some of these functions need a long time to initialize the game, switching missions, islands, going from editor back to the game, 
and so forth. 2nd-nth mission (re)starts go faster, but it is still nowhere near as fast as playing the Vanilla game. 

cba_cache_disable.pbo is an addon that can disable this if you need it however it makes mods slower by disabling CBA's function and 
script compilation cache, and xeh cache.  It is useful during development so that edits will take effect without having to restart 
the game. 

References: 
* http://wiki.ace-mod.net/Performance_Revolution
* http://forums.bistudio.com/showthread.php?103871-CBA-Community-Base-Addons-for-A2-OA-and-CO&p=2065505&viewfull=1#post2065505


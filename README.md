# Community Base Addons

[![](https://img.shields.io/badge/Changelog-2.0-orange.svg?style=flat-square)](https://github.com/CBATeam/CBA_A3/issues?q=milestone%3A%22CBA_A3+v2.0%22+is%3Aclosed)
[![](https://img.shields.io/badge/Release-2.0-blue.svg?style=flat-square)](https://github.com/CBATeam/CBA_A3/releases/tag/v2.0.0.150817)
[![](https://img.shields.io/badge/Github-Wiki-lightgrey.svg?style=flat-square)](https://github.com/CBATeam/CBA_A3/wiki)
[![](https://img.shields.io/badge/Function-Documentation-yellow.svg?style=flat-square)](https://cbateam.github.io/CBA_A3/docs/files/overview-txt.html)

## Installation

Download the latest version and unpack in your ARMA installation folder.
For ARMA 3 content, launch with `-mod=@CBA_A3`

## Optionals

PBO                                    | Description
-------------------------------------- | --------------------------------------
cba_cache_disable.pbo                  | Dev Tool. Copy this to your cba\addons if you want to disable CBA's caching of functions.
cba_diagnostic_disable_xeh_logging.pbo | Copy this to your cba\addons if you want to disable all the extra RPT logging.
cba_diagnostic_enable_logging.pbo      | Dev Tool. Copy this to your cba\addons if you want to enable more logging.
cba_enable_auto_xeh.pbo                | This will add extended event handler (XEH) functionality to units and vehicles that are not XEH enabled. This may cause unforeseen side effects.

### CBA Caching

CBA implements a cache for all `compile preProcessFile`'d scripts (incl `CfgFunctions`, BIS functions module etc), and for all XEH events
on `CfgVehicle` classes. This cache is stored in the `uiNamespace` and is therefore available throughout the whole lifetime of the running
game (game start, till terminate game). Each class is only cached once, while mission and `campaignConfigfile` events are obviously
evaluated every mission, but also only once per `CfgVehicle` class.

The performance gains are seen in feature heavy mods like ACE or AGM which release on scripting to make their features possible.
Some of these functions need a long time to initialize the game, switching missions, islands, going from editor back to the game,
and so forth. 2nd-nth mission (re)starts go faster, but it is still nowhere near as fast as playing the Vanilla game.

`cba_cache_disable.pbo` is an addon that can disable this if you need it however it makes mods slower by disabling CBA's function and
script compilation cache, and xeh cache. It is useful during development so that edits will take effect without having to restart
the game.

## Known Issues

* CBA Keybinding requires a mission to be initialized to function properly. This includes working in the main menu of Arma 3. Command-line parameters like `-world=empty` or `-skipIntro` will cause Keybinding to work ONLY in-game but NOT in the main menu of Arma.

## License

Licensed under [GNU GENERAL PUBLIC LICENSE v2](license.txt)

Any addon which calls CBA-defined functions need not be licensed under the GPLv2
or released under a free software license. Only if you are directly including
CBA code in your addon's binarized PBO or redistributing a modified version of
CBA itself would your work be considered derivative and therefore be legally
required to be released under the terms of the GPL. (And there's no reason to
ever do either of these.)

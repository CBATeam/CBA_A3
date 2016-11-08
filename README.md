# Community Base Addons
[![](https://travis-ci.org/CBATeam/CBA_A3.svg?style=flat-square)](https://travis-ci.org/CBATeam/CBA_A3)
[![](https://img.shields.io/badge/Changelog--orange.svg?style=flat-square)](https://github.com/CBATeam/CBA_A3/issues?q=milestone%3A3.1.2+is%3Aclosed)
[![](https://img.shields.io/badge/Release-3.1.2-blue.svg?style=flat-square)](https://github.com/CBATeam/CBA_A3/releases/tag/v3.1.2.161105)
[![](https://img.shields.io/badge/Github-Wiki-lightgrey.svg?style=flat-square)](https://github.com/CBATeam/CBA_A3/wiki)
[![](https://img.shields.io/badge/BIF-Thread-lightgrey.svg?style=flat-square)](https://forums.bistudio.com/topic/168277-cba-community-base-addons-arma-3)
[![](https://img.shields.io/badge/Function-Documentation-yellow.svg?style=flat-square)](https://cbateam.github.io/CBA_A3/docs/files/overview-txt.html)

## Installation

Download the latest version and unpack it in your Arma 3 installation folder.
Simply launch Arma 3 with `-mod=@CBA_A3` afterwards.

## Optionals

To install any of the optionals, simply copy the respective PBOs into the `@CBA_A3\addons` folder.

PBO                                    | Description
-------------------------------------- | --------------------------------------
cba_cache_disable.pbo                  | Disables CBA's function caching. (Dev Tool)
cba_diagnostic_disable_xeh_logging.pbo | Disables all additional XEH RPT logging.
cba_diagnostic_enable_logging.pbo      | Enables additional logging (Dev Tool)

### CBA Caching

CBA implements a cache for all `compile preProcessFile`'d scripts (incl `CfgFunctions`, BIS functions module, etc), and for all XEH events on `CfgVehicle` classes. This cache is stored in the `uiNamespace` and is therefore available throughout the whole lifetime of the running game (game start, till terminate game). Each class is only cached once, while mission and `campaignConfigfile` events are evaluated every mission, but also only once per `CfgVehicle` class.

The performance gains are seen in feature rich mods like ACE3 which rely heavily on scripting to make their features possible.
Some of these functionalities cause long loading times for the game, switching missions, islands and switching from the editor back to the game.
After the first mission load functions will be cached and loading times for functions will be comparable with the vanilla game.

`cba_cache_disable.pbo` is an optional addon that can disable this if you need it. However it makes mods slower by disabling CBA's function and script compilation cache, as well as the XEH cache. It is useful during development, since script changes will take effect without restarting the entire game.

## Known Issues

* CBA Keybindings require a mission to be initialized to function properly. This includes working in the main menu of Arma 3. Commandline parameters like `-world=empty` or `-skipIntro` will cause Keybinding to work ONLY in-game but NOT in the main menu.

## License

Licensed under GNU General Public License ([GPLv2](LICENSE.md))

Any addon which calls CBA-defined functions need not be licensed under the GPLv2 or released under a free software license. Only if it is directly including CBA code in the addon's binarized PBO or redistributing a modified version of CBA itself would it be considered derivative and therefore be legally required to be released under the terms of the GPL. (And there's no reason to ever do either of these.)

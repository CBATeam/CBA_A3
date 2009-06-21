Extended Event Handlers (XEH) by Solus and Killswitch

Version:  2.00
Released: 2009-06-21


Creator:      Solus
Maintainer:   Killswitch
Contributors: Sickboy


Introduction
============
This addon allows a virtually infinite amount of event handlers to be used
together from different addons. The event handlers are executed for the matching
class and all inheriting classes. The event handler init line also contains the
extended event handler class to look for, so you can have a custom inheritance
for custom units.

Normally event handlers can only be added in configs, and trying to add a new
event handler caused all previous event handlers to be overwritten. This addon
allows that limitation to be overcome. This is mostly useful for having addons
that can add different functionality, for example in OFP addons that had their
own event handlers wouldn't inherit default event handlers, such as a custom
unit with EHs being used with ECP or FFUR wouldn't have the ECP or FFUR effects.


"Other" extended event handlers by Killswitch
=============================================
This adds support for using extended event handlers for all Arma event types


Extended fired event handler
=============================
This allows a virtually infinite amount of fired event handlers to be used
together from different addons.

The extended fired event handler has several different parts:

    First the extended init EH is run for all units to add together and 
    compile    all of the inherited fired event handlers and use setVariable to
    attach those to the unit.

    The extended fired event handler is added to the base class called
    Extended_EventHandlers so that all the CfgVehicles class EventHandlers
    inherit it. When a unit fires and sets off the event handler the shot is
    immediately captured in the same game state cycle. Then the compiled
    extended fired events are called by using getVariable to retrieve them
    from the unit.


The fired event handler init line contains the extended event handler class to
look for, so you can have a custom inheritance for custom units. The event
handlers are executed for the matching class and all inheriting classes.

It allows more fired events to be used together, for example a script that makes
shots affected by wind and a tracer script could be used together.



Examples
========
There are two example Extended Init addons included to demonstrate how to assign
new event handlers and the event handler inheritance. The example pbos should
not be installed except for testing.

There is an example addon included to demonstrate how to assign new fired event
handlers and the event handler inheritance. The example also has a quickly
called function that is able to capture information on the shot in the same game
state cycle before the shot is updated and moves away from it's starting
position and changes it's status. The example pbo should not be installed except
for testing.

The addon "SightAdjustment_AutoInit.pbo" is an addon that makes gmJamez' 
"GMJ_SightAdjustment" addon compatible with XEH.

Note to addon makers: Before XEH 1.1, you had to make sure to add a ";" at the
end of your extended init line to separate it from other extended inits. This
is no longer necessary - the Extended Init EH will separate them automatically,
so ending without one won't cause a problem

New in 1.3: Limiting certain event handler to a specific vehicle class
======================================================================
The example addon "SLX_Advanced_Init_Example" shows how to create
an XEH init EH that will only be used on units that are of the class SoldierWB,
ie the West "Rifleman". Units that inherit from "SoldierWB", eg the Grenadier,
won't run the init EH. 

One can do the same thing for the other XEH event types. For example, to add a
"GetIn" event handler that works only on the the vehicle XYZ_BRDM2, but not on
the XYZ_BRDM2_ATGM variant you would do something like this:


...
class Extended_GetIn_Eventhandlers
{
    class XYZ_BRDM2
    {
        class XYZ_BRDM2_GetIn
        {
            scope = 0;
            getin = "[] exec '\xyz_brdm2\getin.sqf'";
        };
    };
};


class Vehicles
{
    ...
    class XYZ_BRDM2: BRDM2
    {
        ...
    };
    class XYZ_BRDM2_ATGM: XYZ_BRDM2
    {
        ...
    };
};

Note that within that innermost XEH class, you have to put a string value with
the same name as the desired event handler. In the above example it was "getin".
For the "fired" event handler, you would use

...
class Extended_Fired_Eventhandlers
{
    class SoldierEB
    {
        class XYZ_SoldierEB_fired
        {
            scope=0;
            // We wish to make a SoldierEB-specific *Fired* EH, so the
            // property name should be "fired"
            //
            fired = "_this call XYZ_SoldierEB_fired";
        };
    };
};
...


New in 1.5: Excluding certain descendant vehicle types
======================================================
With XEH 1.5, you can exclude one or more subtypes of a vehicle from
getting a certain XEH event handler. To do this, you add a directive,
exclude, in an inner, "composite" XEH class (introduced in 1.3)

Here's an example of how to exclude the west pilot class from running
the basic Man class XEH init event handler. Instead, there's a special
init for the pilot ("SoldierWPilot"). Note that all subclasses of
"SoldierWPilot" will be excluded from using the basic class Man XEH
init too.


/*
 *   Init XEH exclusion example 1
 */
class CfgPatches
{
   class xeh_exclusion_example1
   {
       units[]={};
       weapons[]={};
       requiredVersion=0.1;
       requiredAddons[]={"Extended_Eventhandlers"};
   };
};

class Extended_Init_Eventhandlers
{
    class Man
    {
        // To use the exclude directive, we'll have to make this an
        // "inner" (composite) XEH init EH class
        class XEH_Exclusion1_Man
        {
            exclude="SoldierWPilot";
            init = "[] execVM '\xeh_exclusion_example1\init_man.sqf'";
        };
    };

    class SoldierWPilot
    {
        xeh_init = "[] execVM '\xeh_exclusion_example1\init_west_pilot.sqf'";
    };
};


In the second example, we'll exclude both the standard west and east
pilots and add unique init EH:S to them and the BIS Camel pilot. To do
so, use the exclude[] directive in array form:

/*
 *   Init XEH exclusion example 2
 */
class CfgPatches
{
   class xeh_exclusion_example2
   {
       units[]={};
       weapons[]={};
       requiredVersion=0.1;
       requiredAddons[]={"Extended_Eventhandlers"};
   };
};

class Extended_Init_Eventhandlers
{
    class Man
    {
        // To use the exclude directive, we'll have to make this an
        // "inner" (composite) XEH init EH class
        class XEH_Exclusion2_Man
        {
            exclude[] = {"SoldierWPilot", "SoldierEPilot"};
            init = "[] execVM '\xeh_exclusion_example2\init_man.sqf'";
        };
    };

    // All descendants of SoldierEPilot will use this XEH init EH
    class SoldierEPilot
    {
        xeh_init = "[] execVM '\xeh_exclusion_example2\init_east_pilot.sqf'";
    };

    // Using scope=0, only SoldierWPilot will get this particular XEH init
    class SoldierWPilot
    {
        scope=0;
        xeh_init = "[] execVM '\xeh_exclusion_example2\init_west_pilot.sqf'";
    };

    // Here, we add an event handler for the BIS Camel Pilot (which is a
    // descendant of "SoldierWPilot". It won't run "init_west_pilot.sqf" though
    // since we used "scope=0" above.
    class BISCamelPilot
    {
        xeh_init="[] execVM'\xeh_exclusion_example2\init_west_camel_pilot.sqf'";
    };
};

You can do the same thing with the other XEH event types (fired, hit and so on).


New in 1.8: making XEH init event handlers run when a unit respawns
===================================================================
Normally, when a player respawns into a new unit (object), the init event
handler is not executed again. However, with XEH 1.8, you can make an XEH init
event handler be rerun when the new unit spawns. To do so, declare your init EH
as a "composite EH class" (described above). Then, add a property to it called
"onRespawn" and set it to true (the number 1). 

Here's an example that shows how to do it:

#define false 0
#define true  1

class Extended_Init_Eventhandlers
{
    class Man
    {
        class SLX_XEH_RespawnInitMan
        {
            onRespawn = true;                    // Run this even after respawn
            init      = "_this call My_Respawn_InitEH";
        };
    };
};

The example above will cause all classes that are descendants of class "Man"
to have the function "My_Respawn_InitEH" called both when the unit is created
and after a player has respawned into a new unit.

Note that unless you have "onRespawn=true" like above, XEH will use the default
ArmA behaviour which is to NOT run the init EH when a unit respawns.

IMPORTANT: This feature will only work on the player's unit - AI units that
respawn won't have their XEH init EH:s re-executed. (If someone can figure
out a trick to identify playable units in a MP mission, this limitation could
be removed)

New in 1.9: version stringtable and "pre-init EH" code
======================================================
You can get a string with the version of Extended_Eventhandlers using the
"localize" command. Here's an example function which will return the
version as a decimal number or "0" if XEH isn't installed;

/*
    Return the version of Extended_Eventhandlers, or 0 if the addon
    isn't installed.
*/
_fXEHversion = {
    private ["_str", "_cfg", "_ver"];
    _cfg=(configFile/"CfgPatches"/"Extended_Eventhandlers"/"SLX_XEH2_Version");
    _ver=0;

    _str=localize "STR_SLX_XEH_VERSION";
    if !(_str == "") then {
        _ver=call compile _str;
    } else {
        // XEH version 1.8 and earlier lacks the stringtable version
        if (isNumber _cfg) then {
            _ver=getNumber _cfg;
        };
    };
    _ver
};

Another addition is a way to put code that you want to run only once in
a new class, Extended_PreInit_EventHandlers. Anything in that class will
be called early and before any of the normal extended init event handlers
have run. 

Here's an example: let's say there's an addon with the following XEH init:

// Addon: SLX_MyAddon (old)
class Extended_Init_EventHandlers
{
    class Man
    {
        SLX_Man_init="_this call compile preprocessFile'\SLX_MyAddon\init.sqf'";
    };
};


Using the "pre-init" system, that can be rewritten as:

// Addon: SLX_MyAddon (new)
class Extended_PreInit_EventHandlers
{
    // The name "SLX_MyAddon_init" needs to be unique
    SLX_MyAddon_init="SLX_fInit=compile preprocessFile'\SLX_MyAddon\init.sqf'";
};
class Extended_Init_EventHandlers
{
    class Man
    {
        // Call the function we loaded in the PreInit class
        SLX_Man_init="_this call SLX_fInit";
    };
};

Warning: if you write your addon using this new "pre-init" system, keep in mind
that it won't work with XEH versions older than 1.9.


New in 1.91: PostInit and InitPost
==================================
Two new event handler types can be used to execute things at a later stage,
when all XEH init EH:s have run *and* all mission.sqm init lines have been
processed by ArmA. It happens just before the mission's "init.sqf" is executed.

The PostInit handler mirrors the pre-init event handler introduced in 1.9 and
will make a code snippet run *once* per mission. Example:

class Extended_PostInit_EventHandlers
{
    // Run "late_init.sqf" just before the mission's init.sqf and after
    // all other init EH:s and mission editor init lines have been processed
    SLX_MyAddon_postinit="[] execVM 'SLX_MyAddon\late_init.sqf";
};


The other event handler, InitPost type mimics the mission editor init lines in
that it will be run once on *every* unit and vehicle in the mission. You write
the InitPost EH just like you would the normal XEH init, fired etc handlers. 
That means you have to wrap the handler in the desired vehicle/unit class for
which you want the InitPost EH applied. As an example, you could use this to
set a per-unit variable that's needed for your addon. It needs to be done for
all units that are derived from the CAManBase class. Here's how it would look:

class Extended_InitPost_EventHandlers
{
    class CAManBase
    {
        // Make sure everyone is happy when the mission starts
        SLX_MyAddon_init="_this setVariable ['slx_myaddon_ishappy', true]";
    };
};


New in 2.00: Support for ArmA II
================================
XEH is now useable in ArmA II and adds support for a new ArmA II event -
the "firedNear" event.


XEH Change log
==============
2.00 (Jun 21, 2009)
New:   XEH ported to ArmA II with the help of Sickboy.
Added: support for the new "firedNear" event

1.93 (Feb 16, 2009)
Fixed: empty vehicles created after the mission started did not get their
       InitPost handlers called.

1.92 (Feb 09, 2009)
Changed: Some optimizations made (eg use pre-compiled XEH init functions).

1.91 (Dec 20, 2008) (Unofficial, for use with the ACE mod)
Added: New "post-init" feature that can be used to have a script run once
       at the end of mission initialisation, after all init EH:s and mission
       init lines have executed, but before the mission's init.{sqs,sqf}
       is processed.
Added: There's also a per-unit, "InitPost" XEH framework which lets you run
       scripts at the end of mission init. Unlike the PostInit event handlers
       described above, these snippets run once for every unit in the mission.
       (The name of this framework may change in the future to avoid confusion
       with "PostInit")

1.9  (Sep 21, 2008)
Fixed: before, vehicle crews would not have their XEH init EH:s run until just
       after the mission started. Now they are run before mission start.
Added: A stringtable with the version of XEH in STR_SLX_XEH_VERSION and
       STR_SLX_XEH2_VERSION for use with the "localize" command.
Added: a way to have run-once, "pre-init" code run using the new
       Extended_PreInit_EventHandlers class.

1.8  (Sep 7, 2008)
Fixed: game logics inside vehicles would cause a performance drop due to a
       infinite recursion in the code that handles initialisation of
       vehicle crews. Thanks to UNN for the bug report!
Added: you can make XEH init event handlers execute when players respawn by
       using an inner XEH class and the "onRespawn" boolean property.

1.7  (Mar 16, 2008)
Fixed: Removed XEH from class Static, which stops ArmA from crashing to desktop
       when resuming saved games.

1.6  (Mar 15, 2008)
Fixed: The "exclude" property will apply to the specified class(es) and all
       subclasses thereof.

1.5  (Mar 15, 2008)
Added: Composite ("inner") XEH classes can have an extra property, "exclude"
       which is either a string or an array of strings with the class name(s)
       of vehicles that should *not* get a particular XEH event handler.

1.4  (Mar 15, 2008)
Added: "Static" class vehicles can now have XEH event handlers.
Added: A respawn monitor that restores non-init XEH event handlers after
       the player respawns. Many thanks to Sickboy, LoyalGuard, ViperMaul for
       the initial research and suggestions!

1.3  (Feb 9, 2008)
Added: The ability to use "nested" XEH classes with a "scope" feature
       to limit certain event handlers to objects of specific classes.

1.2  (Jan 29, 2008)
Fixed: SightAdjustment_AutoInit.
Fixed: Extended Dammaged EventHandler.

1.1  (Jan 26, 2008)
Fixed: XEH can now handle extended event handlers that are missing a trailing
       semicolon.
Fixed: the example addons now require the Extended_Eventhandlers addon instead
       of the two older ones. Also, the debug sideChats are now guaranteed to
       be seen when previewing a mission with the example addons loaded.
Fixed: XEH init EH:s are now actually being called on units inside vehicles.

1.0 Initial Release (Dec 31, 2007)
Combined Extended Init, Fired, and Other event handlers. Thanks to Killswitch
for combining them and adding the other extended event handlers!
Added signature and bikey.


Init EH Change log:
===================
1.26
Fixed signature files, bikey, and .pbos.

1.25
Fixed signature files and added bikey.

1.2
Added signature file.
Fixed a bug that caused crashes on some missions. Thanks to LCD344!
Changed ExecVM to Call Compile. Thanks to UNN!

1.1
Fixed people in vehicles having no inits.
Included SightAdjustment example "bridge" addon that allows the GMJ_SightAdjustment
addon to be used with other extended init event handler addons.

1.0 Initial Release


Fired EH Change log
===================
1.0 @ 12-09-07 Initial release



References
==========
XEH for ArmA II is part of the Community Base Addons project:

    http://dev-heaven.net/projects/show/cca


The old XEH, for Armed Assault (ArmA) is hosted here:

    http://dev-heaven.net/projects/show/xeh


BI forums: http://forums.bistudio.com/

gmJamez Sight adjustment addon thread: http://www.flashpoint1985.com/cgi-bin/ikonboard311/ikonboard.cgi?s=60ba6482bbaa47a50e83f8ae5674bdd8;act=ST;f=70;t=65706
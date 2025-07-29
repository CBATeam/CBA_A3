class AnimationSources: AnimationSources
{
    /*
    class attach_invert
    {
        displayName = "Attach Invert";
        author = "Ampersand";
        source = "user";
        animPeriod = 0.000001;
        initPhase = 0;
        // if forceAnimatePhase is equal to the phase of this animation sources, every sources from forceAnimate will be changed with their given phase
        forceAnimatePhase = 1;
        // animationSource1, phase, animationSource2, phase... No probabilities here, only true or false
        forceAnimate[] = { "pylon_rotate_source", 3.141593, "attach_left", 0 , "attach_right", 0 };

        // The following code is called by BIS_fnc_initVehicle each time the phase is changed
        //onPhaseChanged = "if ((_this select 1) == 1) then { (_this select 0) animateSource ['pylon_rotate_source', pi] } else { (_this select 0) animateSource ['pylon_rotate_source', 0] };";
        onPhaseChanged = "";
    };
    class attach_left: attach_invert
    {
        displayName = "Attach Left";
        forceAnimate[] = { "pylon_rotate_source", -1.570796, "attach_invert", 0 , "attach_right", 0 };
    };
    class attach_right: attach_invert
    {
        displayName = "Attach Right";
        forceAnimate[] = { "pylon_rotate_source", 1.570796, "attach_invert", 0 , "attach_left", 0 };
    };
    */
    class pylon_rotate_source
    {
        source = "user";       // The controller is defined as a user animation.
        animPeriod = 0.000001; // The animation period used for this controller.
        initPhase = 0;         // Initial phase when object is created.
    };

    #ifdef HOLDINGWEAPON
        class fake_weapon_source: pylon_rotate_source {initPhase = 1;};
        class gunnerX_source: pylon_rotate_source {};
        class gunnerY_source: pylon_rotate_source {};
        class gunnerZ_source: pylon_rotate_source {};
        class mountY_source: pylon_rotate_source {};
        class muzzleEffects_hide_source: pylon_rotate_source {initPhase = 1;};
    /*
    class muzzleflashX_source: pylon_rotate_source {};
    class muzzleflashY_source: pylon_rotate_source {};
    class muzzleflashZ_source: pylon_rotate_source {};
    */
    #endif
};

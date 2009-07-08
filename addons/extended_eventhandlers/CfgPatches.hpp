class CfgPatches
{
    class Extended_EventHandlers
    {
        units[] = {};
        requiredVersion = 1.00;
        SLX_XEH2_Version = 2.01;
        requiredAddons[] = { "CAData", "CAAir", "CACharacters" };
    };
};

class CfgAddons
{
    class PreloadAddons
    {
        class Extended_EventHandlers
        {
            list[] = { "Extended_EventHandlers" };
        };
     };
};

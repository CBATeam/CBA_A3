
class CfgFunctions
{
    class CBA
    {
        class Modules
        {
            // CBA_fnc_spawnAttack
            class spawnAttack
            {
                description = "A function used to add a waypoint to a group. Parameters: - Group (Group or Object) - Position (XYZ, Object, Location or Group) Optional: - Radius (Scalar) - Waypoint Type (String) - Behaviour (String) - Combat Mode (String) - Speed Mode (String) - Formation (String) - Code To Execute at Each Waypoint (String) - TimeOut at each Waypoint (Array [Min, Med, Max]) - Waypoint Completion Radius (Scalar) Example: [this, this, 300, ""MOVE"", ""AWARE"", ""YELLOW"", ""FULL"", ""STAG COLUMN"", ""this spawn CBA_fnc_searchNearby"", [3,6,9]] Returns: Waypoint Author: Rommel";
                file = "\x\cba\addons\development\functions\fnc_spawnAttack.sqf";
            };
        };
    };
};

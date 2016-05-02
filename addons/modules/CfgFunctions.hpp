
class CfgFunctions
{
    class CBA
    {
        class Modules
        {
            // CBA_fnc_moduleAttack
            class moduleAttack
            {
                description = "A function used to spawn and/or make a group attack a specified location. Parameters: - Group (Group or Object) - Position (XYZ, Object, Location or Group) Optional: - Radius (Scalar) - Waypoint Type (String) - Behaviour (String) - Combat Mode (String) - Speed Mode (String) - Formation (String) - Code To Execute at Each Waypoint (String) - TimeOut at each Waypoint (Array [Min, Med, Max]) - Waypoint Completion Radius (Scalar) Example: [this, this, 300, ""MOVE"", ""AWARE"", ""YELLOW"", ""FULL"", ""STAG COLUMN"", ""this spawn CBA_fnc_searchNearby"", [3,6,9]] Returns: Nil Author: WiredTiger";
                file = "\x\cba\addons\modules\functions\fnc_moduleAttack.sqf";
            };
        };
    };
};

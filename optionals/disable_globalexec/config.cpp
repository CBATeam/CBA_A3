/*
    Disable network code execution
    
    This is an optional addon that can be used to disable the network
    execution function "CBA_fnc_globalExecute" from running code on
    other machines.
*/

class CfgPatches {
    class CBA_Disable_GlobalExec {
        units[] = {};
        weapons[] = {};
        requiredVersion = 0.1;
        requiredAddons[] = {"cba_network"};
    };
};

class CfgSettings {
    class CBA {
        class Network {
            disableGlobalExecute = 1;
        };
    };
};

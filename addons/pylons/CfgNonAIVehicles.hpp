class CfgNonAIVehicles {
    class ProxyWeapon;
    class Proxyshell: ProxyWeapon {
        model = "\A3\weapons_f\ammo\shell.p3d";
        simulation = "maverickweapon";
    };
    class Proxypya_pylonRack_82mm_Mortar_Shell: ProxyWeapon {
        model = QPATHTOF(data\pya_pylonRack_82mm_Mortar_Shell.p3d);
        simulation = "pylonpod";
    };
    class Proxypya_pylonRack_Cruise_01: ProxyWeapon {
        model = QPATHTOF(data\pya_pylonRack_Cruise_01.p3d);
        simulation = "pylonpod";
    };
}; // CfgNonAIVehicles

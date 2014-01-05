// Extended EH classes, where new events are defined.
class Extended_fired_Eventhandlers {
        class StaticCannon /* : StaticWeapon */ {
                SLX_BIS = "_this call (uinamespace getvariable 'BIS_fnc_effectFired');";
        };
        class Mortar_01_Base_F /* : StaticMortar */ {
                SLX_BIS = "_this call (uinamespace getvariable 'BIS_fnc_effectFired');";
        };
        class Helicopter /* : Air */ {
                SLX_BIS = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
        };
        class Helicopter_Base_F /* : Helicopter */ {
                SLX_BIS = "";
        };
        class Car_F /* : Car */ {
                SLX_BIS = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
        };
        class Ship_F /* : Ship */ {
                SLX_BIS = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
        };
};
class Extended_init_Eventhandlers {
        class Snake_random_F /* : Animal_Base_F */ {
                SLX_BIS = "(_this select 0) execVM ""\A3\animals_f\Snakes\scripts\randomize.sqf""";
        };
        class FlagChecked_F /* : FlagCarrierCore */ {
                SLX_BIS = "(_this select 0) setFlagTexture '\A3\signs_f\signspecial\data\checker_flag_co.paa';";
        };
        class test_EmptyObjectForBubbles /* : Thing */ {
                SLX_BIS = "(_this select 0) execVM ""\A3\weapons_f\data\scripts\bubbles.sqf"";";
        };
        class test_EmptyObjectForFireBig /* : test_EmptyObjectForBubbles */ {
                SLX_BIS = "(_this select 0) execVM ""\A3\weapons_f\data\scripts\fire.sqf"";";
        };
        class test_EmptyObjectForSmoke /* : test_EmptyObjectForBubbles */ {
                SLX_BIS = "(_this select 0) execVM ""\A3\weapons_f\data\scripts\smoke.sqf"";";
        };
        class B_AssaultPack_khk_holder /* : WeaponHolder */ {
                SLX_BIS = "(_this select 0) addBackpackCargo [""B_AssaultPack_khk"",1];";
        };
        class Underwear_F /* : B_Soldier_F */ {
                SLX_BIS = "(_this select 0) execVM ""\A3\Characters_F\Common\scripts\randomize.sqf""";
        };
        class c_offroad /* : Offroad_Base */ {
                SLX_BIS = "(_this select 0) execVM ""\A3\soft_F\Offroad\scripts\randomize.sqf""";
        };
        class Land_Wreck_Commanche_F /* : Wreck_base_F */ {
                SLX_BIS = "(_this select 0) execVM ""\A3\Structures_F\Wrecks\scripts\commanche.sqf""";
        };
        class FirePlace_burning_F /* : Land_FirePlace_F */ {
                SLX_BIS = "(_this select 0) inflame true";
        };
};
class Extended_killed_Eventhandlers {
         class Helicopter /* : Air */ {
                SLX_BIS = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
        };
        class Car_F /* : Car */ {
                SLX_BIS = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
        };
        class Ship_F /* : Ship */ {
                SLX_BIS = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
        };
        class Land_Communication_anchor_F /* : House_F */ {
                SLX_BIS = "[(_this select 0)] execVM ""\A3\Structures_F\Ind\Transmitter_Tower\Scripts\anchor_ruins.sqf""";
        };
        class Land_Communication_F /* : House_F */ {
                SLX_BIS = "[(_this select 0)] execVM ""\A3\Structures_F\Ind\Transmitter_Tower\Scripts\tower_ruins.sqf""";
        };
};

class DefaultEventHandlers;

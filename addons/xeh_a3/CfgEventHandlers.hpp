// Extended EH classes, where new events are defined.
class Extended_firedBIS_Eventhandlers {
        class StaticCannon /* : StaticWeapon */ {
                SLX_BIS = "_this call (uinamespace getvariable 'BIS_fnc_effectFired');";
        };
        class Mortar_01_Base_F /* : StaticMortar */ {
                SLX_BIS = "_this call (uinamespace getvariable 'BIS_fnc_effectFired');";
        };
        class Helicopter /* : Air */
        {
                SLX_BIS = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
        };
        class Heli_Attack_01_base_F /* : Helicopter_Base_F */ {
                SLX_BIS = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
        };
        class Plane /* : Air */ {
                SLX_BIS = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
        };
        class B_APC_Tracked_01_AA_F /*: B_APC_Tracked_01_base_F */ {
                SLX_BIS = "[_this select 0,_this select 6,'missile_move','MissileBase'] call BIS_fnc_missileLaunchPositionFix; _this call (uinamespace getvariable 'BIS_fnc_effectFired');";
        };
        class APC_Tracked_02_base_F /* : Tank_F */ {
                SLX_BIS = "[_this select 0,_this select 6,'missile_move','MissileBase'] call BIS_fnc_missileLaunchPositionFix; _this call (uinamespace getvariable 'BIS_fnc_effectFired');";
        };
        class Car_F /* : Car */ {
                SLX_BIS = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
        };
        class Ship_F /* : Ship */ {
                SLX_BIS = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
        };
        class Tank_F /* : Tank */ {
                SLX_BIS = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
        };
        class APC_Wheeled_03_base_F /* : Wheeled_APC_F */ {
                SLX_BIS = "[_this select 0,_this select 6,'missile_move','MissileBase'] call BIS_fnc_missileLaunchPositionFix; _this call (uinamespace getvariable 'BIS_fnc_effectFired');";
        };
};
class Extended_init_Eventhandlers {
        class Car_F /* : Car */ {
                SLX_BIS = "";
        };
        class C_man_1 /* : Civilian_F */ {
                SLX_BIS = "(_this select 0) execVM ""\A3\characters_f\civil\scripts\randomize_civ1.sqf""";
        };
        class C_man_hunter_1_F /* : C_man_1 */ {
                SLX_BIS = "";
        };
        class C_man_pilot_F /* : C_man_1 */ {
                SLX_BIS = "";
        };
        class C_man_journalist_F /* : C_man_1 */ {
                SLX_BIS = "";
        };
        class C_driver_1_F /* : C_man_1 */ {
                SLX_BIS = "";
        };
        class C_Soldier_VR_F /* : C_man_1 */ {
                SLX_BIS = "";
        };
        class B_Story_SF_Captain_F /* : B_Soldier_base_F */ {
                XEH_BIS = "(_this select 0) setIdentity ""EPA_B_Miller""";
        };
        class B_Story_Protagonist_F /* : B_Soldier_base_F */ {
                XEH_BIS = "(_this select 0) setIdentity ""EPA_B_Kerry""";
        };
        class B_Story_Engineer_F /* : B_Soldier_base_F */ {
                XEH_BIS = "(_this select 0) setIdentity ""EPA_B_Kerry""";
        };
        class B_Story_Pilot_F /* : B_Soldier_base_F */ {
                XEH_BIS = "(_this select 0) setIdentity ""EPA_B_Lacey""";
        };
        class B_CTRG_soldier_GL_LAT_F /* : B_Soldier_base_F */ {
                XEH_BIS = "(_this select 0) setIdentity ""EPA_B_Northgate""";
        };
        class B_CTRG_soldier_engineer_exp_F /* : B_Soldier_base_F */ {
                XEH_BIS = "(_this select 0) setIdentity ""EPA_B_Hardy""";
        };
        class B_CTRG_soldier_M_medic_F /* : B_Soldier_base_F */ {
                XEH_BIS = "(_this select 0) setIdentity ""EPA_B_James""";
        };
        class B_CTRG_soldier_AR_A_F /* : B_Soldier_base_F */ {
                XEH_BIS = "(_this select 0) setIdentity ""EPA_B_McKay""";
        };
        class C_Nikos /* : C_Orestes */ {
                XEH_BIS = "(_this select 0) setIdentity ""Nikos""";
        };
        class I_G_Soldier_base_F /* : SoldierGB */ {
                XEH_BIS = "(_this select 0) execVM ""\A3\Characters_F_Bootcamp\Data\Scripts\randomize_gue1.sqf""";
        };
        class I_G_Story_SF_Captain_F /* : B_G_Soldier_F */ {
                XEH_BIS = "";
        };
        class I_G_Story_Protagonist_F /* : B_G_Soldier_F */ {
                XEH_BIS = "";
        };
        class MBT_03_base_F /* : Tank_F */ {
                XEH_BIS = "if (local (_this select 0)) then {{(_this select 0) animate [_x,(random 1)]} forEach ['HideHull','HideTurret']}";
        };
        class Boat_Civil_01_base_F /* : Ship_F */ {
                SLX_BIS = "_this select 0 animate [""HidePoliceSigns"",1]; _this select 0 animate [""HideRescueSigns"",1]; _this select 0 animate [""HidePolice"",1];";
        };
        class C_Boat_Civil_01_rescue_F {
                SLX_BIS = "_this select 0 animate [""HidePoliceSigns"",1]; _this select 0 animate [""HideRescueSigns"",0]; _this select 0 animate [""HidePolice"",1];";
        };
        class C_Boat_Civil_01_police_F /* : Boat_Civil_01_base_F */ {
                SLX_BIS = "_this select 0 animate [""HidePoliceSigns"",0]; _this select 0 animate [""HideRescueSigns"",1]; _this select 0 animate [""HidePolice"",0];";
        };
        class C_Offroad_01_F /* : Offroad_01_base_F */ {
                SLX_BIS = "if (local (_this select 0)) then {[(_this select 0), """", [], false] call bis_fnc_initVehicle;};";
        };
        class Offroad_01_repair_base_F /* : Offroad_01_base_F */ {
                SLX_BIS = "if (local (_this select 0)) then {[(_this select 0), """", [], false] call bis_fnc_initVehicle;};";
        };
        class B_G_Offroad_01_repair_F /* : Offroad_01_repair_base_F */ {
                SLX_BIS = "if (local (_this select 0)) then {[(_this select 0), """", [], false] call bis_fnc_initVehicle;};";
        };
        class I_G_Offroad_01_F /* : Offroad_01_base_F */ {
                SLX_BIS = "if (local (_this select 0)) then {[(_this select 0), """", [], false] call bis_fnc_initVehicle;};";
        };
        class I_G_Offroad_01_armed_F /* : Offroad_01_armed_base_F */ {
                SLX_BIS = "if (local (_this select 0)) then {[(_this select 0), """", [], false] call bis_fnc_initVehicle;};";
        };
        class C_Quadbike_01_F /* : Quadbike_01_base_F */ {
                SLX_BIS = "if (local (_this select 0)) then {[(_this select 0), """", [], false] call bis_fnc_initVehicle;};";
        };
        class I_G_Quadbike_01_F /* : Quadbike_01_base_F */ {
                SLX_BIS = "if (local (_this select 0)) then {[(_this select 0), """", [], false] call bis_fnc_initVehicle;};";
        };
        class C_Hatchback_01_F /* : Hatchback_01_base_F */ {
                SLX_BIS = "if (local (_this select 0)) then {[(_this select 0), """", [], false] call bis_fnc_initVehicle;};";
        };
        class C_Hatchback_01_sport_F /* : Hatchback_01_base_F */ {
                SLX_BIS = "if (local (_this select 0)) then {[(_this select 0), """", [], false] call bis_fnc_initVehicle;};";
        };
        class C_SUV_01_F /* : SUV_01_base_F */ {
                SLX_BIS = "if (local (_this select 0)) then {[(_this select 0), """", [], false] call bis_fnc_initVehicle;};(_this select 0) execVM ""\A3\soft_f_gamma\SUV_01\scripts\clock.sqf"";";
        };
        class Van_01_base_F /* : Truck_F */ {
                SLX_BIS = "(_this select 0) execVM ""\A3\soft_f_gamma\van_01\scripts\clock.sqf"";if (local (_this select 0)) then {[(_this select 0), """", [], false] call bis_fnc_initVehicle;};";
        };
        class I_G_Van_01_transport_F /* : Van_01_base_F */ {
                SLX_BIS = "(_this select 0) execVM ""\A3\soft_f_gamma\van_01\scripts\clock.sqf"";if (local (_this select 0)) then {[(_this select 0), """", [], false] call bis_fnc_initVehicle;};";
        };
        class C_Van_01_fuel_F /* : Van_01_base_F */ {
                SLX_BIS = "(_this select 0) execVM ""\A3\soft_f_gamma\van_01\scripts\clock.sqf"";if (local (_this select 0)) then {[(_this select 0), """", [], false] call bis_fnc_initVehicle;};";
        };
        class I_G_Van_01_fuel_F /* : Van_01_base_F */ {
                SLX_BIS = "(_this select 0) execVM ""\A3\soft_f_gamma\van_01\scripts\clock.sqf"";if (local (_this select 0)) then {[(_this select 0), """", [], false] call bis_fnc_initVehicle;};";
        };
        class C_Kart_01_F /* : C_Kart_01_F_Base  */{
                SLX_BIS = "if (local (_this select 0)) then {[(_this select 0), """", nil, nil] call bis_fnc_initVehicle; [(_this select 0)] call bis_fnc_initVehicleKart;};";
        };
        class Fin_random_F /* : Fin_Base_F */ {
                SLX_BIS = "_FRnd = compile loadFile ""\A3\animals_f_beta\dog\scripts\randomize.sqf"";(_this select 0) call _FRnd;";	
        };
        class Alsatian_Random_F /* : Alsatian_Base_F */ {
                SLX_BIS = "_FRnd = compile loadFile ""\A3\animals_f_beta\dog\scripts\randomize_als.sqf"";(_this select 0) call _FRnd;";
        };
        class Goat_random_F /* : Goat_Base_F */ {
                SLX_BIS = "_FRnd = compile loadFile ""\A3\animals_f_beta\goat\scripts\randomize.sqf"";(_this select 0) call _FRnd;";
        };
        class Sheep_random_F /* : Animal_Base_F */ {
                SLX_BIS = "_FRnd = compile loadFile ""\A3\animals_f_beta\Sheep\scripts\randomize.sqf"";(_this select 0) call _FRnd;";
        };
        class Snake_random_F /* : Animal_Base_F */ {
                SLX_BIS = "_FRnd = compile loadFile ""\A3\animals_f\Snakes\scripts\randomize.sqf"";(_this select 0) call _FRnd;";
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
        class FirePlace_burning_F /* : Land_FirePlace_F */ {
                SLX_BIS = "(_this select 0) inflame true";
        };
        class Heli_Light_01_civil_base_F /* : Heli_Light_01_base_F */ {
        		SLX_BIS = "if (local (_this select 0)) then {[(_this select 0), """", [], false] call bis_fnc_initVehicle;};";
        };
};
class Extended_killed_Eventhandlers {
        class Helicopter /* : Air */ {
                SLX_BIS = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
        };
        class Plane /* : Air */ {
                SLX_BIS = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
        };
        class Car_F /* : Car */ {
                SLX_BIS = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
        };
        class Ship_F /* : Ship */ {
                SLX_BIS = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
        };
        class Boat_Civil_01_base_F {
                SLX_BIS = "_this select 0 animate [""HidePoliceSigns"",1]; _this select 0 animate [""HideRescueSigns"",1]; _this select 0 animate [""HidePolice"",1];";
        };
        class Tank_F /* : Tank */ {
                SLX_BIS = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
        };
        class I_G_Offroad_01_F /* : Offroad_01_base_F */ {
                SLX_BIS = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled'); _this select 0 animate [""DamageUnHideConstruction"",0];";
        };
        class I_G_Offroad_01_armed_F /* : Offroad_01_armed_base_F */ {
                SLX_BIS = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled'); _this select 0 animate [""DamageUnHideConstruction"",0];";
        };
        class Land_Communication_anchor_F /* : House_F */ {
                SLX_BIS = "[(_this select 0)] execVM ""\A3\Structures_F\Ind\Transmitter_Tower\Scripts\anchor_ruins.sqf""";
        };
        class Land_Communication_F /* : House_F */ {
                SLX_BIS = "[(_this select 0)] execVM ""\A3\Structures_F\Ind\Transmitter_Tower\Scripts\tower_ruins.sqf""";
        };
};

class Default_Extended_Eventhandlers;
class DefaultEventhandlers;
class Eventhandlers;

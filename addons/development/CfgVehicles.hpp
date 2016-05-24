class CfgVehicles{
	class Logic;
	class Module_F: Logic{
		class ArgumentsBaseUnits{
			class Units;
		};
		class ModuleDescription;
	};
	class CBA_moduleAttack: Module_F{
		scope = 2;
		displayName = "Attack";
		vehicleClass = "Modules";
		category = "CBA_Modules";
		function = "CBA_fnc_spawnAttack";
		functionPriority = 1;
		isGlobal = 2;
		isTriggerActivated = 1;
		isDisposable = 1;
		is3DEN = 0;
		curatorInfoType = "RscDisplayAttributeAttack";

		class Arguments: ArgumentsBaseUnits{
			class headlessClient{
				displayName = "Headless Client?";
				description = "Enter if a headless client is present"
				typeName = "BOOL";
				class values{
					class No	{name = "$STR_lib_info_no"; value = 0; default = 0;};
					class Yes   {name = "$STR_lib_info_yes"; value = 1;};
				};
			};
			
			class unitType{
				displayName = "Unit Type";
				description = "Is the units synced or entered manually";
				typeName = "NUMBER";
				class values{
					class syncedUnit {name = "Synced"; value = 10; default = 10;};
					class arrayUnit {name = "Array"; value = 11;};
					class configUnit {name = "Config"; value = 12;};
				};
			};
			
			class scriptedUnit{
				displayName = "Units";
				description = "Enter an array of classnames or config";
				typeName = "STRING";
			};
			
			class unitSide{
				displayName = "Side";
				description = "";
				typeName = "NUMBER";
				class values{
					class sideWest{name = "Blufor"; value = 10; default = 0;};
					class sideOpfor{name = "OpFor"; value = 11;};
					class sideInd{name = "Independent"; value = 12;};
					class sideCiv{name = "Civilian"; value = 13;};
				};
			};
			
			class spawnPosition{
				displayName = "Spawn Point";
				typeName = "STRING";
			};
			
			class spawnRadius{
				displayName = "Spawn Radius";
				typeName = "NUMBER";
				defaultVaule = 0;
			};
			
			class attackPosition{
				displayName = "Attack Position";
				typeName = "STRING";
			};
			
			class attackRadius{
				displayName = "Attack Radius";
				typeName = "NUMBER";
				defaultValue = 0;
			};
		};

		class ModuleDescription: ModuleDescription{
			description = "Spawns a group to attack a parsed location";
			sync[] = {"LocationArea_F"};
			
			class LocationArea_F{
				description[] = {
					"Module can be synced to triggers",
					"as well as units/groups"
				};
				optional = 1;
				duplicate = 1;
				synced[] = {"AnyAI","EmptyDetector"};
			};
		};
	};
};
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
			class scriptedUnit{
				displayName = "Units";
				description = "Enter a config or an array of classnames";
				typeName = "STRING";
			};
			
			class headlessClient{
				displayName = "Headless Client?";
				typeName = "BOOL";
				class values{
					class No	{name = "$STR_lib_info_no"; value = 0; default = 1;};
					class Yes   {name = "$STR_lib_info_yes"; value = 1; default = 0;};
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
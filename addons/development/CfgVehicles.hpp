class CfgVehicles{
	class Logic;
	class Module_F: Logic{
		class ArgumentsBaseUnits{
			class Units;
		};
		class ModuleDescription{
			class AnyBrain;
		};
	};
	class CBA_ModuleAttack: Module_F{
		scope = 2;
		displayName = "Attack";
		category = "CBA";
		function = QUOTE(DFUNC(moduleAttack));
		functionPriority = 1;
		isGlobal = 2;
		isTriggerActivated = 0;
		isDisposable = 1;
		is3DEN = 0;
		curatorInfoType = "RscDisplayAttributeAttack";

		class Arguments: ArgumentsBaseUnits{
			class Units: Units {};
			class scriptedUnit{
				displayName = "Units";
				description = "Enter a config or an array of classnames";
				typeName = "STRING";
			};
			class headlessClient{
				displayName = "Headless Client?";
				typeName = "BOOL";
				class headlessValues
				{
					class noHead	{name = "$STR_lib_info_no"; value = false; default = false;};
					class yesHead	{name = "$STR_lib_info_yes"; value = true;};
				};
			};
			class spawnPosition{
				displayName = "Spawn Point";
				typeName = "STRING";
			};
			class attackPosition{
				displayName = "Attack Position";
				typeName = "STRING";
			};
		};

		class ModuleDescription: ModuleDescription{
			description = "Core module sets definitions for mission";
			sync[] = {};
			};
		};
	};
};
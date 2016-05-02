class CBA_Extended_EventHandlers;

class CfgVehicles{
	class Logic;
	class Module_F: Logic{
		class ArgumentsBaseUnits{
		};
	};
	
	class CBA_MODULE;
	class CBA_ModuleAttack: CBA_MODULE{
		scope = 2;
		displayName = "CBA Attack"; //CSTRING(Attack_Module_DisplayName);
		//icon = QUOTE(PATHTOF(UI\Icon_Module_Medical_ca.paa)); //Needs edited
		category = "CBA";
		function = "CBA_fnc_moduleAttack";
		functionPriority = 1;
		isGlobal = 2;
		isTriggerActivated = 0;
		isDisposable = 0;
		author = "CBA Team";

		class Arguments{
			class units{
				displayName = "Units";
				description = "It is what will be defined";
				typeName = "STRING";
			};
			class headlessClient{
				displayName = "Headless Client";
				description = "Is there a headless client present?";
				typeName = "BOOL";
				class values{
					class noHeadless {name = "$STR_lib_info_no"; value = 0; default = 0;};
					class yesHeadless {name = "$STR_lib_info_yes"; value = 1;};
				};
			};
			class attackPosition{
				displayName = "Attack Position";
				description = "Enter the position to be attacked when activated";
				typeName = "STRING";
			};
			class searchRadius{
				displayName = "Search Radius";
				description = "Enter radius size for area that will be attacked";
				typeName = "NUMBER";
			};
		};

		class ModuleDescription: ModuleDescription{
			description = CSTRING(AttackModuleSettings_Module_Description);
			sync[] = {};
		};
	};
	
	class CBA_ModuleDefend: CBA_MODULE{
		scope = 2;
		displayName = CSTRING(Attack_Module_DisplayName);
		icon = QUOTE(PATHTOF(UI\Icon_Module_Medical_ca.paa)); //Needs edited
		category = "CBA";
		function = "CBA_fnc_taskDefend"; //QUOTE(DFUNC(moduleMedicalSettings));
		functionPriority = 1;
		isGlobal = 2;
		isTriggerActivated = 0;
		isDisposable = 0;
		author = ECSTRING(common,CBATeam);
	};
};

class CfgFunctions {
    #include "CfgFunctions.cpp"
};

class Extended_PreStart_EventHandlers {
	class cba_modFunctions {
		init = "call compile preProcessFileLineNumbers '\x\cba\addons\modFunctions\XEH_preStart.sqf'";
	};
};

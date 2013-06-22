if (isNil "SLX_XEH_BWC_INIT_COMPILE") then {
	SLX_XEH_BWC_INIT_COMPILE = compile preProcessFileLineNumbers "\x\cba\addons\xeh\init_compile.sqf";
};
if (isNil "_this") then { call SLX_XEH_BWC_INIT_COMPILE } else { _this call SLX_XEH_BWC_INIT_COMPILE };

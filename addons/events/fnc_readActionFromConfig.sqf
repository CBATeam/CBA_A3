/* ----------------------------------------------------------------------------
Function: CBA_fnc_readActionFromConfig

Description:
	Reads action setting from config
	
Parameters:
	_component - Classname under "CfgSettings" >> "CBA" >> "events" [String].
	_action - Action classname [String].

Returns:

Examples:
	(begin example)
		_actionConfig = ["cba_sys_nvg", "nvgon", { _this call myAction }] call CBA_fnc_readActionFromConfig;
	(end)

Author:
	Sickboy
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(readActionFromConfig);

private ["_component", "_action", "_i"];
PARAMS_2(_component,_action);
if (isText(CFGSETTINGS >> _component >> _action)) exitWith
{
	#ifdef DEBUG_MODE_FULL
		[format["readActionFromConfig: %1, Found: %2", _this, getText(CFGSETTINGS >> _component >> _action)], QUOTE(ADDON)] call CBA_fnc_debug;
	#endif
	[getText(CFGSETTINGS >> _component >> _action)]
};

if (isClass(CFGSETTINGS >> _component >> _action)) exitWith
{
	#ifdef DEBUG_MODE_FULL
		[format["readActionFromConfig: %1, Found: %2", _this, getText(CFGSETTINGS >> _component >> _action >> "action")], QUOTE(ADDON)] call CBA_fnc_debug;
	#endif
	[getText(CFGSETTINGS >> _component >> _action >> "action")]
};

[""]

#include "script_component.hpp"
disableSerialization;

if (_this) then 
{
	if (isNil {uiNamespace getVariable QGVAR(reloadblock)}) then 
	{
		_blockReload = ([] call BIS_fnc_displayMission) displayAddEventHandler
		[
			"KeyDown",
			{
				_reloadKeys = actionKeys "ReloadMagazine";
				
				if ((_this select 1) in _reloadKeys) then {true};
			}
		];

		uiNamespace setVariable [QGVAR(reloadblock), _blockReload];
	};
}
else
{
	if !(isNil {uiNamespace getVariable QGVAR(reloadblock)}) then 
	{
		([] call BIS_fnc_displayMission) displayRemoveEventHandler ['KeyDown', (uiNamespace getVariable QGVAR(reloadblock))];
		uiNamespace setVariable [QGVAR(reloadblock), nil];
		GVAR(reloadblock) = nil;
	};
};
#include "script_component.hpp"
waitUntil { format["%1", findDisplay 46] != "No display" };
(findDisplay 46) displayAddEventHandler ["KeyDown", QUOTE(_this call FUNC(keyHandler))];
// Todo: Evaluate combination
(findDisplay 46) displayAddEventHandler ["KeyDown", QUOTE(_this call FUNC(actionHandler))];

["CBA_loadGame",
{
	[] spawn
	{
		waitUntil { format["%1", findDisplay 46] != "No display" };
		(findDisplay 46) displayAddEventHandler ["KeyDown", QUOTE(_this call FUNC(keyHandler))];
		// Todo: Evaluate combination
		(findDisplay 46) displayAddEventHandler ["KeyDown", QUOTE(_this call FUNC(actionHandler))];
	};
}] call CBA_fnc_addEventHandler;

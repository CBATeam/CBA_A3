#include "script_component.hpp"
waitUntil { format["%1", findDisplay 46] != "No display" };
(findDisplay 46) displayAddEventHandler ["KeyDown", STR(_this call GVAR(fHandler))];

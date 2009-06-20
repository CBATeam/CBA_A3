#include "script_component.hpp"

waitUntil { format["%1", findDisplay 46] != "No display" };
(findDisplay 46) displayAddEventHandler ["KeyDown", "_this call " + QUOTE(GVAR(fHandler))];
#include "..\script_component.hpp"
SCRIPT(onComboChanged)

disableSerialization;

with uiNamespace do {
	// Update the main dialog.
	[] call FUNC(guiUpdate);
};




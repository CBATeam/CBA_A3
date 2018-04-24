#include "script_component.hpp"

LOG(MSG_INIT);

call COMPILE_FILE(flexiMenu\init);

private _display = uiNamespace getVariable ["RscDisplayMission", displayNull];
private _control = _display getVariable [QGVAR(ProgressBar), controlNull];
_control ctrlShow false;

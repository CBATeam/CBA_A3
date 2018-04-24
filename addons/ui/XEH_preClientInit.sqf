#include "script_component.hpp"

LOG(MSG_INIT);

call COMPILE_FILE(flexiMenu\init);

private _control = uiNamespace getVariable [QGVAR(ProgressBar), controlNull];
_control ctrlShow false;

#include "script_component.hpp"
_id = call GVAR(fId);
GVAR(cmd) = [_id, _this];
publicVariable QUOTE(GVAR(cmd));
[_id, _this] SPAWN(fExec);
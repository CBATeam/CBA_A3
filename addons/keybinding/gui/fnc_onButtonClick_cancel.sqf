#include "\x\cba\addons\keybinding\script_component.hpp"

disableSerialization;

GVAR(waitingForInput) = false;
GVAR(input) = [1, [false, false, false]];
GVAR(frameNoKeyPress) = diag_frameNo;

nil

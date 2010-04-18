/* ace_sys_help | (c) 2010 by alef */

#include "script_component.hpp"

if (isNil QUOTE(GVAR(added))) then { GVAR(added) = false };
if (GVAR(added)) exitWith {}; // already done
GVAR(added) = true;

// Call documentation
call FUNC(doc);

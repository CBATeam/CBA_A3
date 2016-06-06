#include "script_component.hpp"

PREP(keyHandler);
#ifndef LINUX_BUILD
    PREP(keyHandlerDown);
#else
    PREP(keyHandlerDown_Linux);
    FUNC(keyHandlerDown) = FUNC(keyHandlerDown_Linux);
#endif
PREP(keyHandlerUp);

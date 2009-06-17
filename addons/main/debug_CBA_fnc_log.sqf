/* ----------------------------------------------------------------------------
@description Logs a message to the RPT log.
-----------------------------------------------------------------------------*/

#include "script_component.hpp"

SCRIPT(log);

// ----------------------------------------------------------------------------

// TODO: Add log message to trace log
diag_log text format (["%1 %2:%3: %4", time] + _this);
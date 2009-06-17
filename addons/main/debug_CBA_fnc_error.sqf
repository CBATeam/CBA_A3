/* ----------------------------------------------------------------------------
@description Logs an error message to the RPT log.
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(error);

// -----------------------------------------------------------------------------

// TODO: popup window with error message in it.
diag_log text format (["%1:%2: [ERROR] %3 %4"] + _this);

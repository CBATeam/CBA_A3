/* ----------------------------------------------------------------------------

@description Tests CBA main functions.

Parameters:
  None.

Returns:
  nil

---------------------------------------------------------------------------- */

#include "script_component.hpp"

// ----------------------------------------------------------------------------

LOG('----- STARTING PREFIX\COMPONENT TESTS -----');

ERROR("Just testing ERROR()\nBleh!","Test");

CALLFS(PREFIX,COMPONENT,test_equals);
CALLFS(PREFIX,COMPONENT,test_hash);
CALLFS(PREFIX,COMPONENT,test_strings);

LOG('----- COMPLETED PREFIX\COMPONENT TESTS -----');

nil;
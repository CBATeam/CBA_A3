/*
    Header: script_xeh.hpp

    Description:
        Used internally.
*/
/////////////////////////////////////////////////////////////////////////////////
// MACRO: EXTENDED_EVENTHANDLERS
// Add all XEH event handlers
/////////////////////////////////////////////////////////////////////////////////
#define EXTENDED_EVENTHANDLERS init = "_this call CBA_fnc_initObject"; \


/* 
   MACRO: DELETE_EVENTHANDLERS

    Removes all event handlers.
*/

#define DELETE_EVENTHANDLERS delete init; \
delete fired; \
delete animChanged; \
delete animDone; \
delete animStateChanged; \
delete containerClosed; \
delete containerOpened; \
delete controlsShifted; \
delete dammaged; \
delete engine; \
delete epeContact; \
delete epeContactEnd; \
delete epeContactStart; \
delete explosion; \
delete firedNear; \
delete fuel; \
delete gear; \
delete getIn; \
delete getOut; \
delete handleHeal; \
delete hit; \
delete hitPart; \
delete incomingMissile; \
delete inventoryClosed; \
delete inventoryOpened; \
delete killed; \
delete landedTouchDown; \
delete landedStopped; \
delete local;  \
delete respawn;  \
delete put;  \
delete take; \
delete seatSwitched; \
delete soundPlayed; \
delete weaponAssembled; \
delete weaponDisAssembled;

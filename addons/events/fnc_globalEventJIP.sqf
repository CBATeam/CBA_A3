#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_globalEventJIP

Description:
    Raises a CBA event on all machines.

    Event is put on a stack that is executed on every future JIP machine.
    Stack can be overwritten by using the same JIP-Stack-ID.
    When object provided as jipID, the jip will get removed when object gets deleted.

Parameters:
    _eventName - Type of event to publish. <STRING>
    _params    - Parameters to pass to the event handlers. <ANY>
    _jipID     - Unique event ID or object. (optional) (default: create unique id) <STRING, OBJECT>
                 STRING:
                    Unique, custom ID - can be used to remove or overwrite the event later.
                 OBJECT:
                    Will remove JIP EH when object is deleted.
        

Returns:
    _jipID <STRING>

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(globalEventJIP);

params [["_eventName", "", [""]], ["_params", []], ["_jipOrObj", "", ["", objNull]]];

(if (_jipOrObj isEqualType "") then {
    [_jipOrObj, nil]
} else {
    ["", _jipOrObj]
}) params ["_jipID", "_obj"];


// generate string
if (_jipID isEqualTo "") then {
    if (isNil QGVAR(lastJIPID)) then {
        GVAR(lastJIPID) = -1;
    };

    GVAR(lastJIPID) = GVAR(lastJIPID) + 1;

    _jipID = ["CBA", clientOwner, GVAR(lastJIPID)] joinString ":";
};

// put on JIP stack
GVAR(eventNamespaceJIP) setVariable [_jipID, [EVENT_PVAR_STR, [_eventName, _params]], true];

// execute on every machine
[QGVAR(eventJIP), [_eventName, _params]] call CBA_fnc_globalEvent;

// Remove JIP once obj is deleted
if (!isNil "_obj") then { [_jipID, _obj] call CBA_fnc_removeGlobalEventJIP; };

_jipID

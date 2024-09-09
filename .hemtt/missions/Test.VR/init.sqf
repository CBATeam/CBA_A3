[ {
    private _delay = 1;
    private _codeToRun = {  diag_log format ["Loop: %1", diag_tickTime]  };

    diag_log format ['[CVO](debug)(TEST Start) _delay %2 - diag_tickTime: %1', diag_tickTime, _delay];

    private _handle = [_codeToRun, _delay, []] call CBA_fnc_addPerFrameHandler;

    [ {
        [_this#0, 10, true] call CBA_fnc_updatePerFrameHandlerDelay;
    } , [_handle], 7] call CBA_fnc_waitAndExecute;


    [ {
        [_this#0, 2, true] call CBA_fnc_updatePerFrameHandlerDelay;
    } , [_handle], 30] call CBA_fnc_waitAndExecute;

    [ {
        [_this#0] call CBA_fnc_removePerFrameHandler;
        diag_log format ['[CVO](debug)(Test Stopped)diag_tickTime: %1', diag_tickTime];
    } , [_handle], 45] call CBA_fnc_waitAndExecute;

} , [], 5] call CBA_fnc_waitAndExecute;
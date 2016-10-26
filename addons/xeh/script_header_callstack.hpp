private _CBA_lastHandle = _CBA_functionHandle;
private _CBA_functionHandle = CBA_functionHandles pushBack _fnc_scriptName;

if (isNil "_CBA_lastHandle") then {
    [] call CBA_fnc_dumpCallstack;

    CBA_functionHandles = [_fnc_scriptName];
    _CBA_functionHandle = 0;
    CBA_callstack = [[_CBA_functionHandle, _fnc_scriptNameParent, -1]];
} else {
    CBA_callstack pushBack [_CBA_functionHandle, _fnc_scriptNameParent, _CBA_lastHandle];
};

if (canSuspend) then {
    diag_log formatText ["Warning: %1 was called in scheduled environment which is not supported by the CBA callstack.", _fnc_scriptName];
};

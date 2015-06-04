// #define DEBUG_MODE_FULL
#include "script_component.hpp"

FUNC(doCheck) = {
    private "_moo";
    _moo = _this getVariable SLX_XEH_STR_PROCESSED;
    if (isNil "_moo" || {!_moo}) then {
        _this setVariable SLX_XEH_AR_TRUE;
        _this call FUNC(support_monitor);
    };
};


_fnc = {
    private ["_params", "_vicCount", "_unitCount", "_currentUnitCount", "_currentVicCount"];
    _params = _this select 0;
    _vicCount = _params select 0;
    _unitCount = _params select 1;
    _currentVicCount = (count vehicles);
    _currentUnitCount = (count allUnits);

    if(_currentVicCount != _vicCount) then {
        if(_currentVicCount > _vicCount) then {
            _newVics = vehicles - (_params select 2); // old vics
            {
                _x call FUNC(doCheck);
            } forEach _newVics;
            _params set[2, vehicles];
        };
        _params set[0, _currentVicCount];
    };

    if(_currentUnitCount != _unitCount) then {
        if(_currentUnitCount > _unitCount) then {
            _newVics = allUnits - (_params select 3); // old units
            {
                _x call FUNC(doCheck);
            } forEach _newVics;
            _params set[3, allUnits];
        };
        _params set[1, _currentUnitCount];
    };
};

[_fnc, 3, [0, 0, [], []]] call CBA_fnc_addPerFrameHandler;

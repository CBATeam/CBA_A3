#include "script_component.hpp"

if (hasInterface) then {
    [QGVAR(say3D), {
        params ["_object", "_params", "_attach"];

        // Attaching is mainly meant for vehicles in motion
        private _source = _object say3D _params;
        if (_attach) then {
            _source attachTo [_object];
        };
    }] call CBA_fnc_addEventHandler;

    [QGVAR(say), {
        params ["_object", "_params"];
        _object say _params;
    }] call CBA_fnc_addEventHandler;
};

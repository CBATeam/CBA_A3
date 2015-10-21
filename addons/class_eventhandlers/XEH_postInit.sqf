#include "script_component.hpp"
SCRIPT(XEH_postInit);

// main loop.

GVAR(entities) = [];

[{
    if !(entities "" isEqualTo GVAR(entities)) then {
        private _entities = entities "";

        GVAR(entities) = _entities;

        // iterate through all objects and add eventhandlers to all new ones
        {
            if !(_x getVariable [QGVAR(isInit), false]) then {
                _x setVariable [QGVAR(isInit), true];

                private _unit = _x;
                private _type = typeOf _unit;
                private _class = configFile >> "CfgVehicles" >> _type;

                while {isClass _class} do {
                    _type = configName _class;

                    // call init eventhandlers
                    {
                        [_unit] call _x;
                        false
                    } count EVENTHANDLERS("init",_type);

                    // add other eventhandlers
                    {
                        private _event = _x;

                        {
                            _unit addEventHandler [_event, _x];
                            false
                        } count EVENTHANDLERS(_event,_type);
                        false
                    } count (missionNamespace getVariable [format [QGVAR(::%1), _type], []]);

                    _class = inheritsFrom _class;
                };

                //systemChat str _unit;
            };
            false
        } count _entities;
    };
}, 0, []] call CBA_fnc_addPerFrameHandler;

/*
 * Author: commy2
 * Check all units or vehicles and init those who aren't inited yet.
 *
 * Arguments:
 * Objects to check <Array>
 *
 * Return Value:
 * None
 *
 * Public: No
 */
#include "script_component.hpp"

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
            } count SUPPORTED_EH;

            _class = inheritsFrom _class;
        };

        //systemChat str _unit;
    };
    false
} count _this;

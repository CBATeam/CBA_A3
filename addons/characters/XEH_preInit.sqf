#include "script_component.hpp"

ADDON = false;

{
    [_x, "InitPost", {
        params ["_unit"];

        if (isServer) then {
            _unit setDamage 0.46;
        };
    }, nil, nil, true] call CBA_fnc_addClassEventHandler;
} forEach [
    "C_Man_casual_1_F_afro_sick",
    "C_Man_casual_3_F_afro_sick",
    "C_Man_casual_4_F_afro_sick",
    "C_Man_casual_5_F_afro_sick",
    "C_Man_casual_6_F_afro_sick",
    "C_man_polo_1_F_afro_sick",
    "C_man_polo_2_F_afro_sick",
    "C_man_polo_3_F_afro_sick",
    "C_man_polo_6_F_afro_sick",
    "C_man_sport_2_F_afro_sick"
];

ADDON = true;

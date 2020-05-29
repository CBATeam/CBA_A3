#include "script_component.hpp"

ADDON = false;

[QGVAR(setIdentity), {
    params ["_unit", "_identity"];

    _unit setIdentity _identity;
}] call CBA_fnc_addEventHandler;

{
    [_x, "InitPost", {
        params ["_unit"];

        if (isServer) then {
            _unit setDamage 0.475;

            private _identity = selectRandom [
                "BIS_Ambient01_sick",
                "BIS_Ambient02_sick",
                "BIS_Ambient03_sick",
                "BIS_Arthur_sick",
                "BIS_Howard_sick",
                "BIS_John_sick",
                "BIS_Lucas_sick",
                "BIS_Renly_sick"
            ];

            [QGVAR(setIdentity), [_unit, _identity]] call CBA_fnc_globalEventJIP;
        };
    }, nil, nil, true] call CBA_fnc_addClassEventHandler;
} forEach [
    "C_man_p_beggar_F_afro_sick",
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

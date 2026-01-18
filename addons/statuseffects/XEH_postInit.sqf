#include "script_component.hpp"

[QGVAR(setStatusEffect), CBA_fnc_setStatusEffect] call CBA_fnc_addEventHandler;
["forceWalk", false, ["ace_advanced_fatigue", "ace_attach", "ace_dragging", "ace_explosives", "ace_medical_fracture", "ace_rearm", "ace_refuel", "ace_sandbag", "ace_switchunits", "ace_tacticalladder", "ace_trenches"]] call CBA_fnc_addStatusEffectType;
["blockSprint", false, ["ace_advanced_fatigue", "ace_dragging", "ace_medical_fracture"]] call CBA_fnc_addStatusEffectType;
["setCaptive", true, ["ace_captives_handcuffed", "ace_captives_surrendered"]] call CBA_fnc_addStatusEffectType;
["blockDamage", false, ["fixCollision", "ace_cargo"]] call CBA_fnc_addStatusEffectType;
["blockEngine", false, ["ace_refuel"]] call CBA_fnc_addStatusEffectType;
["blockThrow", false, ["ace_attach", "ace_concertina_wire", "ace_dragging", "ace_explosives", "ace_rearm", "ace_refuel", "ace_sandbag", "ace_tacticalladder", "ace_trenches", "ace_tripod"]] call CBA_fnc_addStatusEffectType;
["setHidden", true, ["ace_unconscious"]] call CBA_fnc_addStatusEffectType;
["blockRadio", false, ["ace_captives_handcuffed", "ace_captives_surrendered", "ace_unconscious"]] call CBA_fnc_addStatusEffectType;
["blockSpeaking", false, ["ace_unconscious"]] call CBA_fnc_addStatusEffectType;
["disableWeaponAssembly", false, ["ace_common", "ace_common_lockVehicle", "ace_csw"]] call CBA_fnc_addStatusEffectType;
["lockInventory", true, [], true] call CBA_fnc_addStatusEffectType;
["disableCollision", true, [], true] call CBA_fnc_addStatusEffectType;

[QGVAR(forceWalk), {
    params ["_object", "_set"];
    TRACE_2("forceWalk EH",_object,_set);
    _object forceWalk (_set > 0);
}] call CBA_fnc_addEventHandler;

[QGVAR(blockSprint), { // Name reversed from `allowSprint` because we want NOR logic
    params ["_object", "_set"];
    TRACE_2("blockSprint EH",_object,_set);
    _object allowSprint (_set == 0);
}] call CBA_fnc_addEventHandler;

[QGVAR(setAnimSpeedCoef), {
    params ["_object", "_set"];
    _object setAnimSpeedCoef _set;
}] call CBA_fnc_addEventHandler;

[QGVAR(setCaptive), {
    params ["_object", "_set"];
    TRACE_2("setCaptive EH",_object,_set);
    _object setCaptive (_set > 0);
}] call CBA_fnc_addEventHandler;

[QGVAR(setHidden), {
    params ["_object", "_set"];
    TRACE_2("setHidden EH",_object,_set);
    // May report nil. Default to factor 1.
    private _vis = [_object getUnitTrait "camouflageCoef"] param [0, 1];
    if (_set > 0) then {
        if (_vis != 0) then {
            _object setVariable [QGVAR(oldVisibility), _vis];
            _object setUnitTrait ["camouflageCoef", 0];
            {
                if (side _x != side group _object) then {
                    _x forgetTarget _object;
                };
            } forEach allGroups;
        };
    } else {
        _vis = _object getVariable [QGVAR(oldVisibility), _vis];
        _object setUnitTrait ["camouflageCoef", _vis];
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(blockRadio), {
    params ["_object", "_set"];
    TRACE_2("blockRadio EH",_object,_set);
    if (_object isEqualTo ACE_Player && {_set > 0}) then {
        call FUNC(endRadioTransmission); // TODO: ACE function
    };
    if ("task_force_radio" call CBA_fnc_isModLoaded) then {
        _object setVariable ["tf_unable_to_use_radio", _set > 0, true];
    };
    if ("acre_main" call CBA_fnc_isModLoaded) then {
        _object setVariable ["acre_sys_core_isDisabledRadio", _set > 0, true];
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(blockSpeaking), {
    params ["_object", "_set"];
    TRACE_2("blockSpeaking EH",_object,_set);
    if ("task_force_radio" call CBA_fnc_isModLoaded) then {
        _object setVariable ["tf_voiceVolume", parseNumber (_set == 0), true];
    };
    if ("acre_main" call CBA_fnc_isModLoaded) then {
        _object setVariable ["acre_sys_core_isDisabled", _set > 0, true];
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(blockDamage), { // Name reversed from `allowDamage` because we want NOR logic
    params ["_object", "_set"];
    if ((_object isKindOf "CAManBase") && {("ace_medical" call CBA_fnc_isModLoaded)}) then {
        TRACE_2("blockDamage EH (using medical)",_object,_set);
       _object setVariable ["ace_medical_allowDamage", (_set == 0), true];
    } else {
        TRACE_2("blockDamage EH (using allowDamage)",_object,_set);
       _object allowDamage (_set == 0);
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(blockEngine), {
    params ["_vehicle", "_set"];
    _vehicle setVariable ["ace_common_blockEngine", _set > 0, true];
    _vehicle engineOn false;
}] call CBA_fnc_addEventHandler;

[QGVAR(setMass), {
    params ["_object", "_mass"];
    _object setMass _mass;
}] call CBA_fnc_addEventHandler;

[QGVAR(disableWeaponAssembly), {
    params ["_object", "_set"];
    _object enableWeaponDisassembly (_set < 1);
}] call CBA_fnc_addEventHandler;

[QGVAR(lockInventory), {
    params ["_object", "_set"];
    TRACE_2("lockInventory EH",_object,_set);
    _object lockInventory (_set > 0);
}] call CBA_fnc_addEventHandler;

[QGVAR(lockVehicle), {
    _this setVariable [QGVAR(lockStatus), locked _this];
    _this lock 2;
    if ([] isNotEqualTo getArray (configOf _this >> "assembleInfo" >> "dissasembleTo")) then {
        [_this, "disableWeaponAssembly", "ace_common_lockVehicle", true] call CBA_fnc_setStatusEffect;
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(unlockVehicle), {
    _this lock (_this getVariable ["ace_common_lockStatus", locked _this]);
    if ([] isNotEqualTo getArray (configOf _this >> "assembleInfo" >> "dissasembleTo")) then {
        [_this, "disableWeaponAssembly", "ace_common_lockVehicle", false] call CBA_fnc_setStatusEffect;
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(disableCollision), { // Name "reversed" from `setPhysicsCollisionFlag` because we want NOR logic
    params ["_object", "_set"];
    TRACE_2("disableCollision EH",_object,_set);
    _object setPhysicsCollisionFlag (_set < 1);
}] call CBA_fnc_addEventHandler;

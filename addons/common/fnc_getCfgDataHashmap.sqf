#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getCfgDataHashmap

Description:
    This function extracts all config properties of a class and returns them as a Hashmap with the properties as keys (string).
    
    The following Values will be converted:
    Boolean as String ("true", "false") will be converted to boolean data-type.

    Will check if _cfg exists, if not, returns nil.

Parameters:
    _cfg        - Entry to get value of <CONFIG>
    _condition  - Condition for configProperties (optional, default: "true") <STRING>
    _inherit    - include inherited properties (optional, default: true) <BOOL>
    _convert    - convert certain values - see above (optional, default: true) <BOOL>

Returns:
    properties <HASHMAP>

Examples:
    (begin example)
        private _hashMap = [configFile >> "CfgJellies" >> "Blue_Jelly"] call CBA_fnc_getCfgDataHashmap;
    (end)

Author:
    OverlordZorn
---------------------------------------------------------------------------- */


params [
    ["_cfg", configNull, [configNull]],
    ["_condition", "true", [""]],
    ["_inherit", true, [true]],
    ["_convert", true, [true]]
];

if !(isClass _cfg || { isNull _cfg } ) exitWith { nil };

private _properties = configProperties [_cfg, _condition, _inherit];

private _returnHashMap = createHashMap;


{
    private _config = _x;
    private _value = _x call BIS_fnc_getCfgData;

    if (_convert) then {
        _value = switch (_value) do {
            case "true": { true };
            case "false": { false };
            default { _value };
        };
    };

    _returnHashMap set [
        configName _x,
        _value
    ];
    
} forEach _properties;

_returnHashMap // return

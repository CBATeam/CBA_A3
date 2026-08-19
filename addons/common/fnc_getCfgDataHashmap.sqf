#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getCfgDataHashmap

Description:
    This function extracts all config properties of a class and returns them as a Hashmap with the properties as keys (string).
    SubClasses will be returned as their own Hashmap.

    The following Values will be converted:
    Boolean as String ("true", "false") will be converted to boolean data-type.

    Will check if _cfg exists, if not, returns nil.

Parameters:
    _cfg        - Entry to get value of <CONFIG>
    _condition  - Condition for configProperties (optional, default: "true") <STRING>
    _inherit    - include inherited properties (optional, default: true) <BOOL>
    _convert    - convert certain values - see above (optional, default: true) <BOOL>
    _toLower    - applies toLowerANSI to keys of hashmap (optional, default: false) <BOOL>

Returns:
    properties <HASHMAP> (or <NIL> if _cfg is invalid)

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
	["_convert", true, [true]],
	["_toLower", false, [true]]
];

if !(isClass _cfg || { isNull _cfg } ) exitWith { nil };

private _properties = configProperties [_cfg, _condition, _inherit];

private _convertApply = [
	nil,
	{
		switch (true) do {
			case (_x isEqualType [] ): { _x apply _convertApply };
			case (_x isEqualTo "true");
			case (_x isEqualTo "(true)"): { true };
			case (_x isEqualTo "false");
			case (_x isEqualTo "(false)"): { false };
			default { _x };
		}
	}
] select _convert;


private _convertCall = [
	{
		_this
	},
	{
		switch (true) do {
			case (_this isEqualType [] ): { _this apply _convertApply };
			case (_this isEqualTo "true");
			case (_this isEqualTo "(true)"): { true };
			case (_this isEqualTo "false");
			case (_this isEqualTo "(false)"): { false };
			default { _this };
		};
	}
] select _convert;


private _returnHashMap = createHashMap;
{
	private _cfg = _x;
	private _key = if (_toLower) then { toLowerANSI configName _cfg } else { configName _cfg };

		private _value = if ( isClass _cfg ) then {
		[_cfg, _condition, _inherit, _convert, _toLower] call CBA_fnc_getCfgDataHashmap;

	} else {
		_cfg call BIS_fnc_getCfgData call _convertCall
	};

	_returnHashMap set [
		_key,
		_value
	];

} forEach _properties;

_returnHashMap // return

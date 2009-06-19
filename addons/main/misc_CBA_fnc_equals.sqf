/* ----------------------------------------------------------------------------
Function: CBA_fnc_equals

Description:
	Compares ANY two values, including nil, null, arrays or nested arrays,
	for equality.

	For our purposes, nils and nulls are considered equal to each
	other, which is contrary to how this is done in ArmA (nil == nil,
	objNull == objNull, controlNull == controlNull, displayNull == displayNull).

Examples:
(begin code)
	_same = [[1, nil, [3]], [1, nil, [3]]] call SPON_equals; // Returns true

	_same = [[1, nil, [3]], [1, [nil, 3]]] call SPON_equals; // Returns false

	_same = [objNull, objNull] call SPON_equals; // Returns true
(end code)

Parameters:
	_a - The first value [Any type]
	_b - The second value [Any type]

Returns:
	True for equality, false otherwise.

---------------------------------------------------------------------------- */

#include "script_component.hpp"

// Types that have a null value.
#define NULLABLE_TYPES ["OBJECT", "CONTROL", "DISPLAY", "GROUP"]

SCRIPT(equals);

// -----------------------------------------------------------------------------

private ["_equalsRecursive", "_nullableTypes"];

_nullableTypes = NULLABLE_TYPES;

_equalsRecursive =
{
	PARAMS_2(_a,_b);
	
	private "_result";
	
	if (isNil "_a") then
	{
		_result = isNil "_b";
	}
	else{if (isNil "_b") then
	{
		_result = false; // _a must not be nil
	}
	else{if ((typeName _a) == (typeName _b)) then
	{
		switch (typeName _a) do
		{
			case "ARRAY":
			{
				if ((count _a) == (count _b)) then
				{
					// Both arrays of the same size. Compare each element.
					_result = true;
					
					for "_i" from 0 to ((count _a) - 1) do
					{
						if (not ([_a select _i, _b select _i] call
							_equalsRecursive)) exitWith
						{
							_result = false;
						};
					};
				}
				else
				{
					_result = false;
				};
			};
			case "CONFIG":
			{
				_result = ((configName _a) == (configName _b));
			};
			case "CODE":
			{
				_result = ((str _a) == (str _b));
			};
			default
			{
				if ((typeName _a) in _nullableTypes) then
				{
					if ((isNull _a) and (isNull _b)) then
					{
						_result = true; // Same type of Null.
					}
					else
					{
						_result = (_a == _b); // Same type, not null.
					};
				}
				else
				{
					_result = (_a == _b); // A simple, comparible type.
				};
			};
		};
	}
	else
	{
		_result = false;
	}; }; };
	
	_result; // Return.
};

_this call _equalsRecursive; // Return.
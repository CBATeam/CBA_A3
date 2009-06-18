/* ----------------------------------------------------------------------------
@description Gets a value from parameters list (usually _this) with a default.

Example (direct use of function):
  private "_frog";
  _frog = [_this, 2, 12] call CBA_fnc_defaultParam;
  
Example (macro):
  #include "script_component.hpp"
  DEFAULT_PARAM(2,_frog,12);
 
Params:
  0: _params - Array of parameters, usually _this [Array]
  1: _index - Parameter index in the params array [Integer: >= 0]
  2: _defaultValue - Value to use if the array is too short [Any]

Returns:
  Value of parameter
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(defaultParam);

// -----------------------------------------------------------------------------
PARAMS_3(_params,_index,_defaultValue);

private "_value";

if (not isNil "_defaultValue") then
{
	_value = _defaultValue;
};

if (not isNil "_params") then
{
	if ((typeName _params) == "ARRAY") then
	{
		if ((count _params) > (_index)) then
		{
			if (not isNil { _params select (_index) }) then
			{
				_value = _params select (_index);
			};
		};
	};
};

// Return.
if (isNil "_value") then
{
	nil;
}
else
{
	_value;
};
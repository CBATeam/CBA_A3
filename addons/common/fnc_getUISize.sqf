/* ----------------------------------------------------------------------------
Function: CBA_fnc_getUISize

Description:
	Used to determine the UI size of the screen.
	
Parameters:
	_output - the desired output format, either "NUMBER" or "STRING".
	
Returns:
	If the desired output format is

	"NUMBER" : an index into ["verysmall","small","normal","large"]
	"STRING" : one of "verysmall", "small", "normal" or "large"
	
	If an error occurs, the function returns either the number -1 or
	the string "error", depending on the desired output format.
	
Examples:
	(begin example)
		_uiSize = "STRING" call CBA_fnc_getUISize;
	(end)

Author:
	Written by Deadfast and made CBA compliant by Vigilante
---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(getUISize);


 private ["_output", "_ratio", "_4to3", "_16to9", "_16to10", "_12to3", "_error", "_sizes", "_index", "_return"];

_output = toUpper (_this);
_ratio = "STRING" call CBA_fnc_getAspectRatio;

_4to3 = [1.818, 1.429, 1.176, 1];
_16to9 = [2.424, 1.905, 1.569, 1.333];
_16to10 = [2.182, 1.714, 1.412, 1.2];
_12to3 = [1.821, 1.430, 1.178, 1.001];
_error = false;

switch (_ratio) do
{
	case "4:3":
	{
		_sizes = _4to3;
	};
	case "5:4":
	{
		_sizes = _4to3;
	};
	case "16:9":
	{
		_sizes = _16to9;
	};
	case "16:10":
	{
		_sizes = _16to10;
	};
	case "12:3":
	{
		_sizes = _12to3;
	};
	default
	{
		_error = true;
	};
};

if (!_error) then
{
	_index = _sizes find ((round (safeZoneW * 1000)) / 1000);
	//hint str _index;
	if (_index == -1) exitWith
	{
		_error = true;
	};
};

if (_error) then
{
	if (_output == "STRING") then
	{
		_return = "error";
	}
	else
	{
		_return = -1;
	};
}
else
{
	if (_output == "STRING") then
	{
		switch (_index) do
		{
			case 0:
			{
				_return = "verysmall";
			};
			case 1:
			{
				_return = "small";
			};
			case 2:
			{
				_return = "normal";
			};
			case 3:
			{
				_return = "large";
			};
		};
	}
	else
	{
		_return = _index;
	};
};

_return;
/* ----------------------------------------------------------------------------
@description Finds a string within another string.

Parameters:
  0: _haystack - String in which to search [String or ASCII char array]
  1: _needle - String to search for [String or ASCII char array]
  2: _initialIndex - Initial character index within _haystack to start the
    search at [Number: 0+, defaults to 0].

Returns:
  First position of string

---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(find);

// ----------------------------------------------------------------------------

PARAMS_2(_haystack,_needle);
DEFAULT_PARAM(2,_initialIndex,0);

private ["_haystackCount", "_needleCount", "_foundPos",
	"_haystackIndex", "_needleIndex"];

if ((typeName _haystack) == "STRING") then
{
	_haystack = toArray _haystack;
};

if ((typeName _needle) == "STRING") then
{
	_needle = toArray _needle;
};

_haystackCount = count _haystack;
_needleCount = count _needle;
_foundPos = -1;

for [ { _haystackIndex = _initialIndex; _needleIndex = 0 },
	{ (_haystackIndex < _haystackCount) and (_foundPos == -1)},
	{ _haystackIndex = _haystackIndex + 1} ] do
{
	if ((_haystack select _haystackIndex) == (_needle select _needleIndex)) then
	{
		// Matched a single character.
		_needleIndex = _needleIndex + 1;
		
		// Found the whole needle.
		if (_needleIndex == _needleCount) then
		{
			_foundPos = _haystackIndex - (_needleCount - 1);
		};
	}
	else{if (_needleIndex > 0) then
	{
		// Found only a partial needle; start again.
		_haystackIndex = _haystackIndex - _needleIndex;
		_needleIndex = 0;
	}; };
};

_foundPos;
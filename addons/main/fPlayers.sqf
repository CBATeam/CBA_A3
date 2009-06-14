#include "script_component.hpp"
_ar = [];
{ if (isPlayer _x) then { PUSH(_ar,_x) } } forEach playableUnits;
_ar

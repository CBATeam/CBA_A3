#include "script_component.hpp"
//real z coordinate of an object, for placing stuff on roofs etc

private "_obj";
_obj = _this select 0;

((getpos _obj) select 2) + (_obj distance (getpos _obj))

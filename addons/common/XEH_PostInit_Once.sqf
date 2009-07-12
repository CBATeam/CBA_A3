#include "script_component.hpp"

// Create centers that do not exist yet
// TODO: Evaluate handling this in some createGroup function instead of creating them all?
#define CREATE_CENTER _center = createCenter _x
#define CREATE_GROUP _group = createGroup _x

{
		private ["_group", "_center"];
		CREATE_GROUP;
		if (isNil "_group") then
		{
			CREATE_CENTER;
			CREATE_GROUP;
		} else {
			if (isNull _group) then { CREATE_CENTER; CREATE_GROUP };
		};
		deleteGroup _group;
} forEach [east, west, resistance, civilian, sideLogic];

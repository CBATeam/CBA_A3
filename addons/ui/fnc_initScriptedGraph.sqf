#include "script_component.hpp"

params ["_control"];
private _display = ctrlParent _control;

systemChat str _display;

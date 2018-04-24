#include "script_component.hpp"

params ["_display"];

private _control = _display ctrlCreate [QGVAR(ProgressBar), -1];

_control ctrlShow false;

uiNamespace setVariable [QGVAR(ProgressBar), _control];

#define DEBUG_MODE_FULL
#include "script_component.hpp"

#define IDC_RSCDISPLAYARSENAL_LIST            960
#define IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC   24
#define IDC_RSCDISPLAYARSENAL_SORT            800


params ["_display"];
TRACE_1("handleArsenalOpened",_display);

if (missionNamespace getVariable [QGVAR(arsenalDataModified), false]) exitWith {
    TRACE_1("Already set", bis_fnc_arsenal_data select 24)
};

private _cbaMiscItems = [];
{
    private _class = _x;
    private _scope = if (isnumber (_class >> "scopeArsenal")) then {getnumber (_class >> "scopeArsenal")} else {getnumber (_class >> "scope")};
    TRACE_2("",_class,_scope);
    if (_scope == 2 && {gettext (_class >> "model") != ""}) then {
        _cbaMiscItems pushBack (configName _class);
    };
} forEach (configProperties [configFile >> "CfgWeapons", "(isClass _x) && {(configName _x) isKindOf ['CBA_MiscItem', configFile >> 'CfgWeapons']}"]);
TRACE_2("Items to add",count _cbaMiscItems,_cbaMiscItems);


// Much of this is from fn_arsenal.sqf -> "ListAdd"

private _fullVersion = missionnamespace getvariable ["BIS_fnc_arsenal_fullArsenal",false];
private _center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
private _cargo = (missionnamespace getvariable ["BIS_fnc_arsenal_cargo",objnull]);

private _virtualItemCargo =
(missionnamespace call bis_fnc_getVirtualItemCargo) +
(_cargo call bis_fnc_getVirtualItemCargo) +
items _center +
assigneditems _center +
primaryweaponitems _center +
secondaryweaponitems _center +
handgunitems _center +
[uniform _center,vest _center,headgear _center,goggles _center];

private _ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC);
private _virtualCargo = _virtualItemCargo;
private _virtualAll = _fullVersion || {"%ALL" in _virtualCargo};
private _columns = count lnbGetColumnsPosition _ctrlList;
{
    // Add item to display list if allowed:
    if (_virtualAll || {_x in _virtualCargo}) then {
        private _xCfg = configfile >> "cfgweapons" >> _x;
        private _lbAdd = _ctrlList lnbaddrow ["",gettext (_xCfg >> "displayName"),str 0];
        _ctrlList lnbsetdata [[_lbAdd,0],_x];
        _ctrlList lnbsetpicture [[_lbAdd,0],gettext (_xCfg >> "picture")];
        _ctrlList lnbsetvalue [[_lbAdd,0],getnumber (_xCfg >> "itemInfo" >> "mass")];
        _ctrlList lbsettooltip [_lbAdd * _columns,format ["%1\n%2",gettext (_xCfg >> "displayName"),_x]];
    };
    
    // Add item to main list (will be used on next arsenalOpened automaticly)
    (bis_fnc_arsenal_data select IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC) pushBack _x;
} foreach _cbaMiscItems;

missionNamespace setVariable [QGVAR(arsenalDataModified), true];
TRACE_1("finished",GVAR(arsenalDataModified));

nil

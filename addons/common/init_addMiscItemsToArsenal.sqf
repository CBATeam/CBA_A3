/*
Description:
    Adds items that inherit from CBA_MiscItem to the arsenal under "Miscellaneous Items" for uniform/vest/backpack.
    Much of this code is directly from BIS's fn_arsenal.sqf -> "ListAdd"

Author:
    PabstMirror (mostly just modified BIS code)
 */
// #define DEBUG_SYNCHRONOUS
// #define DEBUG_MODE_FULL

#include "script_component.hpp"
#include "\a3\ui_f\hpp\defineResinclDesign.inc"
// IDC_RSCDISPLAYARSENAL_LIST            960
// IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC   24


[missionNamespace, "arsenalOpened", {
    // If this code takes too long to finish, we could randomly get kicked out of missionNamespace
    // For safety, spawn and then directCall to prevent problems because we are called from fn_arsenal via `with missionNamespace do {`
    _this spawn {
        [{
            params ["_display"];
            TRACE_1("arsenalOpened",_display);

            // We only need to directly add the items to the display list once per mission as we also modify the data array
            if (missionNamespace getVariable [QGVAR(arsenalDataModified), false]) exitWith {
                TRACE_1("Already set",bis_fnc_arsenal_data select 24);
            };


            // Get properly scoped items that inherit from CBA_MiscItem
            private _cbaMiscItems = [];
            {
                private _class = _x;
                private _scope = if (isNumber (_class >> "scopeArsenal")) then {getNumber (_class >> "scopeArsenal")} else {getNumber (_class >> "scope")};
                TRACE_2("",_class,_scope);
                if (_scope == 2 && {getText (_class >> "model") != ""}) then {
                    _cbaMiscItems pushBack (configName _class);
                };
            } forEach (configProperties [configFile >> "CfgWeapons", "(isClass _x) && {(configName _x) isKindOf ['CBA_MiscItem', configFile >> 'CfgWeapons']}"]);
            TRACE_2("Items to add",count _cbaMiscItems,_cbaMiscItems);


            // BIS code to determine which items should be shown in the list (all items will still be added to the data array)
            private _fullVersion = missionNamespace getVariable ["BIS_fnc_arsenal_fullArsenal",false];
            private _center = (missionNamespace getVariable ["BIS_fnc_arsenal_center",player]);
            private _cargo = (missionNamespace getVariable ["BIS_fnc_arsenal_cargo",objNull]);

            private _virtualItemCargo =
            (missionNamespace call bis_fnc_getVirtualItemCargo) +
            (_cargo call bis_fnc_getVirtualItemCargo) +
            items _center +
            assignedItems _center +
            primaryWeaponItems _center +
            secondaryWeaponItems _center +
            handgunItems _center +
            [uniform _center,vest _center,headgear _center,goggles _center];

            private _ctrlList = _display displayCtrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC);
            private _virtualCargo = _virtualItemCargo;
            private _virtualAll = _fullVersion || {"%ALL" in _virtualCargo};
            private _columns = count lnbGetColumnsPosition _ctrlList;
            TRACE_2("",_virtualAll,_virtualCargo);
            {
                // Add item to display list if allowed
                if (_virtualAll || {_x in _virtualCargo}) then {
                    private _xCfg = configFile >> "cfgweapons" >> _x;
                    private _lbAdd = _ctrlList lnbAddRow ["",getText (_xCfg >> "displayName"),str 0];
                    _ctrlList lnbSetData [[_lbAdd,0],_x];
                    _ctrlList lnbSetPicture [[_lbAdd,0],getText (_xCfg >> "picture")];
                    _ctrlList lnbSetValue [[_lbAdd,0],getNumber (_xCfg >> "itemInfo" >> "mass")];
                    _ctrlList lbSetTooltip [_lbAdd * _columns,format ["%1\n%2",getText (_xCfg >> "displayName"),_x]];
                };

                // Add item to main list (will be used on next arsenalOpened automatically)
                (bis_fnc_arsenal_data select IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC) pushBack _x;
            } forEach _cbaMiscItems;

            // Sort the list:
            _ctrlList lnbSort [1,false];

            missionNamespace setVariable [QGVAR(arsenalDataModified), true];
            TRACE_1("finished",GVAR(arsenalDataModified));

        }, _this] call CBA_fnc_directCall;
    };
}] call bis_fnc_addScriptedEventHandler;

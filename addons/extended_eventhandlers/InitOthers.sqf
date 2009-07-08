/* Extended event handlers by Solus and Killswitch
*
* Get all inherited classes, then check if each inherited class has a
* counterpart in the extended event handlers classes. Then and add all lines
* from each matching EH class and set things up.
*
*/
private [
    "_unit", "_events", "_isExcluded", "_event", "_Extended_EH_Class",
    "_unitClass", "_classes", "_excludeClass", "_excludeClasses", "_handlers",
    "_handler", "_cfgEntry", "_scopeEntry", "_handlerEntry", "_excludeEntry",
    "_scope", "_i", "_t", "_xeh", "_event"
];

// Get unit.
_unit = _this select 0;
_unitClass = typeOf _unit;

_ehSuper = inheritsFrom(configFile/"CfgVehicles"/_unitClass/"EventHandlers");
_hasDefaultEH = (configName(_ehSuper)=="DefaultEventhandlers");
//
// All events except the init event
//
_events = [
    "AnimChanged", "AnimDone", "Dammaged", "Engine", "Fired",
    "FiredNear", "Fuel", "Gear", "GetIn", "GetOut", "Hit",
    "IncomingMissile", "Killed", "LandedTouchDown", "LandedStopped" //,
    //"HandleDamage"
];

_isExcluded = { (_unitClass isKindOf _excludeClass) || ({ _unitClass isKindOf _x }count _excludeClasses>0) };

// Iterate over the above event types and set up any extended event handlers
// that might be defined.
{
    _event = _x;
    _Extended_EH_Class = format["Extended_%1_EventHandlers", _event];

    // Get array of inherited classes of unit.
    _classes = [_unitClass];
    _excludeClass = "";
    _excludeClasses = [];
    while {
        !((_classes select 0) in ["", "All"])
    } do {
        _classes = [(configName (inheritsFrom (configFile/"CfgVehicles"/(_classes select 0))))]+_classes;
    };

    // Check each class to see if there is a counterpart in the extended event
    // handlers, add all lines from matching classes to an array, "_handlers"
    _handlers = [];
    
    // Does the vehicle's class EventHandlers inherit from the BIS
    // DefaultEventhandlers? If so, include BIS own default handler for the
    // event type currently being processed and make it the first
    // EH to be called.
    if (_hasDefaultEH && isText(configFile/"DefaultEventhandlers"/_event)) then {
        _handlers =[getText(configFile/"DefaultEventhandlers"/_event)];
    };
    {
        if (
            (configName (configFile/_Extended_EH_Class/_x))!= ""
            ) then {
            _i = 0;
            _t = count (configFile/_Extended_EH_Class/_x);
            while { _i<_t } do {
                _cfgEntry = (configFile/_Extended_EH_Class/_x) select _i;
                // Standard XEH event handler string
                if (isText _cfgEntry) then {
                    _handlers = _handlers+[getText _cfgEntry];
                } else {
                    // Composite XEH event handler class
                    if (isClass _cfgEntry) then {
                        _scopeEntry = _cfgEntry / "scope";
                        _handlerEntry = _cfgEntry / _event;
                        _excludeEntry = _cfgEntry / "exclude";
                        _replaceEntry = _cfgEntry / "replaceDEH";
                        if (isText _excludeEntry) then {
                            _excludeClass = (getText _excludeEntry);
                        } else {
                            if (isArray _excludeEntry) then {
                                _excludeClasses = (getArray _excludeEntry);
                            };
                        };
                        if (isText _replaceEntry) then {
                            _replaceDEH = ({ (getText _replaceEntry) == _x }count["1", "true"]>0);
                        } else {
                            if (isNumber _replaceEntry) then {
                                _replaceDEH = ((getNumber _replaceEntry) == 1);
                            };
                        };
                        if (isText _handlerEntry) then {
                            _scope = if (isNumber _scopeEntry) then { getNumber _scopeEntry } else { 2 };
                            // If the particular EH is private and vehicle is of the
                            // "wrong" class, do nothing, ie don't add the EH.
                            if !(_scope == 0 && (_unitClass != _x)) then {
                                if !( [] call _isExcluded ) then {
                                    if (_hasDefaultEH && _replaceDEH) then {
                                        _handlers set [0, getText _handlerEntry];
                                    } else {
                                        _handlers = _handlers+[getText _handlerEntry];
                                    };
                                };
                            };
                        };
                    };
                };
                _i = _i+1;
            };
        };
    } forEach _classes;

    // Now concatenate all the handlers into one string
    _handler = "";
    { _handler = _handler+_x+";" } forEach _handlers;

    // Attach the compiled extended event handler to the unit.
    _xeh = format["Extended_%1EH", _event];
    _unit setVariable [_xeh, compile _handler];

} forEach _events;

nil;

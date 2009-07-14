private ["_unit"];
_unit = _this select 0;

/*  Extended event handlers by Solus
*
*  Get all inherited classes, then check if each inherited class has a counter-
*  part in the extended event handlers classes, then and add all lines from
*  each matching EH class and exec them.
*/
private [
	"_unit", "_Extended_Init_Class", "_isRespawn", "_unitClass", "_classes",
	"_inits", "_init", "_excludeClass", "_excludeClasses", "_isExcluded",
	"_onRespawn", "_useEH", "_i", "_t", "_cfgEntry", "_scopeEntry",
	"_initEntry", "_excludeEntry", "_respawnEntry", "_u", "_eic", "_sim", "_crew"
];
// Get unit.
_unit = _this select 0;
_Extended_Init_Class = _this select 1;
_isRespawn = if (count _this>2) then { _this select 2 } else { false };

// Get array of inherited classes of unit.
_unitClass = typeOf _unit;
_classes = [_unitClass];
while { !((_classes select 0) in ["", "All"]) } do
{
	_classes = [(configName (inheritsFrom (configFile/"CfgVehicles"/(_classes select 0))))]+_classes;
};

// Check each class to see if there is a counterpart in extended event handlers
// If there is, add it to an array of init event handlers "_inits"
_inits = [];
_init = {};
_excludeClass = "";
_excludeClasses = [];
_isExcluded = { (_unitClass isKindOf _excludeClass) || ({ _unitClass isKindOf _x }count _excludeClasses>0) };

/*  If we're called following a respawn, the use of a XEH init EH is
*  determined by the "composite EH" class property "onRespawn". The default
*  is to not call the XEH init EH, since the ArmA default behaviour is that
*  "init" event handlers are not called when a unit respawns.
*/
_useEH = { if (_isRespawn) then { _onRespawn } else { true } };

/*
*  Several BIS vehicles use a set of EH:s in the BIS "DefaultEventhandlers"
*  ("DEH" in the following) class - Car, Tank, Helicopter, Plane and Ship.
* 
*  Further, The AAV class uses a variation of this DefaultEventhandlers set with
*  it's own specific init EH.  Here, we make sure to include the BIS DEH init
*  event handler and make it the first one that will be called by XEH. The AAV
*  is accomodated by code further below and two composite 
*  Extended_Init_EventHandlers definitions in the config.cpp that define
*  a property "replaceDefault" which will replace the DEH init with the
*  class-specific BIS init EH for that vehicle.
*/
_useDEHinit = false;
if (_Extended_Init_Class =="Extended_Init_EventHandlers") then {
	_ehSuper = inheritsFrom(configFile/"CfgVehicles"/_unitClass/"EventHandlers");
	if (configName(_ehSuper)=="DefaultEventhandlers") then {
		if (isText (configFile/"DefaultEventhandlers"/"init")) then {
			_useDEHinit = true;
			_DEHinit = getText(configFile/"DefaultEventhandlers"/"init");
			_inits =[compile(_DEHinit)];
		};
	};
};

{
	if ((configName (configFile/_Extended_Init_Class/_x))!= "") then
	{
		_i = 0;
		_t = count (configFile/_Extended_Init_Class/_x);
		while { _i<_t } do
		{
			_cfgEntry = (configFile/_Extended_Init_Class/_x) select _i;
			// Standard XEH init string
			if (isText _cfgEntry) then
			{
				_inits = _inits+[compile(getText _cfgEntry)];
			} else {
				// Composite XEH init class
				if (isClass _cfgEntry) then
				{
					_scopeEntry = _cfgEntry / "scope";
					_initEntry = _cfgEntry / "init";
					_excludeEntry = _cfgEntry / "exclude";
					_respawnEntry = _cfgEntry / "onRespawn";
					_replaceEntry = _cfgEntry / "replaceDEH";
					if (isText _excludeEntry) then
					{
						_excludeClass = (getText _excludeEntry);
					} else {
						if (isArray _excludeEntry) then
						{
							_excludeClasses = (getArray _excludeEntry);
						};
					};
					_onRespawn = false;
					if (isText _respawnEntry) then
					{
						_onRespawn = ({ (getText _respawnEntry) == _x }count["1", "true"]>0);
					} else {
						if (isNumber _respawnEntry) then
						{
							_onRespawn = ((getNumber _respawnEntry) == 1);
						};
					};
					_replaceDEH = false;
					if (isText _replaceEntry) then {
						_replaceDEH = ({ (getText _replaceEntry) == _x }count["1", "true"]>0);
					} else {
						if (isNumber _replaceEntry) then
						{
							_replaceDEH = ((getNumber _replaceEntry) == 1);
						};
					};
					if (isText _initEntry) then
					{
						_scope = if (isNumber _scopeEntry) then { getNumber _scopeEntry } else { 2 };
						/*  If the init EH is private and vehicle is of the
						*  "wrong" class, do nothing, ie don't add the EH.
						*  Also, if we're called after a respawn and the
						*  init EH shouldn't be used, then don't.
						*/
						if !(_scope == 0 && (_unitClass != _x)) then
						{
							if (!([] call _isExcluded) && [] call _useEH) then
							{
								_init = compile(getText _initEntry);
								if (_useDEHinit && _replaceDEH) then {
									_inits set [0, _init];
								} else {
									_inits = _inits+[_init];
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

// Now call all the init EHs on the unit.
{ [_unit] call _x } forEach _inits;

nil;

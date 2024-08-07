// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL
#include "script_component.hpp"

SCRIPT(test_settings);

// ----------------------------------------------------------------------------

private ["_funcName", "_settings", "_result"];

LOG('Testing Settings');

// UNIT TESTS (parse)
_funcName = QFUNC(parse);
TEST_DEFINED(QFUNC(parse),"");

// Purposely weird formatting, must remain this way because newlines remain part of result
_settings = (preprocessFile "x\cba\addons\settings\test_settings_regular.inc.sqf") call FUNC(parse);
_result = _settings isEqualTo [
    ["ace_advanced_ballistics_ammoTemperatureEnabled", true, 0],
    ["ace_advanced_ballistics_barrelLengthInfluenceEnabled", false, 2],
    ["ace_advanced_ballistics_bulletTraceEnabled", true, 1],
    ["ace_advanced_fatigue_enabled", false, 0],
    ["ace_advanced_fatigue_enableStaminaBar", true, 0],
    ["ace_advanced_fatigue_performanceFactor", 1, 1],
    ["ace_advanced_fatigue_terrainGradientFactor", 1, 2]
];
TEST_TRUE(_result,_funcName);

_settings = (preprocessFile "x\cba\addons\settings\test_settings_multiline.inc.sqf") call FUNC(parse);
_result = _settings isEqualTo [
    ["test1", "[
    ""  item_1  "",
    ""  item_2  ""
]", 0],
    ["test2", "[
    '  item_1  ',
            '  item_2  '
]", 1],
    ["test3", "[
    '  item_1  '   , ""  item_2  ""
]", 2],
    ["test4", "

[
'""  item_1  ""',
'  item_2  '
]

", 0]
];
TEST_TRUE(_result,_funcName);

_settings = (preprocessFile "x\cba\addons\settings\test_settings_unicode.inc.sqf") call FUNC(parse);
_result = _settings isEqualTo [["test1", "[Āā, Ăă, Ҙ, привет]", 1]];
TEST_TRUE(_result,_funcName);

_settings = (preprocessFile "x\cba\addons\settings\test_settings_strings.inc.sqf") call FUNC(parse);
_result = _settings isEqualTo [
    ["test1", "", 0],
    ["test2", "", 0],
    ["test3", "  T E S T  " , 0],
    ["test4", "  T E S T  ", 0],
    ["test5", "[ '  t e s t  ' , ""  T E S T  "" ]", 0],
    ["test6", "[ ""  t e s t  "" ,

""""  T E S T  """" ]", 0],
    ["test7", "[ true, false ]", 0],
    ["test8", "[ ""  item_1  "" , ""  item_2  "" ]", 0],
    ["test9", "[ '  item_1  ' , '  item_2  ' ]", 0],
    ["test10", "[ '  item_1  ' , ""  item_2  "" ]", 0],
    ["test11", "[ '""  item_1  ""' , '  item_2  ' ]", 0],
    ["test12", "[ '  item_1  ' , ""'  item_2  '"" ]", 0],
    ["test13", "'", 0],
    ["test14", "''", 0]
];
TEST_TRUE(_result,_funcName);

// Don't preprocess for testing comments
_settings = [loadFile "x\cba\addons\settings\test_settings_comments.inc.sqf", false, "", false] call FUNC(parse);
_result = _settings isEqualTo [
    ["test2", "[true,false]", 1],
    ["test4", "[ '  t e s t  ' , ""  T E S T  "" ]", 0],
    ["test8", "https://github.com/CBATeam/CBA_A3", 0],
    ["ace_advanced_ballistics_ammoTemperatureEnabled", true, 0],
    ["ace_advanced_ballistics_barrelLengthInfluenceEnabled", true, 2],
    ["ace_advanced_ballistics_bulletTraceEnabled", true, 1]
];
TEST_TRUE(_result,_funcName);

_settings = [loadFile "x\cba\addons\settings\test_settings_comments_eof.inc.sqf", false, "", false] call FUNC(parse);
_result = _settings isEqualTo [
    ["test1", "[""item_1"",""item_2""]", 1]
];
TEST_TRUE(_result,_funcName);

nil

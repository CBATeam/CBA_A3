#define THIS_FILE CBA\main\error
scriptName 'THIS_FILE';

// @description Logs an error message to the RPT log.

// TODO: popup window with error message in it.
diag_log text format (["%1:%2: [ERROR] %3 %4"] + _this);

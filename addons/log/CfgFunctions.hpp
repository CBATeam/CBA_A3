#include "script_component.hpp"

class CfgFunctions {
    class PREFIX {
        class COMPONENT {
            class logDynamic {
                description = "Add a system wide named log level.";
                file = QUOTE(PATHTOF(fnc_logDynamic.sqf));
            };
            class getLogLevelDescriptor {
                description = "Get log level name.";
                file = QUOTE(PATHTOF(fnc_getLogLevelDescriptor.sqf));
            };
            class addLogLevelDescriptor {
                description = "Add a system wide named log level.";
                file = QUOTE(PATHTOF(fnc_addLogLevelDescriptor.sqf));
            };
            class removeLogLevelDescriptor {
                description = "Remove a system wide named log level.";
                file = QUOTE(PATHTOF(fnc_removeLogLevelDescriptor.sqf));
            };
            class diagLogGlobalWriter {
                description = "Writes supplied message to diag_log on every connected client and server.";
                file = QUOTE(PATHTOF(writers\fnc_diagLogGlobalWriter.sqf));
            };
            class diagLogWriter {
                description = "Writes supplied message to diag_log.";
                file = QUOTE(PATHTOF(writers\fnc_diagLogWriter.sqf));
            };
            class hintGlobalWriter {
                description = "Writes supplied message with hint on every connected client and server.";
                file = QUOTE(PATHTOF(writers\fnc_hintGlobalWriter.sqf));
            };
            class hintWriter {
                description = "Writes supplied message with hint.";
                file = QUOTE(PATHTOF(writers\fnc_hintWriter.sqf));
            };
            class systemChatGlobalWriter {
                description = "Writes supplied message to systemChat on every connected client and server.";
                file = QUOTE(PATHTOF(writers\fnc_systemChatGlobalWriter.sqf));
            };
            class systemChatWriter {
                description = "Writes supplied message to systemChat.";
                file = QUOTE(PATHTOF(writers\fnc_systemChatWriter.sqf));
            };
        };
    };
};

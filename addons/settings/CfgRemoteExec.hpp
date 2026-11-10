// Only relevant if remote execution of functions is in whitelist mode (mode = 1).
// Missions that define their own CfgRemoteExec have to whitelist this function themselves (or import this config).
class CfgRemoteExec {
    class Functions {
        class FUNC(setServerRequest) {
            allowedTargets = 2;
            jip = 0;
        };
    };
};

class CA_Join;
class CA_ValueSessions;
class RscListBox;
class RscStandardDisplay;

class RscDisplayMultiplayer: RscStandardDisplay {
	class Controls {
		class CA_Join: CA_Join {
			onMouseButtonDown = "uiNamespace setVariable ['CBA_isCached', nil]";
			onKeyDown = "uiNamespace setVariable ['CBA_isCached', nil]";
		};
		class CA_ValueSessions: CA_ValueSessions {
			onMouseButtonDown = "uiNamespace setVariable ['CBA_isCached', nil]";
		};
	};
};

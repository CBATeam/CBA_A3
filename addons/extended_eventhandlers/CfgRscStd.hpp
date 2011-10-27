class RscStandardDisplay;
class RscIGUIListBox;
class RscListBox;
class RscDisplayMultiplayer: RscStandardDisplay {
	class ControlsBackground {
		class CA_Cancel;
		class CA_Join: CA_Cancel {
			onMouseButtonDown = "uiNamespace setVariable ['CBA_isCached', nil]";
			onKeyDown = "uiNamespace setVariable ['CBA_isCached', nil]";
		};
	};
	class Controls {
		class CA_ValueSessions: RscListBox {
			onMouseButtonDown = "uiNamespace setVariable ['CBA_isCached', nil]";
		};
	};
};

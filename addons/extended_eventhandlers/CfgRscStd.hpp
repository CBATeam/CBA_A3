class RscStandardDisplay;
class RscIGUIListBox;
class RscDisplayMultiplayer: RscStandardDisplay {
	class ControlsBackground {
		class CA_Cancel;
		class CA_Join: CA_Cancel {
			onMouseButtonDown = "uiNamespace setVariable ['CBA_isCached', nil]";
			onKeyDown = "uiNamespace setVariable ['CBA_isCached', nil]";
		};
	};
	class Controls {
		class CA_ValueSessions: RscIGUIListBox {
			onMouseButtonDown = "uiNamespace setVariable ['CBA_isCached', nil]";
		};
	};
};
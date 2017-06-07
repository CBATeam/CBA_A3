class CfgMagazines {
	class CA_Magazine;
	class 30Rnd_556x45_Stanag;

	class CBA_M_30Rnd_556x45_M855A1_Stanag: 30Rnd_556x45_Stanag {
		displayName = "5.56mm 30rnd M855A1 (EPR) STANAG Mag";
		displaynameshort = "M855A1";
		ammo = "CBA_B_556x45_M855A1";
		initSpeed = 960.12;
		tracersEvery = 0;
		lastRoundsTracer = 3;
		author = "CBA";
	};

	class CBA_M_30Rnd_556x45_M856A1_Stanag: CBA_M_30Rnd_556x45_M855A1_Stanag {
		displayName = "5.56mm 30rnd M856A1 (Tracer) STANAG Mag";
		displaynameshort = "Tracer";
		picture = "\A3\weapons_F\data\UI\m_30stanag_red_ca";
		tracersEvery = 1;
		lastRoundsTracer = 30;
		author = "CBA";
	};

	class CBA_M_30Rnd_556x45_Mk262_Stanag: 30Rnd_556x45_Stanag {
		displayName = "5.56mm 30rnd Mk262 (SPR) STANAG Mag";
		displaynameshort = "Mk262";
		ammo = "CBA_B_556x45_Mk262";
		initSpeed = 868.68;
		tracersEvery = 0;
		lastRoundsTracer = 0;
		author = "CBA";
	};

	class CBA_M_30Rnd_556x45_Mk318_Stanag: 30Rnd_556x45_Stanag {
		displayName = "5.56mm 30rnd Mk318 (SOST) STANAG Mag";
		displaynameshort = "Mk318";
		ammo = "CBA_B_556x45_Mk318";
		initSpeed = 955.2432;
		tracersEvery = 0;
		lastRoundsTracer = 0;
		author = "CBA";
	};

	class CBA_M_30Rnd_556x45_M995_Stanag: 30Rnd_556x45_Stanag {
		displayName = "5.56mm 30rnd M995 (AP) STANAG Mag";
		displaynameshort = "AP";
		ammo = "CBA_B_556x45_M995";
		initSpeed = 869;
		tracersEvery = 0;
		lastRoundsTracer = 0;
		author = "CBA";
	};

	class CBA_M_30Rnd_556x45_M996_Stanag: 30Rnd_556x45_Stanag {
		displayName = "5.56mm 30rnd M996 (IR-Dim Tracer) STANAG Mag";
		displaynameshort = "AP";
		ammo = "CBA_B_556x45_M996";
		tracersEvery = 1;
		lastRoundsTracer = 30;
		author = "CBA";
	};


	class 20Rnd_762x51_Mag: CA_Magazine
	{
		displayName = "7.62mm 20Rnd M80 M14 Mag";
	};
	class CBA_M_20Rnd_762x51_M80_G3: 20Rnd_762x51_Mag
	{
		displayName = "7.62mm 20Rnd M80 G3 Mag";
		descriptionShort = "Caliber: 7.62x51 mm NATO<br />Rounds: 20<br />Used in: G3";
		author = "CBA";
	};
	class CBA_M_20Rnd_762x51_M80_FAL: 20Rnd_762x51_Mag
	{
		displayName = "7.62mm 20Rnd M80 FAL Mag";
		descriptionShort = "Caliber: 7.62x51 mm NATO<br />Rounds: 20<br />Used in: FAL";
		author = "CBA";
	};
	class CBA_M_20Rnd_762x51_M80_SR25: 20Rnd_762x51_Mag
	{
		displayName = "7.62mm 20Rnd M80 SR25 Mag";
		descriptionShort = "Caliber: 7.62x51 mm NATO<br />Rounds: 20<br />Used in: Mk-I EMR, SR25";
		picture = "\A3\weapons_f\data\UI\m_20stanag_ca";
		author = "CBA";
	};
	class CBA_M_20Rnd_762x51_M80A1_M14: 20Rnd_762x51_Mag
	{
		displayName = "7.62mm 20Rnd M80A1 M14 Mag";
		displaynameshort = "M80A1";
		ammo = "CBA_B_762x51_M80A1";
		initSpeed = 938.784;
		tracersEvery = 0;
		lastRoundsTracer = 0;
		author = "CBA";
	};
	class CBA_M_20Rnd_762x51_M80A1_G3: CBA_M_20Rnd_762x51_M80A1_M14
	{
		displayName = "7.62mm 20Rnd M80A1 G3 Mag";
		descriptionShort = "Caliber: 7.62x51 mm NATO<br />Rounds: 20<br />Used in: G3";
		mass = 10;
		author = "CBA";
	};
	class CBA_M_20Rnd_762x51_M80A1_FAL: CBA_M_20Rnd_762x51_M80A1_M14
	{
		displayName = "7.62mm 20Rnd M80A1 FAL Mag";
		descriptionShort = "Caliber: 7.62x51 mm NATO<br />Rounds: 20<br />Used in: FAL";
		mass = 10;
		author = "CBA";
	};
	class CBA_M_20Rnd_762x51_M80A1_SR25: CBA_M_20Rnd_762x51_M80A1_M14
	{
		displayName = "7.62mm 20Rnd M80A1 SR25 Mag";
		descriptionShort = "Caliber: 7.62x51 mm NATO<br />Rounds: 20<br />Used in: Mk-I EMR, SR25";
		picture = "\A3\weapons_f\data\UI\m_20stanag_ca";
		author = "CBA";
	};
	class CBA_M_20Rnd_762x51_Mk316_M14: 20Rnd_762x51_Mag
	{
		displayName = "7.62mm 20Rnd Mk316 M14 Mag";
		displaynameshort = "Mk316";
		ammo = "CBA_B_762x51_Mk316";
		initSpeed = 804.672;
		tracersEvery = 0;
		lastRoundsTracer = 0;
		author = "CBA";
	};
	class CBA_M_20Rnd_762x51_Mk316_G3: CBA_M_20Rnd_762x51_Mk316_M14
	{
		displayName = "7.62mm 20Rnd Mk316 G3 Mag";
		descriptionShort = "Caliber: 7.62x51 mm NATO<br />Rounds: 20<br />Used in: G3";
		author = "CBA";
	};
	class CBA_M_20Rnd_762x51_Mk316_FAL: CBA_M_20Rnd_762x51_Mk316_M14
	{
		displayName = "7.62mm 20Rnd Mk316 FAL Mag";
		descriptionShort = "Caliber: 7.62x51 mm NATO<br />Rounds: 20<br />Used in: FAL";
		author = "CBA";
	};
	class CBA_M_20Rnd_762x51_Mk316_SR25: CBA_M_20Rnd_762x51_Mk316_M14
	{
		displayName = "7.62mm 20Rnd Mk316 SR25 Mag";
		descriptionShort = "Caliber: 7.62x51 mm NATO<br />Rounds: 20<br />Used in: Mk-I EMR, SR25";
		picture = "\A3\weapons_f\data\UI\m_20stanag_ca";
		author = "CBA";
	};
	class CBA_M_20Rnd_762x51_LFMJBTSUB_M14: 20Rnd_762x51_Mag
	{
		displayName = "7.62mm 20Rnd Subsonic M14 Mag";
		displaynameshort = "BTSub";
		ammo = "CBA_B_762x51_LFMJBTSUB";
		initSpeed = 359.664;
		tracersEvery = 0;
		lastRoundsTracer = 0;
		author = "CBA";
	};
	class CBA_M_20Rnd_762x51_LFMJBTSUB_G3: CBA_M_20Rnd_762x51_LFMJBTSUB_M14
	{
		displayName = "7.62mm 20Rnd Subsonic G3 Mag";
		descriptionShort = "Caliber: 7.62x51 mm NATO<br />Rounds: 20<br />Used in: G3";
		author = "CBA";
	};
	class CBA_M_20Rnd_762x51_LFMJBTSUB_FAL: CBA_M_20Rnd_762x51_LFMJBTSUB_M14
	{
		displayName = "7.62mm 20Rnd Subsonic FAL Mag";
		descriptionShort = "Caliber: 7.62x51 mm NATO<br />Rounds: 20<br />Used in: FAL";
		author = "CBA";
	};
	class CBA_M_20Rnd_762x51_LFMJBTSUB_SR25: CBA_M_20Rnd_762x51_LFMJBTSUB_M14
	{
		displayName = "7.62mm 20Rnd Subsonic SR25 Mag";
		descriptionShort = "Caliber: 7.62x51 mm NATO<br />Rounds: 20<br />Used in: Mk-I EMR, SR25";
		picture = "\A3\weapons_f\data\UI\m_20stanag_ca";
		author = "CBA";
	};

};

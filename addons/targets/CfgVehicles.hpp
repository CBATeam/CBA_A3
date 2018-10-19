class CfgVehicles 
{
  class StaticWeapon;
  class TargetSoldierBase: StaticWeapon
  {
    class Turrets;
  };
  class B_TargetSoldier: TargetSoldierBase
  {
    class Turrets: Turrets
    {
      class MainTurret;
    };
  };
  class O_TargetSoldier: TargetSoldierBase
  {
    class Turrets: Turrets
    {
      class MainTurret;
    };
  };
  class I_TargetSoldier: TargetSoldierBase
  {
    class Turrets: Turrets
    {
      class MainTurret;
    };
  };
  class B_TargetSoldier_CBA: B_TargetSoldier 
  {
    model = QPATHTOF(invisible_target.p3d);
    scope = 2;
    class Turrets: Turrets
    {
      class MainTurret: MainTurret
      {
        class HitPoints{};
      };
    };
  };
  class O_TargetSoldier_CBA: O_TargetSoldier 
  {
    model = QPATHTOF(invisible_target.p3d);
    scope = 2;
    class Turrets: Turrets
    {
      class MainTurret: MainTurret
      {
        class HitPoints{};
      };
    };
  };
  class I_TargetSoldier_CBA: I_TargetSoldier 
  {
    model = QPATHTOF(invisible_target.p3d);
    scope = 2;
    class Turrets: Turrets
    {
      class MainTurret: MainTurret
      {
        class HitPoints{};
      };
    };
  };
};

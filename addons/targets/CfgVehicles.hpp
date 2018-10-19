class CfgVehicles 
{
  class B_TargetSoldier;
  class O_TargetSoldier;
  class I_TargetSoldier;
  class B_TargetSoldier_CBA: B_TargetSoldier 
  {
    class Turrets {};
    model = QPATHTOF(invisible_target.p3d);
    scope = 2;
  };
  class O_TargetSoldier_CBA: O_TargetSoldier 
  {
    class Turrets {};
    model = QPATHTOF(invisible_target.p3d);
    scope = 2;
  };
  class I_TargetSoldier_CBA: I_TargetSoldier 
  {
    class Turrets {};
    model = QPATHTOF(invisible_target.p3d);
    scope = 2;
  };
};

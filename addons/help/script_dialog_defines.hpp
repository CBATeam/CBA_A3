#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineResincl.inc"

#define __X SafeZoneX
#define __Y SafeZoneY
#define __W SafeZoneW
#define __H SafeZoneH

#define __SX(var1) x = QUOTE(var1 * GUI_GRID_W + GUI_GRID_CENTER_X)
#define __SY(var1) y = QUOTE(var1 * GUI_GRID_H + GUI_GRID_Y)
#define __SW(var1) w = QUOTE(var1 * GUI_GRID_W)
#define __SH(var1) h = QUOTE(var1 * GUI_GRID_H)
#define __RSX(var1) x = QUOTE(var1 * GUI_GRID_W + GUI_GRID_X + safeZoneW)
#define __RSY(var1) y = QUOTE(var1 * GUI_GRID_H + GUI_GRID_Y + safeZoneH)

#define __FSX(var1) x = QUOTE((var1 * safeZoneW) + safeZoneX)
#define __FSY(var1) y = QUOTE((var1 * safeZoneH) + safeZoneY)
#define __FSW(var1) w = QUOTE(var1 * safeZoneW)
#define __FSH(var1) h = QUOTE(var1 * safeZoneH)

#define __IX(var1) var1 * GUI_GRID_W + GUI_GRID_X
#define __IY(var1) var1 * GUI_GRID_H + GUI_GRID_Y
#define __IW(var1) var1 * GUI_GRID_W
#define __IH(var1) var1 * GUI_GRID_H
#define __RIX(var1) var1 * GUI_GRID_W + GUI_GRID_X + safeZoneW
#define __RIY(var1) var1 * GUI_GRID_H + GUI_GRID_Y + safeZoneH

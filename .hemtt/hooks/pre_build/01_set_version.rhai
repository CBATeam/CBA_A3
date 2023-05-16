let modcpp = HEMTT_VFS.join("mod.cpp").open_file().read();
modcpp.replace("0.0.0", HEMTT.project().version().to_string_short());
HEMTT_VFS.join("mod.cpp").create_file().write(modcpp);
print("mod.cpp version set");

let cfgmodshpp = HEMTT_VFS.join("addons").join("main_a3").join("CfgMods.hpp").open_file().read();
cfgmodshpp.replace("0.0.0", HEMTT.project().version().to_string_short());
HEMTT_VFS.join("addons").join("main_a3").join("CfgMods.hpp").create_file().write(cfgmodshpp);
print("addons/main_a3/CfgMods.hpp version set");

let scriptversion = HEMTT_VFS.join("addons").join("main").join("script_version.hpp").open_file().read();
scriptversion.replace("000000", HEMTT.project().version().build()); // TODO date %y%m%d (eg. 220912)
HEMTT_VFS.join("addons").join("main").join("script_version.hpp").create_file().write(scriptversion);
print("addons/main/script_version.hpp build set");

#!/usr/bin/env python3

"""CBA Debug Build"""

import os
import sys
import subprocess

######## GLOBALS #########
MAINPREFIX = "x"
PREFIX = "cba_"
##########################

def try_hemtt_build(projectpath):
    """Try building with hemtt"""
    hemtt = os.path.join(projectpath, "hemtt.exe")
    if os.path.isfile(hemtt):
        os.chdir(projectpath)
        ret = subprocess.call([hemtt, "pack"], stderr=subprocess.STDOUT)
        print("Using hemtt: {}".format(ret))
        return True

    print("hemtt not installed")
    return False

def mod_time(path):
    """Return time of last modification of a file or directory

    If the path is a directory, return the time of modification of
    the most recently modified file in the directory.
    """
    if not os.path.isdir(path):
        return os.path.getmtime(path)
    maxi = os.path.getmtime(path)
    for name in os.listdir(path):
        maxi = max(mod_time(os.path.join(path, name)), maxi)
    return maxi


def check_for_changes(addonspath, module):
    """Return True if the sources of an addon have been changed since it was last built"""
    file = os.path.join(addonspath, "{}{}.pbo".format(PREFIX, module))
    if not os.path.exists(file):
        return True
    return mod_time(os.path.join(addonspath, module)) > mod_time(file)

def check_for_obsolete_pbos(addonspath, file):
    """Return True if the source directory for addon no longer exists"""
    module = file[len(PREFIX):-4]
    if not os.path.exists(os.path.join(addonspath, module)):
        return True
    return False

def main(): # pylint: disable=missing-function-docstring
    print("""
  ###################
  # CBA Debug Build #
  ###################
""")

    scriptpath = os.path.realpath(__file__)
    projectpath = os.path.dirname(os.path.dirname(scriptpath))
    addonspath = os.path.join(projectpath, "addons")

    if try_hemtt_build(projectpath):
        return

    os.chdir(addonspath)

    made = 0
    failed = 0
    skipped = 0
    removed = 0

    for file in os.listdir(addonspath):
        if os.path.isfile(file):
            if check_for_obsolete_pbos(addonspath, file):
                removed += 1
                print("  Removing obsolete file => " + file)
                os.remove(file)
    print("")

    for name in os.listdir(addonspath):
        path = os.path.join(addonspath, name)
        if not os.path.isdir(path):
            continue
        if name[0] == ".":
            continue
        if not check_for_changes(addonspath, name):
            skipped += 1
            print("  Skipping {}.".format(name))
            continue

        print("# Making {} ...".format(name))

        usescriptsfolder = os.path.join(path, "$SCRIPTSFOLDER$")
        if os.path.isfile(usescriptsfolder):
            pbopath = "-@=userconfig"
        else:
            pbopath = "-@={}\\{}\\addons\\{}".format(MAINPREFIX, PREFIX.rstrip("_"), name)

        try:
            subprocess.check_output([
                "makepbo",
                "-NUP",
                pbopath,
                name,
                "{}{}.pbo".format(PREFIX, name)
            ], stderr=subprocess.STDOUT)
        except subprocess.CalledProcessError as err:
            failed += 1
            print("  Failed to make {} ({}).".format(name, err))
        else:
            made += 1
            print("  Successfully made {}.".format(name))

    print("\n# Done.")
    print("  Made {}, skipped {}, removed {}, failed to make {}.".format(made, skipped,
                                                                         removed, failed))


if __name__ == "__main__":
    sys.exit(main())

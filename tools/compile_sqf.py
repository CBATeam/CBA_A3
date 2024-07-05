import os
import sys
import subprocess

# Handle script being called from either base or /tools folder (e.g. hemmt will run from base)
addon_base_path = os.getcwd()
if os.path.basename(addon_base_path) == "tools":
    addon_base_path = os.path.dirname(addon_base_path)


def cleanup():
    count = 0
    for root, _dirs, files in os.walk(os.path.join(addon_base_path, "addons")):
        for file in files:
            if file.endswith(".sqfc"):
                os.remove(os.path.join(root, file))
                count += 1
    print("cleaned [{} sqfc files]".format(count))


def build(verbose):
    compiler_exe = os.path.join(addon_base_path, "ArmaScriptCompiler.exe")
    if not os.path.isfile(compiler_exe):
        print("Warning: ArmaScriptCompiler.exe not found in base folder - skipping compiling")
        return
        # raise FileNotFoundError("ArmaScriptCompiler not found")
    ret = subprocess.call([compiler_exe], cwd=addon_base_path, stdout=verbose)
    print("compiled [ret {}]".format(ret))


def main(argv):
    # print("compile_sqf.py [Base: {}]".format(addon_base_path))
    if ("cleanup" in argv) or (len(argv) < 2):
        cleanup()
    if ("build" in argv) or (len(argv) < 2):
        build("verbose" in argv)


if __name__ == "__main__":
    sys.exit(main(sys.argv))

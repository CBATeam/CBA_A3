#!/usr/bin/env python3

"""PabstMirror

Checks that all strings are defined, run with -u to return all unused strings
"""

import fnmatch
import os
import re
import sys

def getDefinedStrings(filepath):
    """Return list of string names in a stringtable.xml file"""
    # print("getDefinedStrings {0}".format(filepath))
    with open(filepath, 'r', encoding="latin-1") as file:
        content = file.read()
        srch = re.compile(r'Key ID\=\"(STR_CBA_[_a-zA-Z0-9]*)"', re.IGNORECASE)
        modStrings = srch.findall(content)
    modStrings = [s.lower() for s in modStrings]
    return modStrings

def getStringUsage(filepath):
    """Return list of string names used in a file"""
    selfmodule = (re.search(r'addons[\W]*([_a-zA-Z0-9]*)', filepath)).group(1)
    # print("Checking {0} from {1}".format(filepath,selfmodule))
    fileStrings = []

    with open(filepath, 'r') as file:
        content = file.read()

        srch = re.compile(r'(STR_CBA_[_a-zA-Z0-9]*)', re.IGNORECASE)
        fileStrings = srch.findall(content)

        srch = re.compile(r'[^E][CL]STRING\(([_a-zA-Z0-9]*)\)', re.IGNORECASE)
        modStrings = srch.findall(content)
        for localString in modStrings:
            fileStrings.append("STR_CBA_{0}_{1}".format(selfmodule, localString))

        srch = re.compile(r'E[CL]STRING\(([_a-zA-Z0-9]*),([_a-zA-Z0-9]*)\)')
        exStrings = srch.findall(content)
        for (exModule, exString) in exStrings:
            fileStrings.append("STR_CBA_{0}_{1}".format(exModule, exString))

        srch = re.compile(r'IGNORE_STRING_WARNING\([\'"]*([_a-zA-Z0-9]*)[\'"]*\)')
        ignoreWarnings = srch.findall(content)

    fileStrings = [s.lower() for s in fileStrings]
    return [s for s in fileStrings if s not in (i.lower() for i in ignoreWarnings)]

def main(argv): # pylint: disable=missing-function-docstring,too-many-branches
    print("### check_strings.py {} ###".format(argv))
    sqfList = []
    xmlList = []

    allDefinedStrings = []
    allUsedStrings = []

    # Allow running from root directory as well as from inside the tools directory
    rootDir = "../addons"
    if os.path.exists("addons"):
        rootDir = "addons"

    for root, _, filenames in os.walk(rootDir):
        for filename in fnmatch.filter(filenames, '*.sqf'):
            sqfList.append(os.path.join(root, filename))
        for filename in fnmatch.filter(filenames, '*.cpp'):
            sqfList.append(os.path.join(root, filename))
        for filename in fnmatch.filter(filenames, '*.hpp'):
            if filename != "script_macros_common.hpp":
                sqfList.append(os.path.join(root, filename))
        for filename in fnmatch.filter(filenames, '*.h'):
            sqfList.append(os.path.join(root, filename))

        for filename in fnmatch.filter(filenames, '*.xml'):
            xmlList.append(os.path.join(root, filename))

    for filename in xmlList:
        allDefinedStrings.extend(getDefinedStrings(filename))
    for filename in sqfList:
        allUsedStrings.extend(getStringUsage(filename))

    allDefinedStrings = list(sorted(set(allDefinedStrings)))
    allUsedStrings = list(sorted(set(allUsedStrings)))

    print("-----------")
    countUnusedStrings = 0
    countUndefinedStrings = 0
    for string in allDefinedStrings:
        if not string in allUsedStrings:
            countUnusedStrings = countUnusedStrings + 1
            if "-u" in argv:
                print("String {} defined but not used".format(string))
    print("-----------")
    for string in allUsedStrings:
        if not string in allDefinedStrings:
            print("String {} not defined".format(string))
            countUndefinedStrings = countUndefinedStrings + 1
    print("-----------")

    print("Defined Strings:{0} Used Strings:{1}".format(len(allDefinedStrings),
                                                        len(allUsedStrings)))
    print("Unused Strings:{0} Undefined Strings:{1}".format(countUnusedStrings,
                                                            countUndefinedStrings))

    return countUndefinedStrings

if __name__ == "__main__":
    main(sys.argv)

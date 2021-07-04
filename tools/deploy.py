#!/usr/bin/env python3

"""
####################################
# CBA automatic deployment script  #
# ================================ #
# This is not meant to be run      #
# directly!                        #
####################################
"""

import os
import sys
import traceback
import subprocess as sp
try:
    from pygithub3 import Github
except ImportError:
    from github import Github

# https://github.com/CBATeam/CBA_A3/issues/754
TRANSLATIONISSUE = 754
TRANSLATIONBODY = "**[CBA Translation Guide]" \
    "(https://github.com/CBATeam/CBA_A3/wiki/Translation-Guide)**\n" \
    "\n{}"


REPOUSER = "CBATeam"
REPONAME = "CBA_A3"
REPOPATH = "{}/{}".format(REPOUSER, REPONAME)


def update_translations(token):
    """Update the CBA translation issue on GitHub"""
    diag = sp.check_output(["python3", "tools/stringtablediag.py", "--markdown"])
    diag = str(diag, "utf-8")
    repo = Github(token).get_repo(REPOPATH)
    issue = repo.get_issue(TRANSLATIONISSUE)
    issue.edit(body=TRANSLATIONBODY.format(diag))

def main(): # pylint: disable=missing-function-docstring
    print("Obtaining token ...")
    try:
        token = os.environ["GH_TOKEN"]
    except KeyError:
        print("Could not obtain token.")
        print(traceback.format_exc())
        return 1
    else:
        print("Token successfully obtained.")

    print("\nUpdating translation issue ...")
    try:
        update_translations(token)
    except Exception: # pylint: disable=broad-except
        print("Failed to update translation issue.")
        print(traceback.format_exc())
        return 1
    else:
        print("Translation issue successfully updated.")

    return 0


if __name__ == "__main__":
    sys.exit(main())

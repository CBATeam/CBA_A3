#!/usr/bin/env python

"""Config style validator"""

import argparse
import fnmatch
import os
import sys


if sys.version_info.major == 2:
    import codecs
    open = codecs.open # pylint: disable=invalid-name,redefined-builtin

def checkConfigStyle(filepath): # pylint: disable=too-many-branches,too-many-statements
    """Do a sanity check on a .cpp or .hpp config file

    In code that is not inside comments or string literals,

     * check for tabs
     * check for mismatched pairs of parentheses, brackets and braces (), [], {}

    Returns the number of possible syntax issues found
    """
    badCountFile = 0

    with open(filepath, 'r', encoding='utf-8', errors='ignore') as file:
        content = file.read()

        # Store all brackets we find in this file, so we can validate everything on the end
        bracketsList = []

        # To check if we are in a comment block
        isInCommentBlock = False
        checkIfInComment = False
        # Used in case we are in a line comment (//)
        ignoreTillEndOfLine = False
        # Used in case we are in a comment block (/* */).
        # This is true if we detect a * inside a comment block.
        # If the next character is a /, it means we end our comment block.
        checkIfNextIsClosingBlock = False

        # We ignore everything inside a string
        isInString = False
        # Used to store the starting type of a string, so we can match that to the end of a string
        inStringType = ''

        lastIsCurlyBrace = False

        # Extra information so we know what line we find errors at
        lineNumber = 1

        indexOfCharacter = 0
        # Parse all characters in the content of this file to search for potential errors
        for c in content:  # pylint: disable=invalid-name,too-many-nested-blocks
            if lastIsCurlyBrace:
                lastIsCurlyBrace = False
            if c == '\n': # Keeping track of our line numbers
                 # so we can print accurate line number information when
                 # we detect a possible error
                lineNumber += 1
            if isInString:
                 # while we are in a string, we can ignore everything else
                 # except the end of the string
                if c == inStringType:
                    isInString = False
            # if we are not in a comment block, we will check if we are at
            # the start of one or count the () {} and []
            elif not isInCommentBlock:

                # This means we have encountered a /, so we are now checking
                # if this is an inline comment or a comment block
                if checkIfInComment:
                    checkIfInComment = False
                     # if the next character after / is a *, we are
                     # at the start of a comment block
                    if c == '*':
                        isInCommentBlock = True
                    elif c == '/':
                        # Otherwise, will check if we are in a line comment
                        # and a line comment is a / followed by another / (//)
                        # We won't care about anything that comes after it
                        ignoreTillEndOfLine = True

                if not isInCommentBlock:
                    if ignoreTillEndOfLine:
                         # we are in a line comment, just continue going
                         # through the characters until we find an end of line
                        if c == '\n':
                            ignoreTillEndOfLine = False
                    else: # validate brackets
                        if c in ('"', "'"):
                            isInString = True
                            inStringType = c
                        elif c == '/':
                            checkIfInComment = True
                        elif c == '(':
                            bracketsList.append('(')
                        elif c == ')':
                            if (len(bracketsList) > 0 and bracketsList[-1] in ['{', '[']):
                                print("ERROR: Possible missing round bracket ')' detected"
                                      " at {0} Line number: {1}".format(filepath, lineNumber))
                                badCountFile += 1
                            bracketsList.append(')')
                        elif c == '[':
                            bracketsList.append('[')
                        elif c == ']':
                            if (len(bracketsList) > 0 and bracketsList[-1] in ['{', '(']):
                                print("ERROR: Possible missing square bracket ']' detected"
                                      " at {0} Line number: {1}".format(filepath, lineNumber))
                                badCountFile += 1
                            bracketsList.append(']')
                        elif c == '{':
                            bracketsList.append('{')
                        elif c == '}':
                            lastIsCurlyBrace = True
                            if (len(bracketsList) > 0 and bracketsList[-1] in ['(', '[']):
                                print("ERROR: Possible missing curly brace '}}' detected"
                                      " at {0} Line number: {1}".format(filepath, lineNumber))
                                badCountFile += 1
                            bracketsList.append('}')
                        elif c == '\t':
                            print("ERROR: Tab detected at {0} Line number: {1}".format(filepath,
                                                                                       lineNumber))
                            badCountFile += 1

            else: # Look for the end of our comment block
                if c == '*':
                    checkIfNextIsClosingBlock = True
                elif checkIfNextIsClosingBlock:
                    if c == '/':
                        isInCommentBlock = False
                    elif c != '*':
                        checkIfNextIsClosingBlock = False
            indexOfCharacter += 1

        if bracketsList.count('[') != bracketsList.count(']'):
            print("ERROR: A possible missing square bracket [ or ] in file {0}"
                  " [ = {1} ] = {2}".format(filepath, bracketsList.count('['),
                                            bracketsList.count(']')))
            badCountFile += 1
        if bracketsList.count('(') != bracketsList.count(')'):
            print("ERROR: A possible missing round bracket ( or ) in file {0}"
                  " ( = {1} ) = {2}".format(filepath, bracketsList.count('('),
                                            bracketsList.count(')')))
            badCountFile += 1
        if bracketsList.count('{') != bracketsList.count('}'):
            print("ERROR: A possible missing curly brace {{ or }} in file {0}"
                  " {{ = {1} }} = {2}".format(filepath, bracketsList.count('{'),
                                              bracketsList.count('}')))
            badCountFile += 1
    return badCountFile

def main(): # pylint: disable=missing-function-docstring
    print("Validating Config Style")

    sqfList = []
    badCount = 0

    parser = argparse.ArgumentParser()
    parser.add_argument('-m', '--module', help='only search specified module addon folder',
                        required=False, default="")
    args = parser.parse_args()

    # Allow running from root directory as well as from inside the tools directory
    rootDir = "../addons"
    if os.path.exists("addons"):
        rootDir = "addons"

    for root, _, filenames in os.walk(rootDir + '/' + args.module):
        for filename in fnmatch.filter(filenames, '*.cpp'):
            sqfList.append(os.path.join(root, filename))
        for filename in fnmatch.filter(filenames, '*.hpp'):
            sqfList.append(os.path.join(root, filename))

    for filename in sqfList:
        badCount = badCount + checkConfigStyle(filename)

    print("------\nChecked {0} files\nErrors detected: {1}".format(len(sqfList), badCount))
    if badCount == 0:
        print("Config validation PASSED")
    else:
        print("Config validation FAILED")

    return badCount

if __name__ == "__main__":
    sys.exit(main())

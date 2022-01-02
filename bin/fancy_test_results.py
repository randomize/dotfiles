#!/usr/bin/env python3

import xml.etree.ElementTree as etree
import sys;

tree = etree.parse(sys.argv[1])
root = tree.getroot()
els = tree.findall(".//test-case[@result='Failed']")
# els = tree.findall("./*/*/test-case[@result='Failed']")

def print_test_name(name):
    print("\t\033[91m"+name)

def print_blue_bg(text):
    print("\033[44m%s\033[0m" % text)

def print_reason(text):
    print("\t" + text)
    print("")

if len(els) == 0:
    print("\033[92mAll tests are passed.")
else:
    print("\033[91mThere are %s failed tests:\n" % len(els))
    for e in els:
        print_test_name(e.get('name'))
        reason = e.find("reason")
        if reason:
            print_blue_bg("Reason")
            message = reason.find("message")
            print_reason(message.text)

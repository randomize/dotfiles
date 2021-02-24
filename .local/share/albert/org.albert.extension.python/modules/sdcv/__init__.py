# -*- coding: utf-8 -*-

"""Show sdcv translation

Synopsis: <trigger> <word>"""

import subprocess as sp
from albert import *

__title__ = "Sdcv"
__version__ = "0.0.1"
__triggers__ = "sdc"
__authors__ = "Eugene Mihailenco"
__exec_deps__ = ["sdcv"]

iconPath = iconLookup("font")

def run(exp):
    return sp.getoutput('sdcv -n -u "LingvoUniversal (En-Ru)"  "%s"' % exp.replace('"', '\\"'))


def handleQuery(query):
    if query.isTriggered:
        item = Item(
            id=__title__,
            icon=iconPath
        )
        stripped = query.string.strip()

        if stripped == '':
            item.text = 'Enter a word to lookup'
        else:
            item.text = run(stripped)
            #item.subtext = run('echo gettype(%s);' % stripped)
            item.addAction(ClipAction('Copy result to clipboard', item.text))

        return item

#!/usr/bin/python2

#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Author: Mariano Simone (marianosimone@gmail.com)
# Version: 1.0
# Name: epub-thumbnailer
# Description: An implementation of a cover thumbnailer for epub files
# Installation: see README

import os
import re
from StringIO import StringIO
import sys
from xml.dom import minidom
import zipfile

# import Image
from PIL import Image


img_ext_regex = re.compile('^.*\.(jpg|jpeg|png)$', flags=re.IGNORECASE)
cover_regex = re.compile('.*cover.*\.(jpg|jpeg|png)', flags=re.IGNORECASE)

def get_cover_from_manifest(epub):

    # open the main container
    container = epub.open("META-INF/container.xml")
    container_root = minidom.parseString(container.read())

    # locate the rootfile
    elem = container_root.getElementsByTagName("rootfile")[0]
    rootfile_path = elem.getAttribute("full-path")

    # open the rootfile
    rootfile = epub.open(rootfile_path)
    rootfile_root = minidom.parseString(rootfile.read())

    # find the manifest element
    manifest = rootfile_root.getElementsByTagName("manifest")[0]
    for item in manifest.getElementsByTagName("item"):
        item_id = item.getAttribute("id")
        item_href = item.getAttribute("href")
        if "cover" in item_id and img_ext_regex.match(item_href.lower()):
            cover_path = os.path.join(os.path.dirname(rootfile_path),
                                      item_href)
            return cover_path

    return None

def get_cover_by_filename(epub):
    no_matching_images = []
    for fileinfo in epub.filelist:
        if cover_regex.match(fileinfo.filename):
            return fileinfo.filename
        if img_ext_regex.match(fileinfo.filename):
            no_matching_images.append(fileinfo)
    return _choose_best_image(no_matching_images)

def _choose_best_image(images):
    if images:
        return max(images, key=lambda f: f.file_size)
    return None

def extract_cover(cover_path):
    if cover_path:
        cover = epub.open(cover_path)
        im = Image.open(StringIO(cover.read()))
        im.thumbnail((size, size), Image.ANTIALIAS)
        if im.mode == "CMYK":
            im = im.convert("RGB")
        im.save(output_file, "PNG")
        return True
    return False

# Which file are we working with?
input_file = sys.argv[1]
# Where do does the file have to be saved?
output_file = sys.argv[2]
# Required size?
size = int(sys.argv[3])

# An epub is just a zip
epub = zipfile.ZipFile(input_file, "r")

extraction_strategies = [get_cover_from_manifest, get_cover_by_filename]

for strategy in extraction_strategies:
    try:
        cover_path = strategy(epub)
        if extract_cover(cover_path):
            exit(0)
    except Exception as ex:
        print "Error getting cover using %s: " % strategy.__name__, ex

exit(1)

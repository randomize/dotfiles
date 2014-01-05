#!/bin/bash

# Stop on errors
set -e

# Usefull idiom
# list | while read item; do echo $item

file_patt=$1


function main {
   for rev in `revisions`; do
      echo "`number_of_lines` `commit_description`"
   done
}

function commit_description {
   git log --oneline -1 $rev
}

function revisions {
   git rev-list --reverse HEAD
}

function number_of_lines {
   git ls-tree -r $rev | # list all file list in given rev
   grep "$file_patt" |   # Note it is quated, to avoid errors if no argument case
   awk '{print $3}' |    # cut third column with hash
   xargs git show |      # feed hashes to git show
   wc -l                 # then count lines
}

main

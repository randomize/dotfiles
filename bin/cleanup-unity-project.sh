#!/usr/bin/env bash

echo "=== RANDY CLEANUP STARTED ==="

echo "Step 0. File type histrogram..."
find . -type f | rev | cut -d . -f1 | rev | sort | uniq -ic | sort -rn

echo "Step 1. Remove BOM from *.cs files..."
find . -name *.cs -exec sed -i '1 s/^\xef\xbb\xbf//' {} +

echo "== DONE =="

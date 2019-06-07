#!/usr/bin/env bash
set -e

check_files_exist() {
  arr=("$@")
  rc=0
  for f in "${arr[@]}"; do
    test -f $f || rc=1
  done
  return $rc
}

FILES=(up.sh down.sh x.sh)
check_files_exist "${FILES[@]}"
echo "Result: $?"

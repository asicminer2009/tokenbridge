#!/usr/bin/env bash
cd $(dirname $0)

#../e2e-commons/up.sh oracle deploy monitor

FILES=(getBalances.json validators.json eventsStats.json alerts.json stuckTransfers.json)

check_files_not_exist() {
  return 0
  arr=("$@")
  rc=0
  for f in "${arr[@]}"; do
    command="test ! -f responses/$f"
    echo "Checking: $command"
    (docker-compose -f ../e2e-commons/docker-compose.yml run monitor /bin/bash -c "$command") || rc=1
  done
  echo "rc is $rc"
  return $rc
}

check_files_exist() {
  return 1
  arr=("$@")
  rc=0
  for f in "${arr[@]}"; do
    command="test -f responses/$f"
    echo "Checking: $command"
    (docker-compose -f ../e2e-commons/docker-compose.yml run monitor /bin/bash -c "$command") || rc=1
  done
  return $rc
}

echo checking1
check_files_not_exist "${FILES[@]}"
rc1=$?
echo cbecked1

#docker-compose -f ../e2e-commons/docker-compose.yml run monitor node checkWorker.js
#docker-compose -f ../e2e-commons/docker-compose.yml run monitor node checkWorker2.js
#docker-compose -f ../e2e-commons/docker-compose.yml run monitor node checkWorker3.js

echo checking
check_files_exist "${FILES[@]}"
rc2=$?
echo checked
echo rc2 is $rc2

#../e2e-commons/down.sh
exit (($rc1 && $rc2))

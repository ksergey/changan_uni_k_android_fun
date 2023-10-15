#!/bin/bash

set -e

function usage {
  echo "$(basename "$0") <название пакета>"
  echo "список всех установленных пакетов можно узнать с помощью скрипта adbList.sh"
}

password="adb36987"

packageName="$1"
if [ -z "${packageName}" ]; then
  usage
  exit 1
fi

# lets go
echo "${password}" \
  | adb shell monkey -p "${packageName}" -c android.intent.category.LAUNCHER 1

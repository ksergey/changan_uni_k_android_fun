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
  | adb shell pm uninstall "${packageName}"

# clear launcher cache
echo "${password}" \
  | adb shell pm clear com.iflytek.autofly.launcher

echo "Приложение удалено (${packageName})"
echo "Теперь нужно перезагрузить ГУ, что бы иконка приложение исчезла из лаунчера"

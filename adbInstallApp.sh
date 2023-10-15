#!/bin/bash

set -e

function usage {
  echo "$(basename "$0") <путь к APK>"
}

password="adb36987"
apkPath="/data/media/0/Download/"

localPath="$1"
if [ -z "${localPath}" ]; then
  usage
  exit 1
fi
if [ ! -f "${localPath}" ]; then
  echo "файл \"$localPath\" не найден"
  exit 1
fi

remotePath="${apkPath}/$(basename "${localPath}")"

# lets go
echo "${password}" \
  | adb push "${localPath}" "${remotePath}"

echo "${password}" \
  | adb shell pm install -t "${remotePath}"

echo "${password}" \
  | adb shell rm "${remotePath}"

# clear launcher cache
echo "${password}" \
  | adb shell pm clear com.iflytek.autofly.launcher

echo "Приложение установлено (${localPath})"
echo "Теперь нужно перезагрузить ГУ, что бы иконка приложения появилась в лаунчере"

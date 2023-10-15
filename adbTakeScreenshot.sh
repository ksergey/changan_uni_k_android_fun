#!/bin/bash

set -e

password="adb36987"
screenshotPath="/data/media/0/Download/"
ext="png"

name="$1"
if [ -z "${name}" ]; then
  name="screenshot"
fi

remoteName="${screenshotPath}/${name}.${ext}"
localName="$(pwd)/${name}.${ext}"

# lets go
echo "${password}" \
  | adb shell screencap -p "${remoteName}"

echo "${password}" \
  | adb pull "${remoteName}" "${localName}"

echo "${password}" \
  | adb shell rm "${remoteName}"

echo "screenshot path: ${localName}"

#!/bin/bash

set -e

password="adb36987"

name="$1"

if [ -z "${name}" ]; then
  echo "${password}" \
    | adb shell pm list packages 2>/dev/null | cut -b 9-
else
  echo "${password}" \
    | adb shell pm list packages 2>/dev/null | cut -b 9- | grep "${name}"
fi


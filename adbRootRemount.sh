#!/bin/bash

set -e

password="adb36987"

# lets go
echo "${password}" \
  | adb root

echo "${password}" \
  | adb remount

echo "Теперь можно выполнять другие скрипты"

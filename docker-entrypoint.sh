#!/bin/bash -e
# =====================================================================
# Build script running TFTP in Docker environment
#
# Source:
# Web:
#
# =====================================================================

START_DELAY=5

APP_ROOT_DIR=/home/networkInfo
APP_DEPENDECY000_DIR=/home/networkInfo/lib/nodeUtilz
USER_HOME=~/
SHELL_EXIT=exit

# Error codes
E_ILLEGAL_ARGS=126

# Help function used in error messages and -h option
usage() {
  echo ""
  echo "Docker entry script for API service container"
  echo ""
  echo "-f: Start API service in foreground with existing configuration."
  echo "-h: Show this help."

  echo "-s: Initialize environment like -i and start API in foreground." !!!!!
  echo ""
}


initConfig() {
  if [ ! "$(ls --ignore .keys --ignore .authoritative --ignore .recursive --ignore -A ${TFTP_USER_HOME})"  ]; then
    # sed -i "s/--secure/--secure --create/" ${TFTP_CONFIG}
    # touch ${TFTP_EDITED}
    echo "API configuration initializing........."
    git pull
    echo "API dependency initializing........."
    cd ${APP_DEPENDECY000_DIR}
    git pull
    cd ${APP_ROOT_DIR}
  else
    echo "API configuration already initialized........."
  fi
}

start() {
  sleep ${START_DELAY}
  node server.js
}

# Evaluate arguments for build script.
if [[ "${#}" == 0 ]]; then
  usage
  exit ${E_ILLEGAL_ARGS}
fi

# Evaluate arguments for build script.
while getopts fhis flag; do
  case ${flag} in
    f)
      start
      exit
      ;;
    h)
      usage
      exit
      ;;
    s)
      initConfig
      start
      exit
      ;;
    *)
      usage
      exit ${E_ILLEGAL_ARGS}
      ;;
  esac
done

# Strip of all remaining arguments
shift $((OPTIND - 1));

# Check if there are remaining arguments
if [[ "${#}" > 0 ]]; then
  echo "Error: To many arguments: ${*}."
  usage
  exit ${E_ILLEGAL_ARGS}
fi

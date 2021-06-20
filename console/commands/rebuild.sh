#!/usr/bin/env bash
set -euo pipefail

printf "${GREEN}Rebuilding and starting containers in detached mode${COLOR_RESET}\n"

if [ "$#" == 0 ]; then
    ${COMMANDS_DIR}/stop.sh
    ${DOCKER_COMPOSE} up --build -d
else
    ${COMMANDS_DIR}/stop.sh "$@"
    ${DOCKER_COMPOSE} up --build -d "$@"
fi

echo "Waiting for everything to spin up..."
sleep 5

if [[ "${MACHINE}" == "linux" ]]; then
    echo " > fixing permissions"
    ${TASKS_DIR}/fix_linux_permissions.sh
    echo " > permissions fix finished"
fi
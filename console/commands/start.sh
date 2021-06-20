#!/usr/bin/env bash
set -euo pipefail

printf "${GREEN}Starting containers in detached mode${COLOR_RESET}\n"

if [ "$#" == 0 ]; then
    ${DOCKER_COMPOSE} up -d
else
    ${DOCKER_COMPOSE} up -d "$@"
fi

echo "Waiting for everything to spin up..."
sleep 5

if [[ "${MACHINE}" == "linux" ]]; then
    echo " > fixing permissions"
    ${TASKS_DIR}/fix_linux_permissions.sh
    echo " > permissions fix finished"
fi
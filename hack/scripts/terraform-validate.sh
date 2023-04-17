#!/usr/bin/env bash

# set -euo pipefail
set -o pipefail

for module in $(ls modules); do
    pushd "modules/${module}"
    terraform init -upgrade
    terraform validate
    popd
done

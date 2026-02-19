#!/usr/bin/env bash
set -euo pipefail

#ID=$1
#QueueName=$2

ID="${1:?Usage: $0 <ID>}"
#QueueName="${2:?Usage: $0 <ID> <QueueName>}"

# source the shared preamble (use an absolute path or relative-to-script)
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/Preamble.sh"

# create study
qunex_container create_study \
  --bind="${BIND_PATH}" \
  --studyfolder="${STUDY_FOLDER}"

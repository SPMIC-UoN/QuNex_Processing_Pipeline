#!/usr/bin/env bash
set -euo pipefail

#ID=$1
#QueueName=$2

ID="${1:?Usage: $0 <ID>}"
#QueueName="${2:?Usage: $0 <ID> <QueueName>}"

# source the shared preamble (use an absolute path or relative-to-script)
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/Preamble.sh"

# create batch
qunex_container create_batch \
    --bind="${BIND_PATH}" \
    --sessionsfolder="${STUDY_FOLDER}/sessions" \
    --targetfile="${STUDY_FOLDER}/processing/batch.txt" \
    --paramfile="${BATCH_TEMPLATE}" \
    --sessions="${SESSIONS}" \
    --overwrite="append" \
  --container="${QUNEXCONIMAGE}"

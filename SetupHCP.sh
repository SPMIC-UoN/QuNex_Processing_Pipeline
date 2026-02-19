#!/usr/bin/env bash
set -euo pipefail

#ID=$1
#QueueName=$2

ID="${1:?Usage: $0 <ID>}"
#QueueName="${2:?Usage: $0 <ID> <QueueName>}"

# source the shared preamble (use an absolute path or relative-to-script)
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/Preamble.sh"

# setup hcp
qunex_container setup_hcp \
    --bind="${BIND_PATH}" \
    --sessionsfolder="${STUDY_FOLDER}/sessions" \
    --sessions="${SESSIONS}" \
    --existing="add" \
    --hcp_filename="standard" \
  --container="${QUNEXCONIMAGE}"

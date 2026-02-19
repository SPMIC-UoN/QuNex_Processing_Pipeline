#!/usr/bin/env bash
set -euo pipefail

#ID=$1
#QueueName=$2

ID="${1:?Usage: $0 <ID>}"
#QueueName="${2:?Usage: $0 <ID> <QueueName>}"

# source the shared preamble (use an absolute path or relative-to-script)
#SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_DIR="/share/HCP/QuNex_pipeline"
source "${SCRIPT_DIR}/Preamble.sh"

# import data
qunex_container import_hcp \
    --bind="${BIND_PATH}" \
    --sessionsfolder="${STUDY_FOLDER}/sessions" \
    --inbox="${RAW_DATA}" \
    --sessions="${SESSIONS}" \
    --action="copy" \
    --overwrite="no" \
    --archive="leave" \
    --nameformat="(?P<subject_id>[^/]+?)/unprocessed/(?P<session_name>.*?)/(?P<data>.*)" \
    --hcplsname="hcpya" \
  --container="${QUNEXCONIMAGE}"

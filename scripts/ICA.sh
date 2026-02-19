
#!/usr/bin/env bash
set -euo pipefail

#ID=$1
#QueueName=$2

#ID="${1:?Usage: $0 <ID> <QueueName>}"
#QueueName="${2:?Usage: $0 <ID> <QueueName>}"

ID="${1:?Usage: $0 ID QueueName}"
QueueName="${2:?QueueName required}"

# source the shared preamble (use an absolute path or relative-to-script)
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/Preamble.sh"

# Functional - ICA
qunex_container hcp_icafix \
    --bind="${BIND_PATH},${STUDY_FOLDER}:${STUDY_FOLDER},${HOME}/qunex_tmp:/tmp" \
    --sessionsfolder="${STUDY_FOLDER}/sessions" \
    --batchfile-="${STUDY_FOLDER}/processing/batch.txt" \
    --container="${QUNEXCONIMAGE}" \
    --sessions="${ID}" \
    --overwrite='no' \
    --bash_pre="module load qunex-img/0.99.2;module load cuda-img/10.0;unset TMPDIR;export TMPDIR=$HOME/quenx_tmp; echo \$TMPDIR" \
    --scheduler="SLURM,time=24:00:00,ntasks=1,cpus-per-task=1,mem-per-cpu=50000,partition=${QueueName},qos=img,jobname=ICA_FIX_${ID}"

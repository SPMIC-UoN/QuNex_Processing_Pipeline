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

# HCP - MSMALL
qunex_container hcp_msmall \
    --bind="${BIND_PATH},${STUDY_FOLDER}:${STUDY_FOLDER},${HOME}/qunex_tmp:/tmp,${HOME}/qunex_tmp:/tmp" \
    --sessionsfolder="${STUDY_FOLDER}/sessions" \
    --batchfile-="${STUDY_FOLDER}/processing/batch.txt" \
    --container="${QUNEXCONIMAGE}" \
    --sessions="${SESSIONS}" \
    --overwrite='yes' \
    --hcp_msmall_bolds=$BOLD \
    --bash_pre="module load qunex-img/0.99.2;module load cuda-img/10.0;module load matlab-uon/r2024a;unset TMPDIR;export TMPDIR=$HOME/quenx_tmp; echo \$TMPDIR" \
    --scheduler="SLURM,time=24:00:00,ntasks=1,cpus-per-task=1,mem-per-cpu=50000,partition=${QueueName},qos=img,jobname=hcp_msmall${ID}"
~

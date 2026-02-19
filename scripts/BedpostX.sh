#!/usr/bin/env bash
set -euo pipefail

#ID=$1
#QueueName=$2

#ID="${1:?Usage: $0 <ID> <QueueName> <Model>}"
#QueueName="${2:?Usage: $0 <ID> <QueueName>  <Model>}"
#Model="${3:?Usage: $0 <ID> <QueueName> <Model>}"

ID="${1:?Usage: $0 ID QueueName Model}"
QueueName="${2:?QueueName required}"
Model="${3:?Model required}"

# source the shared preamble (use an absolute path or relative-to-script)
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/Preamble.sh"

# Diffusion - Bedpostx
qunex_container dwi_bedpostx_gpu \
      --bind="${BIND_PATH}" \
      --sessionsfolder="${STUDY_FOLDER}/sessions" \
      --batchfile="${STUDY_FOLDER}/processing/batch.txt" \
      --fibers="3" \
      --burnin="1000" \
      --model="${Model}" \
      --container="${QUNEXCONIMAGE}" \
      --overwrite="yes" \
      --nv \
      --bash_pre="module load singularity;module load extension/imaging;module load qunex-img/0.99.2;module load cuda-img/10.0" \
      --scheduler="SLURM,time=24:00:00,ntasks=1,cpus-per-task=1,mem-per-cpu=50000,partition=${QueueName},qos=img,gres=gpu:1,jobname=qc-bedpostx_${ID}"

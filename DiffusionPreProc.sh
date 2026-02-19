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

# Diffusion - Preprocessing
qunex_container hcp_diffusion \
      --bind="${BIND_PATH}" \
      --sessionsfolder="${STUDY_FOLDER}/sessions" \
      --batchfile="${STUDY_FOLDER}/processing/batch.txt" \
      --container="${QUNEXCONIMAGE}" \
      --nv \
      --overwrite="no" \
      --bash_pre="module load qunex-img/0.99.2;module load cuda-img/10.0" \
      --hcp_dwi_extraeddyarg="--niter=8|--fwhm=10,8,6,4,2,0,0,0|--nvoxhp=2000|--repol|--ol_type=both|--ol_nstd=5|--with_outliers|--mporder=16|--s2v_niter=8|--json=${STUDY_FOLDER}/sessions/${SESSIONS}/hcpls/Diffusion/${ID}_V1_MR_dMRI_dir98_PA.json|--estimate_move_by_susceptibility|--mbs_niter=20|--residuals|--initrand|--very_verbose" \
    --scheduler="SLURM,time=24:00:00,ntasks=1,cpus-per-task=1,mem-per-cpu=50000,partition=${QueueName},qos=img,gres=gpu:1,jobname=qc-diffusion_${ID}"


#!/usr/bin/env bash
set -euo pipefail

# Required for ALL scripts
: "${ID:?ID is required}"

# Optional variables (may or may not exist)
QueueName="${QueueName:-}"
Model="${Model:-}"

module load qunex-img/0.99.2
module load singularity
module load extension/imaging
module load cuda-img/10.0
module load hcp-pipelines-img
module load fsl-img/6.0.6.3
module load workbench-img/1.5.0

STUDY_FOLDER="/share/HCP/HCPD/output/${ID}_V1_MR"
RAW_DATA="/share/HCP/HCPD/data/${ID}_V1"
BATCH_TEMPLATE="/share/HCP/HCPD/hcp_batch.txt"
SESSIONS="${ID}_V1_MR"

comlogs="${STUDY_FOLDER}/processing/logs/comlogs"

#bind_path="/imgshare:/imgshare,/share/HCP/HCPD:/share/HCP/HCPD,/share/ndadata:/share/ndadata"

BIND_PATHS=(
  "/imgshare:/imgshare"
  "/share/HCP/HCPD:/share/HCP/HCPD"
  "/share/ndadata:/share/ndadata"
)

BIND_PATH="$(IFS=,; echo "${BIND_PATHS[*]}")"


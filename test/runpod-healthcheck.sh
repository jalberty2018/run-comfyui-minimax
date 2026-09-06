#!/usr/bin/env bash
set -uo pipefail

# ==============================================================================
# RunPod Lightweight Pod Health Check
#
# Exit codes:
#   0 = PASS
#   1 = WARNING
#   2 = REJECT
#
# Extra dependencies:
#
#   apt-get update
#   apt-get install -y fio ioping
#
# Optional ENV overrides:
#
#   HEALTH_MIN_WRITE_MBPS=300
#   HEALTH_MIN_READ_MBPS=300
#   HEALTH_WARN_WRITE_MBPS=500
#   HEALTH_WARN_READ_MBPS=500
#
#   HEALTH_COPY_SOURCE=/ComfyUI
#   HEALTH_COPY_ENABLED=1
#
# ==============================================================================


# ==============================================================================
# Configuration
# ==============================================================================

HEALTH_TEST_DIR="${HEALTH_TEST_DIR:-/workspace}"


# ------------------------------------------------------------------------------
# RAM
# ------------------------------------------------------------------------------

HEALTH_MIN_RAM_AVAILABLE_GB="${HEALTH_MIN_RAM_AVAILABLE_GB:-32}"
HEALTH_MIN_RAM_AVAILABLE_PERCENT="${HEALTH_MIN_RAM_AVAILABLE_PERCENT:-25}"


# ------------------------------------------------------------------------------
# CPU load
#
# Normalized load:
#
#   load average / logical CPUs
#
# Examples:
#
#   0.25 = low
#   1.00 = CPUs approximately fully loaded
#   2.00 = twice as much runnable work as CPUs
# ------------------------------------------------------------------------------

HEALTH_MAX_LOAD_PER_CPU_WARN="${HEALTH_MAX_LOAD_PER_CPU_WARN:-1.0}"
HEALTH_MAX_LOAD_PER_CPU_REJECT="${HEALTH_MAX_LOAD_PER_CPU_REJECT:-2.0}"


# ------------------------------------------------------------------------------
# fio sequential storage test
# ------------------------------------------------------------------------------

HEALTH_FIO_ENABLED="${HEALTH_FIO_ENABLED:-1}"

HEALTH_FIO_SIZE_MB="${HEALTH_FIO_SIZE_MB:-512}"
HEALTH_FIO_RUNTIME="${HEALTH_FIO_RUNTIME:-5}"
HEALTH_FIO_BS="${HEALTH_FIO_BS:-1M}"

# QD1 is intentional.
# It avoids misleading queue-depth results and is representative for many
# model/file loading operations.
HEALTH_FIO_IODEPTH="${HEALTH_FIO_IODEPTH:-1}"


# Reject below these values
HEALTH_MIN_READ_MBPS="${HEALTH_MIN_READ_MBPS:-300}"
HEALTH_MIN_WRITE_MBPS="${HEALTH_MIN_WRITE_MBPS:-300}"


# Warning below these preferred values
HEALTH_WARN_READ_MBPS="${HEALTH_WARN_READ_MBPS:-500}"
HEALTH_WARN_WRITE_MBPS="${HEALTH_WARN_WRITE_MBPS:-500}"


# ------------------------------------------------------------------------------
# ioping storage latency
# ------------------------------------------------------------------------------

HEALTH_IOPING_ENABLED="${HEALTH_IOPING_ENABLED:-1}"
HEALTH_IOPING_COUNT="${HEALTH_IOPING_COUNT:-10}"


# milliseconds
HEALTH_MAX_IOPING_AVG_MS_WARN="${HEALTH_MAX_IOPING_AVG_MS_WARN:-10}"
HEALTH_MAX_IOPING_AVG_MS_REJECT="${HEALTH_MAX_IOPING_AVG_MS_REJECT:-30}"


# ------------------------------------------------------------------------------
# Optional real-world ComfyUI copy test
#
# In your RunPod setup /ComfyUI is moved to /workspace/ComfyUI during start.sh.
# Therefore /ComfyUI may legitimately be empty by the time this script runs.
#
# An empty/missing source is therefore INFO, not WARNING.
# ------------------------------------------------------------------------------

HEALTH_COPY_ENABLED="${HEALTH_COPY_ENABLED:-1}"

HEALTH_COPY_SOURCE="${HEALTH_COPY_SOURCE:-/ComfyUI}"

HEALTH_COPY_DEST="${HEALTH_COPY_DEST:-${HEALTH_TEST_DIR}/.healthcheck-comfyui-copy}"


# Warning / reject based on total copy time
HEALTH_COPY_WARN_SECONDS="${HEALTH_COPY_WARN_SECONDS:-15}"
HEALTH_MAX_COPY_SECONDS="${HEALTH_MAX_COPY_SECONDS:-30}"


# Hard timeout
HEALTH_COPY_TIMEOUT="${HEALTH_COPY_TIMEOUT:-120}"


# Remove copy afterwards
HEALTH_COPY_CLEANUP="${HEALTH_COPY_CLEANUP:-1}"


# ==============================================================================
# Colours
# ==============================================================================

if [[ -t 1 ]]; then
    C_RED=$'\033[31m'
    C_YELLOW=$'\033[33m'
    C_GREEN=$'\033[32m'
    C_CYAN=$'\033[36m'
    C_BOLD=$'\033[1m'
    C_RESET=$'\033[0m'
else
    C_RED=""
    C_YELLOW=""
    C_GREEN=""
    C_CYAN=""
    C_BOLD=""
    C_RESET=""
fi


# ==============================================================================
# Status
# ==============================================================================

OVERALL_STATUS=0


pass() {
    printf "%s[PASS]%s %s\n" "$C_GREEN" "$C_RESET" "$*"
}


warn() {
    printf "%s[WARN]%s %s\n" "$C_YELLOW" "$C_RESET" "$*"

    if (( OVERALL_STATUS < 1 )); then
        OVERALL_STATUS=1
    fi
}


reject() {
    printf "%s[REJECT]%s %s\n" "$C_RED" "$C_RESET" "$*"
    OVERALL_STATUS=2
}


info() {
    printf "%s[INFO]%s %s\n" "$C_CYAN" "$C_RESET" "$*"
}


have_cmd() {
    command -v "$1" >/dev/null 2>&1
}


float_lt() {
    awk -v a="$1" -v b="$2" 'BEGIN { exit !(a < b) }'
}


float_gt() {
    awk -v a="$1" -v b="$2" 'BEGIN { exit !(a > b) }'
}


# ==============================================================================
# Header
# ==============================================================================

echo
echo "${C_BOLD}==============================================================${C_RESET}"
echo "${C_BOLD} RunPod Pod Health Check${C_RESET}"
echo "${C_BOLD}==============================================================${C_RESET}"
echo

info "Test directory: $HEALTH_TEST_DIR"

if [[ ! -d "$HEALTH_TEST_DIR" ]]; then
    reject "Test directory does not exist: $HEALTH_TEST_DIR"
    exit 2
fi


# ==============================================================================
# GPU
# ==============================================================================

echo
echo "${C_BOLD}--- GPU -------------------------------------------------------${C_RESET}"

if have_cmd nvidia-smi; then

    GPU_INFO="$(
        nvidia-smi \
            --query-gpu=name,memory.total,memory.free,temperature.gpu,pstate,pci.bus_id \
            --format=csv,noheader,nounits \
            2>/dev/null || true
    )"

    if [[ -n "$GPU_INFO" ]]; then

        while IFS= read -r line; do
            info "$line"
        done <<< "$GPU_INFO"

        pass "NVIDIA GPU detected"

    else

        warn "nvidia-smi exists but GPU information could not be read"

    fi

else

    warn "nvidia-smi not found"

fi


# ==============================================================================
# Memory
# ==============================================================================

echo
echo "${C_BOLD}--- Memory ----------------------------------------------------${C_RESET}"

MEM_TOTAL_KB="$(awk '/MemTotal:/ {print $2}' /proc/meminfo)"
MEM_AVAILABLE_KB="$(awk '/MemAvailable:/ {print $2}' /proc/meminfo)"


MEM_TOTAL_GB="$(
    awk \
        -v kb="$MEM_TOTAL_KB" \
        'BEGIN {printf "%.1f", kb/1024/1024}'
)"


MEM_AVAILABLE_GB="$(
    awk \
        -v kb="$MEM_AVAILABLE_KB" \
        'BEGIN {printf "%.1f", kb/1024/1024}'
)"


MEM_AVAILABLE_PERCENT="$(
    awk \
        -v available="$MEM_AVAILABLE_KB" \
        -v total="$MEM_TOTAL_KB" \
        'BEGIN {printf "%.1f", (available/total)*100}'
)"


info "RAM total:     ${MEM_TOTAL_GB} GB"
info "RAM available: ${MEM_AVAILABLE_GB} GB (${MEM_AVAILABLE_PERCENT}%)"


if float_lt "$MEM_AVAILABLE_GB" "$HEALTH_MIN_RAM_AVAILABLE_GB"; then

    reject "Available RAM below ${HEALTH_MIN_RAM_AVAILABLE_GB} GB"

elif float_lt "$MEM_AVAILABLE_PERCENT" "$HEALTH_MIN_RAM_AVAILABLE_PERCENT"; then

    warn "Available RAM below ${HEALTH_MIN_RAM_AVAILABLE_PERCENT}%"

else

    pass "RAM availability is healthy"

fi


# ==============================================================================
# CPU / Load
# ==============================================================================

echo
echo "${C_BOLD}--- CPU / load ------------------------------------------------${C_RESET}"

CPU_COUNT="$(nproc)"
LOAD1="$(awk '{print $1}' /proc/loadavg)"


LOAD_PER_CPU="$(
    awk \
        -v load="$LOAD1" \
        -v cpus="$CPU_COUNT" \
        'BEGIN {printf "%.2f", load/cpus}'
)"


info "Logical CPUs: $CPU_COUNT"
info "Load average 1 min: $LOAD1"
info "Normalized load/core: $LOAD_PER_CPU"


if float_gt "$LOAD_PER_CPU" "$HEALTH_MAX_LOAD_PER_CPU_REJECT"; then

    reject "System load is extremely high"

elif float_gt "$LOAD_PER_CPU" "$HEALTH_MAX_LOAD_PER_CPU_WARN"; then

    warn "System load is elevated"

else

    pass "CPU load is healthy"

fi


# ==============================================================================
# Filesystem information
# ==============================================================================

echo
echo "${C_BOLD}--- Filesystem ------------------------------------------------${C_RESET}"

df -h "$HEALTH_TEST_DIR"


if have_cmd findmnt; then
    findmnt -T "$HEALTH_TEST_DIR" 2>/dev/null || true
fi


# ==============================================================================
# Storage latency - ioping
# ==============================================================================

echo
echo "${C_BOLD}--- Storage latency -------------------------------------------${C_RESET}"


if [[ "$HEALTH_IOPING_ENABLED" == "1" ]]; then

    if have_cmd ioping; then

        IOPING_OUTPUT="$(
            ioping \
                -c "$HEALTH_IOPING_COUNT" \
                -q \
                "$HEALTH_TEST_DIR" \
                2>/dev/null || true
        )"


        if [[ -n "$IOPING_OUTPUT" ]]; then

            echo "$IOPING_OUTPUT"


            AVG_RAW="$(
                echo "$IOPING_OUTPUT" |
                awk -F'= ' '
                    /min\/avg\/max/ {
                        split($2,a," / ");
                        print a[2]
                    }
                '
            )"


            if [[ -n "$AVG_RAW" ]]; then

                AVG_VALUE="$(echo "$AVG_RAW" | awk '{print $1}')"
                AVG_UNIT="$(echo "$AVG_RAW" | awk '{print $2}')"


                case "$AVG_UNIT" in

                    us)
                        AVG_MS="$(
                            awk \
                                -v x="$AVG_VALUE" \
                                'BEGIN {printf "%.3f", x/1000}'
                        )"
                        ;;

                    ms)
                        AVG_MS="$AVG_VALUE"
                        ;;

                    s)
                        AVG_MS="$(
                            awk \
                                -v x="$AVG_VALUE" \
                                'BEGIN {printf "%.3f", x*1000}'
                        )"
                        ;;

                    *)
                        AVG_MS=""
                        ;;

                esac


                if [[ -n "$AVG_MS" ]]; then

                    info "Average storage latency: ${AVG_MS} ms"


                    if float_gt "$AVG_MS" "$HEALTH_MAX_IOPING_AVG_MS_REJECT"; then

                        reject "Storage latency exceeds ${HEALTH_MAX_IOPING_AVG_MS_REJECT} ms"

                    elif float_gt "$AVG_MS" "$HEALTH_MAX_IOPING_AVG_MS_WARN"; then

                        warn "Storage latency exceeds ${HEALTH_MAX_IOPING_AVG_MS_WARN} ms"

                    else

                        pass "Storage latency is healthy"

                    fi

                else

                    warn "Could not parse ioping latency"

                fi

            else

                warn "Could not parse ioping result"

            fi

        else

            warn "ioping returned no usable result"

        fi

    else

        warn "ioping not installed"

    fi

else

    info "ioping test disabled"

fi


# ==============================================================================
# fio throughput
# ==============================================================================

echo
echo "${C_BOLD}--- fio storage throughput ------------------------------------${C_RESET}"


FIO_FILE="${HEALTH_TEST_DIR}/.runpod-healthcheck-fio.bin"


cleanup_fio() {
    rm -f "$FIO_FILE" >/dev/null 2>&1 || true
}


trap cleanup_fio EXIT


if [[ "$HEALTH_FIO_ENABLED" == "1" ]]; then

    if have_cmd fio; then

        cleanup_fio


        # ======================================================================
        # WRITE TEST
        # ======================================================================

        info "Running ${HEALTH_FIO_RUNTIME}s write test (${HEALTH_FIO_SIZE_MB} MB file)..."


        WRITE_JSON="$(
            fio \
                --name=health-write \
                --filename="$FIO_FILE" \
                --size="${HEALTH_FIO_SIZE_MB}M" \
                --rw=write \
                --bs="$HEALTH_FIO_BS" \
                --direct=1 \
                --iodepth="$HEALTH_FIO_IODEPTH" \
                --time_based \
                --runtime="$HEALTH_FIO_RUNTIME" \
                --output-format=json \
                2>/dev/null || true
        )"


        if [[ -n "$WRITE_JSON" ]]; then

            WRITE_MBPS="$(
                printf '%s\n' "$WRITE_JSON" |
                awk '
                    /"write"[[:space:]]*:/ {
                        in_write=1
                    }

                    in_write && /"bw_bytes"[[:space:]]*:/ {
                        line=$0
                        sub(/^.*:[[:space:]]*/, "", line)
                        gsub(/[,[:space:]]/, "", line)

                        printf "%.1f", line / 1024 / 1024
                        exit
                    }
                '
            )"


            if [[ -n "$WRITE_MBPS" ]]; then

                info "Sequential write: ${WRITE_MBPS} MiB/s"


                if float_lt "$WRITE_MBPS" "$HEALTH_MIN_WRITE_MBPS"; then

                    reject "Write throughput below ${HEALTH_MIN_WRITE_MBPS} MiB/s"

                elif float_lt "$WRITE_MBPS" "$HEALTH_WARN_WRITE_MBPS"; then

                    warn "Write throughput below preferred ${HEALTH_WARN_WRITE_MBPS} MiB/s"

                else

                    pass "Write throughput is healthy"

                fi

            else

                warn "Could not parse fio write result"

            fi

        else

            warn "fio write test failed"

        fi


        # ======================================================================
        # READ TEST
        # ======================================================================

        if [[ -f "$FIO_FILE" ]]; then

            sync

            info "Running ${HEALTH_FIO_RUNTIME}s read test..."


            READ_JSON="$(
                fio \
                    --name=health-read \
                    --filename="$FIO_FILE" \
                    --size="${HEALTH_FIO_SIZE_MB}M" \
                    --rw=read \
                    --bs="$HEALTH_FIO_BS" \
                    --direct=1 \
                    --iodepth="$HEALTH_FIO_IODEPTH" \
                    --time_based \
                    --runtime="$HEALTH_FIO_RUNTIME" \
                    --output-format=json \
                    2>/dev/null || true
            )"


            if [[ -n "$READ_JSON" ]]; then

                READ_MBPS="$(
                    printf '%s\n' "$READ_JSON" |
                    awk '
                        /"read"[[:space:]]*:/ {
                            in_read=1
                        }

                        in_read && /"bw_bytes"[[:space:]]*:/ {
                            line=$0
                            sub(/^.*:[[:space:]]*/, "", line)
                            gsub(/[,[:space:]]/, "", line)

                            printf "%.1f", line / 1024 / 1024
                            exit
                        }
                    '
                )"


                if [[ -n "$READ_MBPS" ]]; then

                    info "Sequential read: ${READ_MBPS} MiB/s"


                    if float_lt "$READ_MBPS" "$HEALTH_MIN_READ_MBPS"; then

                        reject "Read throughput below ${HEALTH_MIN_READ_MBPS} MiB/s"

                    elif float_lt "$READ_MBPS" "$HEALTH_WARN_READ_MBPS"; then

                        warn "Read throughput below preferred ${HEALTH_WARN_READ_MBPS} MiB/s"

                    else

                        pass "Read throughput is healthy"

                    fi

                else

                    warn "Could not parse fio read result"

                fi

            else

                warn "fio read test failed"

            fi

        fi


        cleanup_fio

    else

        warn "fio not installed"

    fi

else

    info "fio test disabled"

fi


# ==============================================================================
# Optional real-world ComfyUI copy test
# ==============================================================================

echo
echo "${C_BOLD}--- Real-world copy test --------------------------------------${C_RESET}"


if [[ "$HEALTH_COPY_ENABLED" == "1" ]]; then

    if [[ -d "$HEALTH_COPY_SOURCE" ]]; then


        SOURCE_SIZE_BYTES="$(
            du -sb "$HEALTH_COPY_SOURCE" 2>/dev/null |
            awk '{print $1}'
        )"


        SOURCE_SIZE_HUMAN="$(
            du -sh "$HEALTH_COPY_SOURCE" 2>/dev/null |
            awk '{print $1}'
        )"


        info "Source: $HEALTH_COPY_SOURCE"
        info "Size:   ${SOURCE_SIZE_HUMAN:-unknown}"
        info "Dest:   $HEALTH_COPY_DEST"


        # ----------------------------------------------------------------------
        # An empty /ComfyUI is normal after your start.sh has already moved it
        # to /workspace/ComfyUI.
        #
        # Therefore this is informational only.
        # ----------------------------------------------------------------------

        if [[ -z "${SOURCE_SIZE_BYTES:-}" || "$SOURCE_SIZE_BYTES" -lt 1048576 ]]; then

            info "Copy source is empty or smaller than 1 MB."
            info "This is normal if ComfyUI was already moved to /workspace/ComfyUI."
            info "Skipping real-world copy benchmark."


        else

            rm -rf "$HEALTH_COPY_DEST" >/dev/null 2>&1 || true


            START_NS="$(date +%s%N)"

            COPY_OK=1


            if have_cmd timeout; then

                timeout \
                    "$HEALTH_COPY_TIMEOUT" \
                    cp -a \
                    "$HEALTH_COPY_SOURCE" \
                    "$HEALTH_COPY_DEST" \
                    >/dev/null 2>&1 \
                    || COPY_OK=0

            else

                cp -a \
                    "$HEALTH_COPY_SOURCE" \
                    "$HEALTH_COPY_DEST" \
                    >/dev/null 2>&1 \
                    || COPY_OK=0

            fi


            END_NS="$(date +%s%N)"


            COPY_SECONDS="$(
                awk \
                    -v start="$START_NS" \
                    -v end="$END_NS" \
                    'BEGIN {
                        printf "%.2f", (end-start)/1000000000
                    }'
            )"


            COPY_MBPS="$(
                awk \
                    -v bytes="$SOURCE_SIZE_BYTES" \
                    -v seconds="$COPY_SECONDS" \
                    'BEGIN {
                        if (seconds > 0)
                            printf "%.1f", (bytes/1024/1024)/seconds
                        else
                            printf "0"
                    }'
            )"


            info "Copy time:       ${COPY_SECONDS} seconds"
            info "Effective speed: ${COPY_MBPS} MiB/s"


            if [[ "$COPY_OK" != "1" ]]; then

                reject "Copy failed or exceeded ${HEALTH_COPY_TIMEOUT}s timeout"

            elif float_gt "$COPY_SECONDS" "$HEALTH_MAX_COPY_SECONDS"; then

                reject "Copy exceeds ${HEALTH_MAX_COPY_SECONDS}s reject threshold"

            elif float_gt "$COPY_SECONDS" "$HEALTH_COPY_WARN_SECONDS"; then

                warn "Copy exceeds ${HEALTH_COPY_WARN_SECONDS}s warning threshold"

            else

                pass "Real-world copy performance is healthy"

            fi


            if [[ "$HEALTH_COPY_CLEANUP" == "1" ]]; then

                rm -rf "$HEALTH_COPY_DEST" >/dev/null 2>&1 || true

            fi

        fi


    else

        info "Copy source does not exist: $HEALTH_COPY_SOURCE"
        info "Skipping real-world copy benchmark."

    fi


else

    info "Copy test disabled"

fi


# ==============================================================================
# Final result
# ==============================================================================

echo
echo "${C_BOLD}==============================================================${C_RESET}"


case "$OVERALL_STATUS" in

    0)

        echo "${C_GREEN}${C_BOLD} POD HEALTH: GOOD / PASS${C_RESET}"
        echo
        echo "This node looks suitable for the workload."
        ;;


    1)

        echo "${C_YELLOW}${C_BOLD} POD HEALTH: WARNING${C_RESET}"
        echo
        echo "The node is usable, but one or more metrics are below the preferred level."
        ;;


    *)

        echo "${C_RED}${C_BOLD} POD HEALTH: REJECT${C_RESET}"
        echo
        echo "This node is likely unsuitable for storage/model-heavy ComfyUI workloads."
        ;;

esac


echo "${C_BOLD}==============================================================${C_RESET}"
echo


exit "$OVERALL_STATUS"
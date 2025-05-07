# WARNING: This file is managed by chezmoi.

FILENAME=$(basename ${BASH_SOURCE[1]-${BASH_SOURCE[0]}})
LEVEL=${LOGLEVEL:-20}
DEBUG=10
INFO=20
WARNING=30
ERROR=40
JSON=${JSONLOGGING:-0}

export COLOR_NC=''
export COLOR_BLACK=''
export COLOR_GRAY=''
export COLOR_RED=''
export COLOR_LIGHT_RED=''
export COLOR_GREEN=''
export COLOR_LIGHT_GREEN=''
export COLOR_BROWN=''
export COLOR_YELLOW=''
export COLOR_BLUE=''
export COLOR_LIGHT_BLUE=''
export COLOR_PURPLE=''
export COLOR_LIGHT_PURPLE=''
export COLOR_CYAN=''
export COLOR_LIGHT_CYAN=''
export COLOR_LIGHT_GRAY=''
export COLOR_WHITE=''

if dircolors > /dev/null 2>&1; then
    export COLOR_NC='\e[0m' # No Color
    export COLOR_BLACK='\e[0;30m'
    export COLOR_GRAY='\e[1;30m'
    export COLOR_RED='\e[0;31m'
    export COLOR_LIGHT_RED='\e[1;31m'
    export COLOR_GREEN='\e[0;32m'
    export COLOR_LIGHT_GREEN='\e[1;32m'
    export COLOR_BROWN='\e[0;33m'
    export COLOR_YELLOW='\e[1;33m'
    export COLOR_BLUE='\e[0;34m'
    export COLOR_LIGHT_BLUE='\e[1;34m'
    export COLOR_PURPLE='\e[0;35m'
    export COLOR_LIGHT_PURPLE='\e[1;35m'
    export COLOR_CYAN='\e[0;36m'
    export COLOR_LIGHT_CYAN='\e[1;36m'
    export COLOR_LIGHT_GRAY='\e[0;37m'
    export COLOR_WHITE='\e[1;37m'
fi

function get_color() {
    local level=$1
    local color="${COLOR_NC}"
    case "${level}" in
        "INFO")
            color="${COLOR_CYAN}"
            ;;
        "WARNING")
            color="${COLOR_YELLOW}"
            ;;
        "ERROR")
            color="${COLOR_RED}"
            ;;
        *)
            color="${COLOR_NC}"
    esac
    echo "${color}"
}

function get_levelno() {
    local level=$1
    local levelno=${INFO}

    shopt -s nocasematch
    case "${level}" in
        debug)
            levelno=${DEBUG}
            ;;
        info)
            levelno=${INFO}
            ;;
        warning)
            levelno=${WARNING}
            ;;
        error)
            levelno=${ERROR}
            ;;
        *)
            levelno=${INFO}
    esac
    echo $levelno
}

function log() {
    local level=$1; shift
    local description="$*"

    if [[ $JSON -eq 1 ]]; then
        local levelno=$(get_levelno "$\{level}")
        printf "{\"time\": \"%(%Y-%m-%d %H:%M:%S %Z)T\", \"level\": \"${level}\", \"levelno\": ${levelno}, \"filename\": \"${FILENAME}\", \"lineno\": ${BASH_LINENO[1]}, \"description\": \"${description}\"}\n"
    else
        local color=$(get_color "${level}")
        printf "%(%Y-%m-%d %H:%M:%S %Z)T [${color} ${level} ${COLOR_NC}] ${FILENAME}:${BASH_LINENO[1]} $*\n"
    fi
}

function log.debug() {
    if [[ $LEVEL -le $DEBUG ]]; then
        log "DEBUG" $*
    fi
}

function log.info() {
    if [[ $LEVEL -le $INFO ]]; then
        log "INFO" $*
    fi
}

function log.warning() {
    if [[ $LEVEL -le $WARNING ]]; then
        log "WARNING" $*
    fi
}

function log.error() {
    if [[ $LEVEL -le $ERROR ]]; then
        log "ERROR" $*
    fi
}

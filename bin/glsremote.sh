#!/bin/bash
set -o pipefail # fallo estricto de cadena ( | )

# Detect OS
OS_TYPE=$(uname -s)
if [[ "${OS_TYPE}" == *"MINGW"* || "${OS_TYPE}" == *"MSYS"* ]]; then
    # set route for Windows (Git Bash) of our library reusable gkey-core.sh
    LIB_PATH="$HOME/.gkey/lib/gkey-core.sh"
else
    # set route for Linux / macOS of our library reusable gkey-core.sh
    LIB_PATH="/usr/local/lib/gkey/gkey-core.sh"
fi

if [ -f "$LIB_PATH" ]; then
    # inyection our code of gkey-core.sh in this file
    source "$LIB_PATH"
else
    echo "❌ Error: Could not find gkey-core library at: $LIB_PATH" >&2
    echo $LIB_PATH
fi

# set params and variables needes
URL=$1
SSH_CONFIG="$HOME/.ssh/config"

# running validation for existing SSH configuration
gkey_validate_config_exist "$URL" "$SSH_CONFIG" || exit 1
# get username from url
GH_USER=$(gkey_get_user_url "$URL")
# running transformation url
URL_MODIFIED=$(gkey_transform_url "$1" "$SSH_CONFIG" "$GH_USER" | tail -n 1) || exit 1
# cloning repo with ssh in url
git ls-remote "$URL_MODIFIED"

# validation success run of clone repository
if [ $? -eq 0 ]; then
    echo "✅ - Success! - Rrepository cloned successfully."
else
    echo "❌ - Error: There was a problem during cloning."
    exit 1
fi
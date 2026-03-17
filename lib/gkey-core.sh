#! /bin/bash

gkey_validate_config_exist(){
    local url=$1
    local ssh_config=$2
    # validate that exist param url
    if [ -z $1 ]; then
        echo "⚠️ - Use: <url_git>" >&2
        echo "⚠️ - Example: git@github.com:username/repo.git" >&2
        return 1
    fi
    
    # validate that config file exist
    if [ ! -f "$ssh_config" ]; then
        echo "❌ - Error: Could not find configuration file at: $ssh_config" >&2
        return 1
    fi
    return 0
}


gkey_get_user_url(){
    # We extract the GitHub user from the URL between : and /
    local url_original=$1
    local chain_temp=${url_original#*:} # :
    local gh_user=${chain_temp%%/*} # /
    echo $gh_user
}

gkey_transform_url(){
    local url_original=$1
    local ssh_config=$2
    local gh_user=$3

    # Reading the SSH config file to find the correct Host for the GitHub user.
    CURRENT_HOST=""
    while read -r line; do
        # If the line starts with 'Host', update the current Host variable.
        if [[ $line == Host\ * ]]; then
            CURRENT_HOST=$(echo $line | awk '{print $2}')
        fi
        # If the line contains 'User' and matches the GitHub username, save the current Host.
        if [[ $(echo $line | awk '{print $2}') == "$gh_user" ]]; then
            CORRECT_HOST=$CURRENT_HOST
        fi
    done < $ssh_config

    # Verify that a valid Host was found.
    if [ -z "$CORRECT_HOST" ]; then
        echo "❌ - Error: No Host associated with user '$gh_user' found in the configuration file." >&2
        return 1
    fi
    echo "✅ - Success! User '$gh_user' is associated with host '$CORRECT_HOST'" >&2
    URL_MODIFIED=${url_original/github.com/$CORRECT_HOST}
    echo $URL_MODIFIED
}